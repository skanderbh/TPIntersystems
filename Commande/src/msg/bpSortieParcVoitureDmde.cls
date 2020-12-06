Class msg.bpSortieParcVoitureDmde Extends (Ens.Request, %JSON.Adaptor)
{

Property plaque As %String;

Storage Default
{
<Data name="bpSortieParcVoitureDmdeDefaultData">
<Subscript>"bpSortieParcVoitureDmde"</Subscript>
<Value name="1">
<Value>plaque</Value>
</Value>
</Data>
<DefaultData>bpSortieParcVoitureDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
