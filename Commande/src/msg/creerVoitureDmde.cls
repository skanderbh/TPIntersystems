Class msg.creerVoitureDmde Extends Ens.Request
{

Property voiture As webObjet.wsVoiture;

Storage Default
{
<Data name="creerVoitureDmdeDefaultData">
<Subscript>"creerVoitureDmde"</Subscript>
<Value name="1">
<Value>plaque</Value>
</Value>
<Value name="2">
<Value>nom</Value>
</Value>
<Value name="3">
<Value>categorie</Value>
</Value>
<Value name="4">
<Value>voiture</Value>
</Value>
</Data>
<DefaultData>creerVoitureDmdeDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
