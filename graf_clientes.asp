|<!--#include file="con_app.asp"-->
<html>

<head>
<%
vExp=request.QueryString("exp")
if vExp<>"xls" then%>
<link rel="icon" type="image/png" href="./images/icon.ico" />
<title>Mundo Maquinaria</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link href="assets/css/footable.core.css" rel="stylesheet">
<link href="assets/css/bootstrap-select.min.css" rel="stylesheet" />

<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/css/core.css" type="text/css" />
<link rel="stylesheet" href="assets/css/components.css" type="text/css" />
<link rel="stylesheet" href="assets/css/icons.css" type="text/css" />
<link rel="stylesheet" href="assets/css/pages.css" type="text/css" />
<link rel="stylesheet" href="assets/css/responsive.css" type="text/css" />

<!--<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />-->
<link rel="stylesheet" href="assets/css/uniform.css" />
<link rel="stylesheet" href="assets/css/select2.css" />
<link rel="stylesheet" href="assets/css/matrix-media.css" />
<link rel="stylesheet" href="assets/css/matrix-style.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="assets/css/mantenedores.css" />

<link href="assets/css/pages.css" rel="stylesheet" type="text/css" />

<script src="assets/js/modernizr.min.js"></script>

<!-- <script>
          (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','../../../www.google-analytics.com/analytics.js','ga');

          ga('create', 'UA-69506598-1', 'auto');
          ga('send', 'pageview');
    </script> -->
<%end if%>
</head>
<%
'*************************** Inicia Sesion ********************************
if len(session("Identificador")) <> 0 then
    sql="Exec Traer_Sesion '" & session("Identificador") & "'"
	set RsSession = nothing
    Set RsSession = cn.Execute(sql)

    if not RsSession.eof then
        Sesion = RsSession("Sesion2")
        if len(Sesion) = 0 then
            Response.Redirect("./index.asp")
            Response.End
        end if
    else
        Response.Redirect("./index.asp")
        Response.End
    end if
    RsSession.close
    set RsSession = nothing
else
    Response.Redirect("./index.asp")
    Response.End
end if
'***************************  Fin Sesion   ********************************
'************************* Inicia HTTP_REFERER ****************************
Estado_HTTP_REFERER = 0
if len(Request.ServerVariables("HTTP_REFERER")) > 0 then
    sql="Exec Consultar_Paginas '"  & Request.ServerVariables("HTTP_REFERER") & "'"
    set Rs = nothing
    Set Rs = cn.Execute(sql)
    do while not rs.eof
        if instr(1,Request.ServerVariables("HTTP_REFERER"),Rs("Nombre_Pagina")) > 0 then
            Estado_HTTP_REFERER = 1
			exit do
        end if
        rs.movenext
    Loop
    Rs.close
    set Rs = nothing
    'if Estado_HTTP_REFERER = 0 then
    '    Response.Redirect("./index.asp?msg=3")
    '   Response.End
    'end if
else
    Response.Redirect("./index.asp")
    Response.End
end if
'************************** Fin HTTP_REFERER ******************************
%>
<%
if vExp="xls" then
    Response.AddHeader "content-disposition", "attachment; filename=Reporte_Clientes_" & year(now) &"-"& month(now) &"-"& day(now) & "_" & hour(now) & "_" & minute(now) & ".xls"
    Response.ContentType = "application/excel"
end if
%>
<body class="body-graficos">
<%
if vExp<>"xls" then
	vBusca=false
	if trim(request.QueryString("opc"))="sch" then
		'opcion buscar
		vBusca=true
	end if

else
	vBusca=true
	vTxt_Nombre = request.Form("nombre_cli")
	vTxt_Plan   = request.Form("vPlan")
	vTxt_Region = request.Form("vRegion")

end if
%>
<%if vExp<>"xls" then%>
<!--Header-part-->
<div id="header">
</div>
<!--#include file="./menu.asp"-->

<div id="content">
	<div id="content-header">
		<div id="breadcrumb">
			<a href="index.asp" title="Go to Home" class="tip-bottom" style="color:#666666">Inicio</a>
		</div>
		<h1>Informe de Clientes</h1>
	</div>
<%end if%>
	<div class="container-fluid">
	<%if vExp<>"xls" then %>
				<!-- Start content -->
				<form name="form1_crit" action="#" method="post" class="form-horizontal">
				 <div class="control-group" >

					<label class="control-label" style=position:absolute;>Nombre Cliente :</label>
				    <div class="controls">
						<input class="form-control text-box-modal span11" type="text" name="nombre_cli" />
					</div>
					<label class="control-label" style=position:absolute;>Rut :</label>
				    <div class="controls">
						<input class="form-control text-box-modal span11" type="text" name="rut_cli" />
				    </div>
					<label class="control-label" style=position:absolute;>Planes :</label>
					<div class="controls">
						<%

						sql ="exec LISTAPLANES "
						Set rs=nothing
						Set rs = cn.Execute(sql)
						%>
						<select name="vPlan" id="vPlan" class="text-box-modal span11" style="color:#F7931E" value="<%=vPlan%>">
						<%
							response.write "<option value=-1>SELECCIONE PLAN</option>"
							if not rs.eof then
								do while not rs.eof
									if cdbl(rs("id_plan")) = cdbl(vPlan) then
										response.write "<option selected value=" & rs("id_plan") & ">" & ucase(rs("Planes")) & "</option>"
									else

										response.write "<option value=" & rs("id_plan") & ">" & ucase(rs("Planes")) & "</option>"
									end if

									rs.movenext
								loop

							end if
							%>
						</select>
					</div>
					<label class="control-label" style=position:absolute;>Región :</label>
					<div class="controls">
						<%
						sql ="exec Seleccionar_Datos_Comunes "
						sql = sql & "3 "
						Set rs=nothing
						Set rs = cn.Execute(sql)
						%>
						<select name="vRegion" id="vRegion" class="text-box-modal span11" style="color:#F7931E" value="<%=vRegion%>">
						<%
							response.write "<option value=-1>SELECCIONE REGIÓN</option>"
							if not rs.eof then
								do while not rs.eof
									if cdbl(rs("Id_DatosComunes")) = cdbl(vRegion) then
										response.write "<option selected value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
									else
										response.write "<option value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
									end if
									rs.movenext
								loop
							end if
							%>
						</select>
				</div>
        	</div>
			<div class="control-group" >
            <div class="form-actions">
              <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'graf_clientes.asp?opc=sch');">Buscar</button>
			  <button type="submit" class="btn btn-success" onClick="irAFuera(document.forms.form1_crit,'graf_clientes.asp?opc=sch&exp=xls','_blank')">Exportar</button>

            </div>
			</div>

	<%else%>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr class="tituloazul">
		<td colspan="6" align="center"><div align="center">Reporte de Clientes</div></td>
	</tr>
</table>
<%end if%>
          </form>
		<%if vBusca=true then%>
				<div class="row">
							<div class="col-sm-12">
								<div class="card-box">
								<%if vExp<>"xls" then%>

								<%end if%>
									<table id="demo-foo-pagination" class="table table-bordered table-striped with-check" data-page-size="5">
										<thead>
											<tr>
												<th> NOMBRE CLIENTE </th>
												<th> RUT CLIENTE </th>
												<th> DV<br>CLIENTE </th>
												<th> RUBRO </th>
												<th> PLAN </th>
												<th> NOMBRE CONTACTO </th>
												<th> ESTADO </th>
												<th> FECHA CREACION </th>
											</tr>
										</thead>
										<tbody>
											<%
											sql="exec INFORMECLIENTES "
											sql=sql & " '" & request.form("vPlan") & "', "
											sql=sql & " '" & request.form("nombre_cli") & "', "
											sql=sql & " '" & request.form("vRegion") & "', "
											sql=sql & " '" & request.form("rut_cli") & "' "

											set rs = nothing
											Set rs = cn.Execute(sql)

											if not rs.eof then
												Do while not rs.eof

												vNombreCli	= rs("nombreEmpresa")
												vRutCli		= rs("rutEmpresa")
												vDvCli		= rs("rutDvEmpresa")
												vVigencia	= rs("vigencia1")
												vRubro		= rs("Rubro")
												vNomCont	= rs("nombreContacto")
												vPlan		= rs("planes")
												vFecIni		= rs("fec_inicio")

											%>

											<tr>
												<th><%=UCase(vNombreCli)%></th>
												<th><%=UCase(vRutCli)%></th>
												<th><%=UCase(vDvCli)%></th>
												<th><%=UCase(vRubro)%></th>
												<th><%=UCase(vPlan)%></th>
												<th><%=UCase(vNomCont)%></th>
												<th><%=UCase(vVigencia)%></th>
												<th><%=UCase(vFecIni)%></th>

											</tr>

											<%
												if vColor1="#D9EDFD" or vExp="xls" then
													vColor1=""
												else
													vColor1="#D9EDFD"
												end if
												rs.movenext
												loop
											end if%>

										</tbody>
										<tfoot>
											<tr>
												<td colspan="5">
													<div class="text-right">
														<ul class="pagination pagination-split m-t-30"></ul>
													</div>
												</td>
											</tr>
										</tfoot>
									</table>
								</div>
							</div>
						</div>
		<%end if%>

        </div>
</div> <!-- container -->
<%if vExp<>"xls" then%>
<!-- jQuery  -->
<script src="assets2/js/jquery.min.js"></script>
<script src="assets2/js/bootstrap.min.js"></script>
<script src="assets2/js/detect.js"></script>
<script src="assets2/js/fastclick.js"></script>
<script src="assets2/js/jquery.slimscroll.js"></script>
<script src="assets2/js/jquery.blockUI.js"></script>
<script src="assets2/js/waves.js"></script>
<script src="assets2/js/wow.min.js"></script>
<script src="assets2/js/jquery.nicescroll.js"></script>
<script src="assets2/js/jquery.scrollTo.min.js"></script>
<script src="assets2/plugins/peity/jquery.peity.min.js"></script>
<!-- jQuery  -->
<script src="assets2/plugins/waypoints/lib/jquery.waypoints.js"></script>
<script src="assets2/plugins/counterup/jquery.counterup.min.js"></script>
<script src="assets2/plugins/morris/morris.min.js"></script>
<script src="assets2/plugins/raphael/raphael-min.js"></script>
<script src="assets2/plugins/jquery-knob/jquery.knob.js"></script>
<script src="assets2/pages/jquery.dashboard.js"></script>
<script src="assets2/js/jquery.core.js"></script>


<script src="assets/js/jquery.ui.custom.js"></script>
<script src="assets/js/jquery.uniform.js"></script>
<script src="assets/js/select2.min.js"></script>
<script src="assets/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="assets/js/funciones.js"></script>
<script src="assets2/js/modernizr.min.js"></script>
<script src="assets/js/matrix.js"></script>
<script src="assets/js/matrix.tables.js"></script>
<script src="assets2/js/jquery.app.js"></script>
<!--Footer-part-->
<div class="row-fluid footer-graficos">
  <div id="footer" class="span12"> 2017 &copy; Desarrollado por Go4 <a href="http://www.gofour.cl">Gofour.cl</a> </div>
</div>
<!--end-Footer-part-->
<%end if%>
</body>
</html>
