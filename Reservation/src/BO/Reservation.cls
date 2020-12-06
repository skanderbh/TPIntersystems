Class BO.Reservation Extends Ens.BusinessOperation
{

Method creerReservation(pRequest As msg.creerReservationDmde, Output pResponse As msg.creerReservationRpse) As %Status
{
    set pResponse = ##class(msg.creerReservationRpse).%New()

    set sql = "select plaque from data.Voiture where categorie = '"_pRequest.categorie_"' and plaque not in ("
    set sql = sql_" SELECT voiture->plaque FROM data.Reservation where voiture->categorie = '"_pRequest.categorie_"'"
    set sql = sql_" and ((dateDebut >= '"_pRequest.dateDebut_"' and dateDebut <= '"_pRequest.dateFin_"' ) "
    set sql = sql_" or (dateFin >= '"_pRequest.dateDebut_"' and dateFin <= '"_pRequest.dateFin_"' ) "
    set sql = sql_" or (dateDebut <= '"_pRequest.dateDebut_"' and dateFin >= '"_pRequest.dateFin_"' ) "
    set sql = sql_" or (dateDebut >= '"_pRequest.dateDebut_"' and dateFin <= '"_pRequest.dateFin_"' )) "
    set sql = sql_  " ) "

    set statement=##class(%SQL.Statement).%New() 
	do statement.%Prepare(sql)
	set SQLrequest = statement.%Execute()
    do SQLrequest.%Next()
    set plaque = SQLrequest.%Get("plaque")
    $$$TRACE(plaque)
    set tsc = ##class(data.Voiture).consulterParPlaqueExists(plaque , .idVoiture)
    if (tsc) {
        
        $$$TRACE(idVoiture)
        set dataVoiture = ##class(data.Voiture).%OpenId( idVoiture ) 
        $$$TRACE(dataVoiture.plaque)
        set reservation = ##class(data.Reservation).%New()
        set reservation.voiture = dataVoiture
        set reservation.dateDebut = pRequest.dateDebut
        set reservation.dateFin = pRequest.dateFin
        set tsc = reservation.%Save()
        $$$TRACE(tsc)
    }
    else {
        set pResponse.codeRetour = "KO"
        set pResponse.libErreur = "Aucune voiture de cette categorie n'est disponible"
        Quit $$$OK
    }
    
    set pResponse.codeRetour = "OK"

    Quit $$$OK
}

Method verifierReservation(pRequest As msg.verifierReservationDmde, Output pResponse As msg.verifierReservationRpse) As %Status
{
    set pResponse = ##class(msg.verifierReservationRpse).%New()
    set idVoiture = ##class(data.Voiture).consulterParPlaqueExists(pRequest.plaque)

    if '(idVoiture) {
        set pResponse.codeRetour = "KO"
        set pResponse.libErreur = "cette voiture n'existe pas" 
        Quit $$$OK
    }

    set sql = " SELECT voiture from data.Reservation where voiture->plaque = '"_ pRequest.plaque _"'And (dateDebut > GETDATE() OR dateFin > GETDATE()) "

    set statement=##class(%SQL.Statement).%New() 
	do statement.%Prepare(sql)
	set SQLrequest = statement.%Execute()
    do SQLrequest.%Next()
    if (SQLrequest.%Get("voiture")) {
        set pResponse.codeRetour = "KO"
        set pResponse.libErreur = "cette voiture est en cours de reservation" 
    }
    else{
        set pResponse.codeRetour = "OK"
    }

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="msg.creerReservationDmde">
        <Method>creerReservation</Method>
    </MapItem>
    <MapItem MessageType="msg.verifierReservationDmde">
        <Method>verifierReservation</Method>
    </MapItem>
</MapItems>
}

}
