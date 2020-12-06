Class BS.API Extends REST.Base
{

Parameter Version = "1.0.6";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<!-- Server Info -->
<Route Url="/" Method="GET" Call="GetInfo" Cors="true"/>
<!-- Swagger specs -->
<Route Url="/_spec" Method="GET" Call="SwaggerSpec" />

<Route Url="/voiture/" Method="POST" Call="CommanderVoiture" />

<Route Url="/sortir/" Method="POST" Call="SortirVoiture" />
<!-- Créer une voiture-->
<Route Url="/catalogue/" Method="get" Call="GetCatalogue"/>
</Routes>
}

/// PersonsREST general information
ClassMethod GetInfo() As %Status
{
  SET version = ..#Version
  SET info = {
    "version": (version)
  }
  RETURN ..%ProcessResult($$$OK, info)
}

ClassMethod SwaggerSpec() As %Status
{
  Set tSC = ##class(%REST.API).GetWebRESTApplication($NAMESPACE, %request.Application, .swagger)
  Do swagger.info.%Remove("x-ISC_Namespace")
  Set swagger.basePath = "/crud"
  Set swagger.info.title = "InterSystems IRIS REST CRUD demo"
  Set swagger.info.version = "0.1"
  Set swagger.host = "localhost:52773"
  Return ..%ProcessResult($$$OK, swagger)
}

ClassMethod GetCatalogue() As %Status
{
	  #dim tSC As %Status = $$$OK
    Set msg = ##class(msg.getCatalogueDmde).%New()
    set tSC = ##class(Ens.Director).CreateBusinessService("ServiceCatalogue",.tService) if $$$ISERR(tSC) quit 
    set tSC = tService.ProcessInput(msg,.response,"GetCatalogue")

    Set %response.Status = 200
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do response.%JSONExport()

    Quit tSC
}

ClassMethod CommanderVoiture() As %Status
{
    #dim tSC As %Status = $$$OK
    Set msg = ##class(msg.bpGestionCommandeVoitureDmde).%New()
    //On récupére les données de la requête
    Set data = %request.Content
    $$$TOE(tSC,msg.%JSONImport(data))
    set tSC = ##class(Ens.Director).CreateBusinessService("ServiceVoiture",.tService) if $$$ISERR(tSC) quit tSC
    set tSC = tService.ProcessInput(msg,.response,"CommandeVoiture")
c
    Set %response.Status = 200
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do response.%JSONExport()

    Quit tSC
}

ClassMethod SortirVoiture() As %Status
{
    #dim tSC As %Status = $$$OK
    Set msg = ##class(msg.bpSortieParcVoitureDmde).%New()

    Set data=%request.Content
    $$$TOE(tSC,msg.%JSONImport(data))

    set tSC = ##class(Ens.Director).CreateBusinessService("ServiceVoiture",.tService) if $$$ISERR(tSC) quit 
    set tSC = tService.ProcessInput(msg,.response,"SortirVoiture")
    Set %response.Status = 200
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do response.%JSONExport()
    Quit tSC
}

}
