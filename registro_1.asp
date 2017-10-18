<!--#include file="con_app.asp"-->
<!DOCTYPE HTML>
<!--
	Alpha by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<!-- [Renato] : Se comenta llamada de hoja de estilo, ya que no existe. -->
		<!-- <link rel="stylesheet" type="text/css" href="estilo.css" /> --> 
		
		<link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
		<link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
		<link href="assets/css/style.css" rel="stylesheet" />
		<link rel="icon" type="image/png" href="./images/icon.ico" />
		<title>Mundo Maquinaria</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->

		<!-- Start of Smartsupp Live Chat script -->
		<script type="text/javascript">
		var _smartsupp = _smartsupp || {};
		_smartsupp.key = '325d9ce18c74a61710046c22436180a0f9d14ad5';
		window.smartsupp||(function(d) {
			var s,c,o=smartsupp=function(){ o._.push(arguments)};o._=[];
			s=d.getElementsByTagName('script')[0];c=d.createElement('script');
			c.type='text/javascript';c.charset='utf-8';c.async=true;
			c.src='//www.smartsuppchat.com/loader.js?';s.parentNode.insertBefore(c,s);
		})(document);
		</script>
	</head>
	<!-- 	Validaciones JavaScript	-->
	<script type="text/javascript">
function validar_envio(formulario, pagina){

	var Rut 				= document.getElementById('textfield').value;
	var Nombre 				= document.getElementById('textfield2').value;
	var Mail 				= document.getElementById('textfield3').value;
	var NombreContacto 		= document.getElementById('textfield4').value;
	var TelefonoContacto 	= document.getElementById('textfield5').value;

		// Patron para el correo
	var expr
	expr =/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/;
	
	if(Rut == null || Rut.length == 0 || /^\s+$/.test(Rut)){
			alert('ERROR: El campo Rut no debe ir vacío');
			return false;
		}
	if(Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)){
			alert('ERROR: El campo Nombre no debe ir vacío');
			return false;
		}
	if(Mail == null || Mail.length == 0 || /^\s+$/.test(Mail)){
			alert('ERROR: El campo Mail no debe ir vacío');
			return false;
		}
	if(NombreContacto == null || NombreContacto.length == 0 || /^\s+$/.test(NombreContacto)){
			alert('ERROR: El campo NombreContacto no debe ir vacío');
			return false;
		}
	if(TelefonoContacto == null || TelefonoContacto.length == 0 || /^\s+$/.test(TelefonoContacto)){
			alert('ERROR: El campo TelefonoContacto no debe ir vacío');
			return false;
		}
		irA(formulario, pagina);
	
}
</script>
<!--  Ejecuciones sobre botones  -->
<%
if request.QueryString("est") = "1" then
	
	sql="Exec Inserta_Cotizacion "
		sql=sql & request.Form("tipo") & ", "     	 'tipo 
		sql=sql & request.Form("equipo") & ", "      'equipo
		sql=sql & request.Form("familia") & ", " 	 'region
		sql=sql & request.Form("subcatagory") & ", " 'ciudad
		sql=sql & " '" & request.Form("operador") & "', "
		sql=sql & " '" & request.Form("combustible") & "', "
		sql=sql & " '" & request.Form("traslados") & "', "
		sql=sql & " '" & request.Form("mensaje") & "', "
		sql=sql & " '" & request.Form("textfield") & "', "
		sql=sql & " '" & request.Form("textfield4") & "', "
		sql=sql & " '" & request.Form("textfield3") & "', "
		sql=sql & " '" & request.Form("textfield5") & "', "
		sql=sql & " '" & request.Form("textfield2") & "' "
		set Rs = nothing
		Set Rs = cn.Execute(sql)
	
	%>
		<script type="text/javascript">
			alert("Cotizacion agregada exitosamente.");
			window.location="index.asp?rutCotiza=<%=request.Form("textfield")%>";
		</script>
		<%
end if
if request.QueryString("est") = "2" then     
 					
    nombre  = request.Form("textfield")
	mail    = request.Form("textfield2")
	asunto  = request.Form("textfield3")
	mensaje = request.Form("textfield4")
	
	'ENVÍO DEL FORMULARIO DE CONTACTO
	sch = "http://schemas.microsoft.com/cdo/configuration/"
	Set cdoConfig = CreateObject("CDO.Configuration")
	With cdoConfig.Fields
		.Item(sch & "sendusing") = 2
		'.Item(sch & "smtpserverpickupdirectory") = "C:\inetpub\mailroot\pickup" 
		.Item(sch & "smtpserver") = "gofour.cl"
		.Item(sch & "smtpserverport") = 25
		.Item(sch & "smtpconnectiontimeout") = 40
		.Item(sch & "smtpauthenticate") = 1
		.Item(sch & "sendusername") = "guillermo.salazar@gofour.cl"
		.Item(sch & "sendpassword") = "guillermo$661987"
		.update
	End With

	Set MailObject = Server.CreateObject("CDO.Message")
	Set MailObject.Configuration = cdoConfig
	'MailObject.BodyFormat = 0
	'MailObject.mailformat = 0
	MailObject.From	= "guillermo.salazar@gofour.cl"
	MailObject.To	= "angel.salazar@gofour.cl"
	MailObject.To	= "gscarmona1@gmail.com"
	if asunto = "c" then
			MailObject.Subject	= "Contacto"
	elseif asunto = "t" then
		MailObject.Subject	= "Trabaje con Nosotros"
	elseif asunto = "s" then
		MailObject.Subject	= "Sugerencias"
	end if
	'MailObject.Subject = "Contacto - Mundo Maquinaria"
	Cuerpo = "<br><br>Estimado(a) Administrador de Mundo Maquinaria, <br>&nbsp;&nbsp;&nbsp;&nbsp;Se ha registrado un mensaje desde http://www.mundomaquinaria.cl"
	Cuerpo = Cuerpo & " .<br><br>&nbsp;&nbsp;&nbsp;&nbsp;"
	Cuerpo = Cuerpo & "con los siguientes datos: <br><br> nombre:" & nombre & "<br> mail: " & mail & "<br> mensaje: " & mensaje & "</a>"
	Cuerpo = Cuerpo & "<br><br>"
	Cuerpo = Cuerpo & "Atentamente,<br>"
	Cuerpo = Cuerpo & "Web Mundo Maquinaria"
	Cuerpo = Cuerpo & "<br><br><br><br><br><br>Este mensaje ha sido generado automaticamente por favor no responder. Se han omitido intencionalmente los acentos."
	MailObject.HTMLBody = Cuerpo
	MailObject.Send
	Set MailObject = Nothing
	Set cdoConfig = Nothing
		%>
		<script type="text/javascript">
			alert("Mensaje enviado exitosamente.");
			window.location="index.asp";
		</script>
		<%
end if

<!--Inicio Tabla del carrito de compras-->
if request.QueryString("est")= "4" then 
	var_chk_sel=request.form("Id_Cotiza")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)

	Next 
	if len(var_chk_sel) > 0 then
			sql="exec EliminaCotizacion "
			sql=sql & " '" & var_chk_sel & "' "
			
			set Rs = nothing
			Set Rs = cn.Execute(sql)
		%>
		<script type="text/javascript">
			alert("Cotizacion eliminada exitosamente.");
			window.location="index.asp";
		</script>
		<%
    end if			
end if

if request.QueryString("est") = "5" then  
		
		sql="exec ListaMailClientesUsuarioLogo "
		sql=sql & " '" & request.QueryString("rutCotiza") & "' "
		
		set Rs = nothing
		Set Rs = cn.Execute(sql)
		if not rs.eof then
			do while not rs.eof
				vIdCotiza		= rs("idcotiza")
				vNombreUsuario  = rs("nombreusuario")
				vTelefonoUsuario= rs("telefonousuario")
				vMailCotizacion = rs("MailCotizacion")
				vFecha			= rs("fecha")
				vTipoCotiza		= rs("tipocotiza")
				vEquipo			= rs("equipo")
				vRegion			= rs("region")
				vCiudad			= rs("ciudad")
				vOperador		= rs("operador")
				vCombustible	= rs("combustible")
				vTraslados		= rs("traslados")
				vMailUsuario	= rs("mailusuario")
				vMensaje		= rs("mensaje")
				vLogo			= rs("logo")
				vNombreCliente	= rs("nombrecliente")
									
			sch = "http://schemas.microsoft.com/cdo/configuration/"
			Set cdoConfig = CreateObject("CDO.Configuration")
			With cdoConfig.Fields
			.Item(sch & "sendusing") = 2
			.Item(sch & "smtpserver") = "gofour.cl"
			.Item(sch & "smtpserverport") = 25
			.Item(sch & "smtpconnectiontimeout") = 40
			.Item(sch & "smtpauthenticate") = 1
			.Item(sch & "sendusername") = "pruebaMundoMaquinaria@gofour.cl"
			.Item(sch & "sendpassword") = "mm1234"
			.update
			End With

			Set MailObject = Server.CreateObject("CDO.Message")
			Set MailObject.Configuration = cdoConfig
			
			MailObject.From	= vCorreo_Cotizacion
			MailObject.To	= vMailCotizacion & ";" & vMailUsuario
			MailObject.Subject = "Envio de Cotizacion"
			Cuerpo = "<br><br>Estimado(a) Cliente " & vNombreCliente & " de Mundo Maquinaria, <br>&nbsp;&nbsp;&nbsp;&nbsp;Se ha enviado una cotizacion "
			Cuerpo = Cuerpo & "con los siguientes datos: <br><br> Tipo Cotizacion: " & vTipoCotiza & "<br>Nombre: " & vNombreUsuario & "<br> mail: " & vMailUsuario & "<br> Telefono: " & vTelefonoUsuario & "<br> Equipo: " & vEquipo & "</a>"
			Cuerpo = Cuerpo & "<br>Region: " & vRegion & "<br> Ciudad: " & vCiudad & "<br> Mensaje: " & vMensaje  
			Cuerpo = Cuerpo & "<br>Adicionales: <br><br>Con Operador:" & vOperador & "<br> Con Combustible: " & vCombustible & "<br> Con Traslados: " & vTraslados
			Cuerpo = Cuerpo & "<br><br>"
			Cuerpo = Cuerpo & "Atentamente,<br>"
			Cuerpo = Cuerpo & "Web Mundo Maquinaria"
			Cuerpo = Cuerpo & "<br><br><br><br><br><br>Este mensaje ha sido generado automaticamente por favor no responder. Se han omitido intencionalmente los acentos."
			
			MailObject.HTMLBody = Cuerpo
			MailObject.Send
			Set MailObject = Nothing
			Set cdoConfig = Nothing
			
			'ACTUALIZA EL ESTADO A 0 DE LA TABLA COTIZACION
			sql="exec ActualizaEstadoCotizacion "
			sql=sql & " '" & vIdCotiza & "' "
			set Rs1 = nothing
			Set Rs1 = cn.Execute(sql)
			
			rs.movenext
			loop
		end if
		%>
		<script type="text/javascript">
			alert("Sus cotizaciones fueron enviadas a nuestros distintos proveedores. Favor espere a que el/ellos lo contacten.");
			window.location="index.asp";
		</script>
		<%
		
end if
%>
<%
	sql="exec ListarDatosUsuarioPorRut "
	sql=sql & " '" & request.QueryString("rutCotiza") & "' "

	set Rs = nothing
	Set Rs = cn.Execute(sql)
	if not rs.eof then

		vRut2			= rs("rut")
		vNombre			= rs("nombre")
		vMail			= rs("mail")
		vTelefono		= rs("telefono")

	end if
%>
	<body class="landing">
		<div id="page-wrapper">

			<!-- Header -->
				<header id="header" class="alt header-registro">
					
					<h1><a href="index.asp"><img src="./images/logo_chico.png" /></a></h1>
					<div class="form-group" style="height: 15%;">
					<nav id="nav">
								
						<ul>
							<!-- [Renato] : Inicio -->
							<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" viewBox="0 0 50 50" x="0px" y="0px" width="32px" height="32px" enable-background="new 0 0 50 50" class="svg-icon-user">
								<circle class="svg-icon-user-c" cx="25" cy="25" fill="none" r="24" stroke="#f7931e" stroke-linecap="round" stroke-miterlimit="10" stroke-width="2"></circle>
								<path class="svg-icon-user-p" d="M29.933,35.528c-0.146-1.612-0.09-2.737-0.09-4.21c0.73-0.383,2.038-2.825,2.259-4.888c0.574-0.047,1.479-0.607,1.744-2.818  c0.143-1.187-0.425-1.855-0.771-2.065c0.934-2.809,2.874-11.499-3.588-12.397c-0.665-1.168-2.368-1.759-4.581-1.759  c-8.854,0.163-9.922,6.686-7.981,14.156c-0.345,0.21-0.913,0.878-0.771,2.065c0.266,2.211,1.17,2.771,1.744,2.818  c0.22,2.062,1.58,4.505,2.312,4.888c0,1.473,0.055,2.598-0.091,4.21c-1.261,3.39-7.737,3.655-11.473,6.924  c3.906,3.933,10.236,6.746,16.916,6.746s14.532-5.274,15.839-6.713C37.688,39.186,31.197,38.93,29.933,35.528z" 
									fill="#f7931e">
								</path>
							</svg>
							<!-- [Renato] : Fin -->
							<li>
								<button class="button btn-entrar" style="background:#3B5998" data-toggle="modal" data-target="#myModal1">
								ENTRAR
							</button>
							<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<script type="text/javascript">
								function validacion(formulario, pagina)
								{
									if(formulario.user_rut.value=="" || formulario.passw.value=="" )
									{
										alert("Para Continuar debe Completar los datos de Ingreso");
										return false;
									}
									
										irA(formulario, pagina);
									
								}
							</script>
								<form name="formLogin" method="post" >
								<div class="modal-dialog">
								
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">Inicio Sesión</h4>
										</div>
										<div class="modal-body">
											<div class="form-group">
											<label>Rut</label>
											<input class="form-control text-box-modal" type="text" name="user_rut" pattern="[0-9]|k"/>
										</div>
										<div class="form-group">
											<label>Contraseña</label>
											<input class="form-control text-box-modal" type="password" name="passw"/>
										</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-modal" onClick="javascript:validacion(document.forms.formLogin,'login2.asp?opc=in');">Ingresar</button>
										</div>
									</div>
									
								</div>
								</form>
							</div>
							</li>
							<li>
							    <div class="btn-header">
								<button type="button" class="button btn-entrar" style="background:#F7931E" data-toggle="modal" data-target="#myModal2">
									PUBLICA TU MAQUINA AQUÍ
								</button>
                                                                </div>
								<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<form name="formReg1" method="post" >
									<div class="modal-dialog">
									
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">PUBLICA TU MAQUINA AQUÍ</h4>
											</div>
											<div class="modal-body ">
												<div class="form-group">
													<label>RUT</label>
													<input class="form-control text-box-modal" type="text" style="color:#F7931E"id ="textfield" name="textfield" value="<%=vRut%>"/>
												</div>
												<div class="form-group">
													<label>RAZÓN SOCIAL / NOMBRE</label>
													<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="textfield2" name="textfield2" value="<%=vNombre%>"/>
												</div>
												<div class="form-group">
													<label>CORREO</label>
													<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="textfield3" name="textfield3" value="<%=vMail%>"/>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-modal" style="background:#F7931E" onClick="javascript:irA(document.forms.formReg1,'Registro.asp');">Cotizar</button>
											</div>
									</div>
										
									</div>
									</form>
								</div>
							</li>
						</ul>
					</nav>
					</div>
					<!-- [Renato] : Inicio -->
					<div class="form-group">
						<nav id="nav2" style="display: none;"></nav>
					</div>
					<!-- [Renato] : Fin -->
				</header>

			<!-- Banner -->
			<section id="banner" class="ban-registro">
				<div class="col-md-12">
					<div class="col-md-12">
						<h3>Seleccione uno de nuestros tipos de planes.</h3> </br>
					</div>
					<div class="row col-md-12">
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg1" action="#" method="post">
								<h3 style="font-weight:bold; color:#3B5998;">Mensuales</h4>
								<hr>
								<h4 style="font-weight:bold; color:#3B5998;">desde $35.000 + IVA</h4>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg1,'Registro.asp?tip=1&reg=1');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg2" action="#" method="post">
								<h3 style="font-weight:bold; color:#3B5998;">Semestrales</h4>
								<hr>
								<h4 style="font-weight:bold; color:#3B5998;">desde $29.000 + IVA</h4>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg2,'Registro.asp?tip=2&reg=1');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg3" action="#" method="post">
								<h3 style="font-weight:bold; color:#3B5998;">Anuales</h4>
								<hr>
								<h4 style="font-weight:bold; color:#3B5998;">desde $27.000 + IVA</h4>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg3,'Registro.asp?tip=3&reg=1');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
					</div>
					<div id="planes" class="row col-md-12" style="height: 50px;"></div>
					<!-- <section id="banner"> -->
						<div class="row col-md-12">
							<%if request.QueryString("reg")= "1" then
								if request.QueryString("tip")= "1" then
									sql="exec MantenedorPlanes 1 , -1 , 38, '' , 0 ,'','','','',0, 0, 0 "
								elseif request.QueryString("tip")= "2" then
									sql="exec MantenedorPlanes 1 , -1 , 39, '' , 0 ,'','','','',0, 0, 0 "
								else 
									sql="exec MantenedorPlanes 1 , -1 , 40, '' , 0 ,'','','','',0, 0, 0 "
								end if
							set rs = nothing
							Set rs = cn.Execute(sql)
							if not rs.eof then
								do while not rs.eof
							%>			
							<div class="col-md-3">
								<div class="box special box-mm">
									<h3><%=rs("Nombre")%></h3>
									<h5><%=rs("descripcion")%></h5>
									<h5><%=rs("desc2")%></h5>
									<h5><%=rs("desc3")%></h5>
									<% if rs("desc4") <> "" then %>
										<h5><%=rs("desc4")%></h5>
									<%end if%>
									<h4>$ <%=formatnumber(rs("valor"),0)%></h4>
									<ul class="actions">
										<button class="button fit small" style="background:#F7931E" data-toggle="modal" data-target="#myModal3">
											CONTRATAR
										</button>
									</ul>
								</div>
							</div>					
						
						<%
						rs.movenext
						loop
						%>
						</div>
					<!-- </section> -->
						<%
						end if
						end if
						%>
				</div>
			</section>
			<!-- Footer -->
				<footer id="footer">
					<ul class="icons">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<li><a href="https://twitter.com/mundomaquinaria" class="icon fa-twitter" ><span class="label">Twitter</span></a></li>
						<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
						<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
						<section><img src="images/qr_img.png" style="float:right;">&nbsp;&nbsp;&nbsp;&nbsp;</section>
					</ul>
					<ul class="copyright">
						<li>&copy; Todos los derechos reservados.</li><li>Diseñado por: <a href="http://gofour.cl">Go Four</a></li>
					</ul>
					
				</footer>

		</div>

		<!-- Scripts -->
			<script src="assets/js/jquery-1.10.2.js"></script>
			<script src="assets/js/bootstrap.js"></script>
			<script src="assets/js/custom.js"></script>
			
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.dropotron.min.js"></script>
			<script src="assets/js/jquery.scrollgress.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>
			<script type="text/javascript" src="assets/js/funciones.js"></script>

	</body>
	<script>
		$(document).ready(function(){
			var tipParam = $.getURLParam("tip");
			var regParam = $.getURLParam("reg");
			if (tipParam != null && regParam != null ) {
				goToByScroll("planes");
			}
		});
	</script>
</html>