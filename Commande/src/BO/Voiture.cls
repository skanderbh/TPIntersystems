Class BO.Voiture Extends Ens.BusinessOperation
{

Property Adapter As Ens.OutboundAdapter;

Parameter ADAPTER = "Ens.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method creerVoiture(pRequest As msg.creerVoitureDmde, Output pResponse As msg.creerVoitureRpse) As %Status
{
    
    set pResponse = ##class(msg.creerVoitureRpse).%New()
    set voiture = ##class(data.Voiture).%New()
    do ##class(Transform.WsVoitureToVoiture).Transform(pRequest.voiture,.voiture)
    set tsc = voiture.%Save()

    set pResponse.codeRetour = "OK"

    Quit $$$OK
}

Method supprimerVoiture(pRequest As msg.supprimerVoitureDmde, Output pResponse As msg.supprimerVoitureRpse) As %Status
{
    
    set pResponse = ##class(msg.supprimerVoitureRpse).%New()
    
    if (##class(data.Voiture).consulterParPlaqueExists( pRequest.plaque , .id )){
        set tsc = ##class(data.Voiture).%DeleteId(id)
        if (tsc) { 
            set pResponse.codeRetour = "OK" 
        }
        else {
            set pResponse.codeRetour = "KO"
        }
    }
    else {
        set pResponse.codeRetour = "KO"
        set pResponse.libErreur = "La voiture n'existe pas"
    }
    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="msg.creerVoitureDmde">
        <Method>creerVoiture</Method>
    </MapItem>
    <MapItem MessageType="msg.supprimerVoitureDmde">
        <Method>supprimerVoiture</Method>
    </MapItem>
</MapItems>
}

}
