Class msg.Reservation.verifierReservationDmde Extends (Ens.Request, %JSON.Adaptor)
{

Property plaque As %String;

Storage Default
{
<Data name="verifierReservationDmdeDefaultData">
<Subscript>"verifierReservationDmde"</Subscript>
<Value name="1">
<Value>plaque</Value>
</Value>
</Data>
<DefaultData>verifierReservationDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
