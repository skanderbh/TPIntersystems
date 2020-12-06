/// 
Class BP.GestionCommandeVoiture Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='msg.bpGestionCommandeVoitureDmde' response='msg.bpGestionCommandeVoitureRpse' height='2000' width='2000' >
<context>
<property name='plaque' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='nbPlace' type='%Integer' instantiate='0' />
<property name='wsCatalogue' type='webObjet.wsCatalogue' instantiate='0' />
<property name='wsVoiture' type='webObjet.wsVoiture' instantiate='0' />
</context>
<sequence xend='200' yend='1250' >
<call name='VerifCatalogue' target='Catalogue' async='0' xpos='200' ypos='250' >
<request type='msg.consulterVoitureCatalogueDmde' >
<assign property="callrequest.marque" value="request.marque" action="set" />
<assign property="callrequest.modele" value="request.modele" action="set" />
</request>
<response type='msg.consulterVoitureCatalogueRpse' >
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
<assign property="context.nbPlace" value="callresponse.voiture.nbPlaces" action="set" />
<assign property="context.wsCatalogue.marque" value="callresponse.voiture.marque" action="set" />
<assign property="context.wsCatalogue.modele" value="callresponse.voiture.modele" action="set" />
<assign property="context.wsCatalogue.type" value="callresponse.voiture.type" action="set" />
<assign property="context.wsCatalogue.prix" value="callresponse.voiture.prix" action="set" />
<assign property="context.wsCatalogue.nbPlaces" value="callresponse.voiture.nbPlaces" action="set" />
</response>
</call>
<if name='OK ?' condition='response.codeRetour = "OK"' xpos='200' ypos='350' xend='200' yend='1150' >
<true>
<call name='Plaque' target='Plaque' async='0' xpos='335' ypos='500' >
<request type='msg.generationPlaqueDmde' />
<response type='msg.generationPlaqueRpse' >
<assign property="context.plaque" value="callresponse.plaque" action="set" />
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
</response>
</call>
<transform name='Transform' class='Transform.wsCommandeToWsVoiture' source='context.wsCatalogue' target='context.wsVoiture' xpos='335' ypos='600' />
<call name='CreerVoiture' target='Voiture' async='0' xpos='335' ypos='700' >
<request type='msg.creerVoitureDmde' >
<assign property="callrequest.voiture.plaque" value="context.plaque" action="set" />
<assign property="callrequest.voiture.marque" value="context.wsVoiture.marque" action="set" />
<assign property="callrequest.voiture.modele" value="context.wsVoiture.modele" action="set" />
<assign property="callrequest.voiture.categorie" value="context.wsVoiture.categorie" action="set" />
<assign property="callrequest.voiture.nbPlaces" value="context.wsVoiture.nbPlaces" action="set" />
<assign property="callrequest.voiture.couleur" value="request.couleur" action="set" />
</request>
<response type='msg.creerVoitureRpse' >
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
</response>
</call>
<if name='OK ?' condition='response.codeRetour = "OK"' xpos='335' ypos='800' xend='335' yend='1050' >
<true>
<call name='File' target='File' async='0' xpos='470' ypos='950' >
<request type='msg.pushVoitureFileDmde' >
<assign property="callrequest.voiture.plaque" value="context.plaque" action="set" />
<assign property="callrequest.voiture.marque" value="context.wsVoiture.marque" action="set" />
<assign property="callrequest.voiture.nbPlaces" value="context.wsVoiture.nbPlaces" action="set" />
<assign property="callrequest.voiture.modele" value="context.wsVoiture.modele" action="set" />
<assign property="callrequest.voiture.couleur" value="context.wsVoiture.couleur" action="set" />
<assign property="callrequest.voiture.categorie" value="context.wsVoiture.categorie" action="set" />
</request>
<response type='Ens.Response' />
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
