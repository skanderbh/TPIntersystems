Class BS.ServiceVoiture Extends Ens.BusinessService
{

/// Name of the WebService
Parameter SERVICENAME = "ServiceVoiture";

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject, ByRef pHint As %String) As %Status
{
    set tsc = $CASE(pHint,
        "CommandeVoiture":..CommandeVoiture(pInput,.pOutput),
        "SortirVoiture":..sortirVoiture(pInput,.pOutput),
	 	: $$$ERROR($$$NotImplemented)
    )
    Quit tsc
}

Method CommandeVoiture(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
    set tsc = ..SendRequestSync("GestionCommandeVoiture",pInput,.pOutput)
    Quit $$$OK
}

Method sortirVoiture(pInput As %RegisteredObject, Output pOutput As %RegisteredObject) As %Status
{
    set tsc = ..SendRequestSync("SortieParcVoiture",pInput,.pOutput)
    Quit $$$OK
}

}
