<!--#include file="con_app.asp"-->

<html>
<head>
<link rel="icon" type="image/png" href="./images/icon.ico" />
<title>Mundo Maquinaria</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="assets/css/uniform.css" />
<link rel="stylesheet" href="assets/css/select2.css" />
<link rel="stylesheet" href="assets/css/matrix-style.css" />
<link rel="stylesheet" href="assets/css/matrix-media.css" />
<link rel="stylesheet" href="assets/css/mantenedores.css" />
<link rel="stylesheet" href="assets/css/style.css" />
<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
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
    Response.Redirect("./index.asp?msg=4")
    Response.End
end if
'************************** Fin HTTP_REFERER ******************************
%>
<body>

<!--Header-part-->
<div id="header">
</div>
<!--#include file="./menu.asp"-->
<div id="content">
<div id="content-header">
  <div id="messageDiv" class="col-md-12" style="display: none;">
		<button type="button" class="close" data-dismiss="modal" onclick="ocultarMessage()" aria-hidden="true">×</button>
		<br />
		<p>message</p>
	</div>
  <div id="breadcrumb"> <a href="index.asp" title="Go to Home" class="tip-bottom" style="color:#666666"><i class="icon-home"></i> Inicio </a></div>
  <h1>Mantenedor de Clientes - Revisa tu plan</h1>
</div>
<%if request.QueryString("opc")= "sav" then 
	sql="exec ActualizaCliente "
	sql=sql & " " & request.form("Idcliente") & ","
	sql=sql & "'" & request.form("nombre") & "', "
	sql=sql & "'" & request.form("rut") & "', "
	sql=sql & "'" & request.form("dv") & "', "
	sql=sql & " 1, "  'vigencia
	sql=sql & "'" & request.form("direccion") & "', "
	sql=sql & "'" & request.form("rubro") & "'," 
	sql=sql & "'" & request.form("NomContacto") & "'," 
	sql=sql & "'" & request.form("mailcontacto") & "'," 
	sql=sql & "'" & request.form("telefonocontacto") & "'," 
	sql=sql & "'" & request.form("cargocontacto") & "'," 
	sql=sql & "'" & request.form("mailcotizacion") & "'" 
	
	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Datos Modificados Exitosamente', 'success');
		window.location="act_dat.asp?msg=1";
	</script>
	<%
end if
		
sql="exec ListarCiente_Id "
sql=sql & " " & session("id_usuario") & " "

set rs = nothing
Set rs = cn.Execute(sql)

if not rs.eof then
	vIdCliente	= rs("Idcliente")
	vNombre		= rs("nombreEmpresa")
	vRut  		= rs("rutEmpresa")
	vDv			= rs("rutDvEmpresa")
	vDireccion	= rs("direccion")
	vRubro		= rs("rubro")
	vNomContacto	= rs("nombrecontacto")
	vMailContacto	= rs("mailcontacto")
	vTelefonoContacto	= rs("telefonocontacto")
	vCargoContacto	= rs("cargocontacto")
	vMailCotizacion	= rs("mailcotizacion")
%>
<div class="container-fluid">
  <hr>
  <div class="row-fluid">
       <div class="widget-content nopadding">
             <div class="container-fluid">
   <div class="row-fluid">
    <div class="span4">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Este es su plan contratado</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit" method="post" class="form-horizontal">
				<div id="planes" class="host_plans">
					<div class="container">
						<div class="one_fourth_less">
							<div class="planbox">
							<%
							sql="exec ClientePlan "
							sql=sql & " " & session("id_usuario") & " "

							set rs = nothing
							Set rs = cn.Execute(sql)
							if not rs.eof then %>
							<%end if%>	
								<div class="title"><h4 class="caps"><strong><%=rs("Nombre")%></strong></h4></div>
						
								<div class="prices">
									<strong>$<%=formatnumber(rs("valor"),0)%><i>/mes</i></strong>+ IVA</br></br>
								</div>
						
								<ul style="list-style: none;">
									<li><strong><%=rs("desc2")%></strong></li>
									<li><strong><%=rs("descripcion")%></strong></li>
									<li><strong><%=rs("desc3")%></strong></li>
									<% if rs("desc4") <> "" then %>
									<li><strong><%=rs("desc4")%></strong></li>
									<%end if%>
								</ul>
						
							</div>
						</div><!-- end plan -->
					</div>
				</div>
				<!-- <div>
			  <section id="banner">
				<div >
					<div >
					<%
					sql="exec ClientePlan "
					sql=sql & " " & session("id_usuario") & " "

					set rs = nothing
					Set rs = cn.Execute(sql)
					if not rs.eof then %>
						<section class="box special">
							<h4 style="font-weight:bold; color:#3B5998;"><img src="images/check.png">	<%=rs("Nombre")%></h5>
							<h4 style="font-weight:bold; color:#3B5998;"><img src="images/check.png">	<%=rs("descripcion")%></h4>
							<h4 style="font-weight:bold; color:#3B5998;"><img src="images/check.png">	<%=rs("desc2")%></h4>
							<h4 style="font-weight:bold; color:#3B5998;"><img src="images/check.png">	<%=rs("desc3")%></h4>
							<% if rs("desc4") <> "" then %>
								<h4 style="font-weight:bold; color:#3B5998;"><img src="images/check.png">	<%=rs("desc4")%></h4>
							<%end if%>
							<h4 style="font-weight:bold; color:#3B5998;"><img src="images/check.png">	<%=formatnumber(rs("valor"),0)%></h4>
					<%end if%>	
					</div>					
				</div>
					</section>
				</div> -->
          </form>
        </div>

      </div>
      
    </div>
  </div>
  
</div>
        </div>
    </div>

</div>
<%end if%>
</div>

<!--Footer-part-->
<div class="row-fluid">
  <div id="footer" class="span12"> 2017 &copy; Desarrollado por Go4 <a href="http://www.gofour.cl">Gofour.cl</a> </div>
</div>
<!--end-Footer-part--> 
<script src="assets/js/jquery.min.js"></script> 
<script src="assets/js/jquery.ui.custom.js"></script>
<script src="assets/js/bootstrap.min.js"></script> 
<script src="assets/js/jquery.uniform.js"></script> 
<script src="assets/js/select2.min.js"></script>  
<script src="assets/js/jquery.dataTables.min.js"></script>
<script src="assets/js/matrix.js"></script> 
<script src="assets/js/matrix.tables.js"></script>
	<script type="text/javascript" src="assets/js/funciones.js"></script>
</script>
<script type="text/javascript">
	$(document).ready(function(){
		var mensaje = $.getURLParam("msg");
		if (mensaje != null) {
			if (mensaje == 1) {
				mostrarMensaje('Datos Modificados Exitosamente', 'success');
			}
		}
	});
</script>
<style>
		#banner :last-child {
			margin-bottom: 0px !important;
		}
		.host_plans .planbox li {
			color: #f7931e !important;
		}
		.host_plans .planbox li strong {
			color: #f7931e !important;
		}
		.host_plans .planbox .prices {
			padding: 27px 0px 0px 0px !important;
		}
		.host_plans {
			padding: 0px 0px !important;
		}
	</style>
</body>
</html>
