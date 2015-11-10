module language/myTaxiService
//SIGNATURES
sig Guest{}

sig User extends Guest {
	reservation: lone Reservation,
	requests: set Request
}

sig Driver extends User{
	car: one TaxiCar
}

sig TaxiCar{
	currentDriver: lone Driver
}

sig Reservation{
	driver: one Driver,
	passenger: one User
}

sig Request extends Reservation{}


sig Zone{
	drivers: set Driver
}


//FACTS

fact noSameDriverPerCar{
	no d:Driver | some t1,t2: TaxiCar |
	t1!=t2 and d in t1.currentDriver and d in t2.currentDriver
}

fact connectionCarDriver{
	all t:TaxiCar | all d:Driver | t in d.car => t.currentDriver=d
}

fact differentCarsTwoDrivers{
	no t:TaxiCar | some d1,d2: Driver | d1!=d2 and d1.car=t and d2.car=t
}

fact differentCarsTwoDrivers1{
	all d:Driver | all t:TaxiCar | d in t.currentDriver => t in d.car
}

fact NoDriverAPassenger{
	no u:Driver | some res:Reservation | u in res.passenger
}

fact diffDriversPerReservation{
	all res1, res2:Reservation | some d1,d2:Driver | (d1 in res1.driver and d2 in res2.driver) => (d1!=d2)
}

fact diffUsersPerReservation{
	all res1,res2:Reservation | some u1,u2:User | (u1 in res1.passenger and u2 in res2.passenger) => (u1!=u2)
}

fact oneZonePerDriver{
	all d:Driver | one z:Zone | d in z.drivers
}

//PREDICATES
pred show{
#Guest=8
#User=7
#Driver=6
#Request=2
#Reservation=3
#Zone=2
#TaxiCar=7
}
run show for 20
