Class BO.Reservation Extends EnsLib.REST.Operation
{

Property Adapter As EnsLib.HTTP.OutboundAdapter;

Parameter ADAPTER = "EnsLib.HTTP.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method creerVoiture(pRequest As msg.creerVoitureDmde, Output pResponse As msg.creerVoitureRpse) As %Status
{
    set pResponse = ##class(msg.creerVoitureRpse).%New()

    set httpRequest = ##class(%Net.HttpRequest).%New()

    set request = ##class(msg.Reservation.creerVoitureDmde).%New()

    set request.nom = pRequest.voiture.marque_" "_pRequest.voiture.modele
    set request.categorie = pRequest.voiture.categorie
    set request.plaque = pRequest.voiture.plaque

    do ..ObjectToJSONStream(request, .EntityBody)

    set httpRequest.EntityBody = EntityBody

    set tsc = ..Adapter.SendFormDataArray(.httpResponse, "POST", httpRequest)

    do ..JSONStreamToObject(httpResponse.Data,.pResponse,"msg.creerVoitureRpse",1)

    Quit $$$OK
}

Method verifierReservation(Request As msg.Reservation.verifierReservationDmde, Output pResponse As msg.verifierReservationRpse) As %Status
{
    
    set pResponse = ##class(msg.verifierReservationRpse).%New()

    set httpRequest = ##class(%Net.HttpRequest).%New()

    do ..ObjectToJSONStream(Request, .EntityBody)

    set url = ..Adapter.URL
    set ..Adapter.URL = url _ "verifierReservation/"

    $$$TRACE(..Adapter.URL)

    set httpRequest.EntityBody = EntityBody

    set tsc = ..Adapter.SendFormDataArray(.httpResponse, "POST", httpRequest)
    $$$TRACE(tsc)

    do ..JSONStreamToObject(httpResponse.Data,.pResponse,"msg.verifierReservationRpse",1)

    set ..Adapter.URL = url

    Quit $$$OK
}

Method supprimerVoiture(Request As msg.Reservation.supprimerVoitureDmde, Output pResponse As msg.supprimerVoitureRpse) As %Status
{
    set pResponse = ##class(msg.supprimerVoitureRpse).%New()

    set httpRequest = ##class(%Net.HttpRequest).%New()

    do ..ObjectToJSONStream(Request, .EntityBody)

    set url = ..Adapter.URL
    set ..Adapter.URL = url _ "supprimerVoiture/"

    $$$TRACE(..Adapter.URL)

    set httpRequest.EntityBody = EntityBody

    set tsc = ..Adapter.SendFormDataArray(.httpResponse, "POST", httpRequest)
    $$$TRACE(tsc)

    do ..JSONStreamToObject(httpResponse.Data,.pResponse,"msg.supprimerVoitureRpse",1)

    set ..Adapter.URL = url

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="msg.Reservation.creerVoitureDmde">
        <Method>creerVoiture</Method>
    </MapItem>
    <MapItem MessageType="msg.Reservation.verifierReservationDmde">
        <Method>verifierReservation</Method>
    </MapItem>
     <MapItem MessageType="msg.Reservation.supprimerVoitureDmde">
        <Method>supprimerVoiture</Method>
    </MapItem>
</MapItems>
}

}
