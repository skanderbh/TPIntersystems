/// 
Class BP.SortieParcVoiture Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='msg.bpSortieParcVoitureDmde' response='msg.bpSortieParcVoitureRpse' height='2000' width='2000' >
<sequence xend='200' yend='1050' >
<call name='verifReservation' target='Reservation' async='0' xpos='200' ypos='250' >
<request type='msg.Reservation.verifierReservationDmde' >
<assign property="callrequest.plaque" value="request.plaque" action="set" />
</request>
<response type='msg.verifierReservationRpse' >
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
</response>
</call>
<if name='OK ?' condition='response.codeRetour = "OK"' xpos='200' ypos='350' xend='200' yend='950' >
<true>
<call name='supprimerVoitureReservation' target='Reservation' async='0' xpos='335' ypos='500' >
<request type='msg.Reservation.supprimerVoitureDmde' >
<assign property="callrequest.plaque" value="request.plaque" action="set" />
</request>
<response type='msg.supprimerVoitureRpse' >
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
</response>
</call>
<if name='OK ?' condition='response.codeRetour = "OK"' xpos='335' ypos='600' xend='335' yend='850' >
<true>
<call name='supprimerVoiture' target='Voiture' async='0' xpos='470' ypos='750' >
<request type='msg.supprimerVoitureDmde' >
<assign property="callrequest.plaque" value="request.plaque" action="set" />
</request>
<response type='msg.supprimerVoitureRpse' >
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
</response>
</call>
</true>
</if>
</true>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
