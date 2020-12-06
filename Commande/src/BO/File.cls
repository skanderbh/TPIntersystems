Class BO.File Extends Ens.BusinessOperation
{

Property Adapter As EnsLib.File.OutboundAdapter;

Parameter ADAPTER = "EnsLib.File.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method pushVoitureFile(pRequest As msg.pushVoitureFileDmde, Output pResponse As msg.pushVoitureFileRpse) As %Status
{
    
        set pResponse = ##class(msg.pushVoitureFileRpse).%New()

        Set stream=##class(%FileBinaryStream).%New()
        
        do stream.WriteLine(pRequest.voiture.marque_";"_pRequest.voiture.modele_";"_pRequest.voiture.categorie_";"_pRequest.voiture.plaque_";"_pRequest.voiture.couleur_";"_pRequest.voiture.nbPlaces)

        Set tSC= ..Adapter.PutStream( "voitureFile.csv" ,stream )

        if (tSC) {
            set pResponse.codeRetour = "OK"
        }
        else {
            set pResponse.codeRetour = "OK"
        }

        Quit tSC
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="msg.pushVoitureFileDmde">
        <Method>pushVoitureFile</Method>
    </MapItem>
</MapItems>
}

}
