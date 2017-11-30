<!--#include file="con_app.asp"-->
<!DOCTYPE HTML>
<!--
	Alpha by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
	<%
		Response.CodePage = 65001
		Response.CharSet = "utf-8"
		%>
		<link href="assets/css/bootstrap.css" rel="stylesheet" />
		<link href="assets/css/font-awesome.css" rel="stylesheet" />
		<link href="assets/css/style.css" rel="stylesheet" />
		<link rel="icon" type="image/png" href="./images/icon.ico" />
		<title>Mundo Maquinaria</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<link rel="stylesheet" href="assets/css/reset.css" type="text/css">
		<link rel="stylesheet" href="assets/css/style.css" type="text/css">

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
vRut = request.QueryString("rut")
vNombre = request.QueryString("nombre")
vMail = request.QueryString("mail")
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
												<button type="button" class="btn btn-modal" style="background:#F7931E" onClick="javascript:irA(document.forms.formReg1,'Registro.asp?rut=<%=vRut%>&nom=<%=vNombre%>&mail=<%=vMail%>');">Cotizar</button>
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
						<%if request.QueryString("tip")=0 then%>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg1" action="#" method="post">
								<h3 style="font-size: 17px; font-weight: 600;">Arriendo</h4>
								<hr>
								<h4 style="font-size: 17px; font-weight: 600;">desde $27.000 + IVA</h4>
								<h6 style="font-size: 17px; font-weight: 600;">*valor mensual en plan anual</h6>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg1,'Registro.asp?tip=4&vIdPlan=38&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg2" action="#" method="post">
								<h3 style="font-size: 17px; font-weight: 600;">Servicio Técnico</h4>
								<hr>
								<h4 style="font-size: 17px; font-weight: 600;">*desde $21.990 + IVA</h4>
								<h6 style="font-size: 17px; font-weight: 600;">*valor mensual en plan anual</h6>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg2,'Registro.asp?tip=5&vIdPlan=39&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg3" action="#" method="post">
								<h3 style="font-size: 17px; font-weight: 600;">Rental + ST</h4>
								<hr>
								<h4 style="font-size: 17px; font-weight: 600;">*desde $39.990 + IVA</h4>
								<h6 style="font-size: 17px; font-weight: 600;">*valor mensual en plan anual</h6>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg3,'Registro.asp?tip=6&vIdPlan=40&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<%end if%>
						<%if request.QueryString("tip")=4 then%>
							<div class="col-md-4">
							<div class="box special">
								<form name="form_reg1" action="#" method="post">
								<h3 style="font-size: 17px; font-weight: 600;">Mensuales</h4>
								<hr>
								<h4 style="font-size: 17px; font-weight: 600;">desde $35.000 + IVA</h4>
								<h6 style="font-weight:bold; color:#FFF;">_</h6>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg1,'Registro.asp?tip=1&vTipPlan=2362&vIdPlan=38&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg2" action="#" method="post">
								<h3 style="font-size: 17px; font-weight: 600;">Semestrales</h4>
								<hr>
								<h4 style="font-size: 17px; font-weight: 600;">*desde $29.000 + IVA</h4>
								<h6 style="font-size: 17px; font-weight: 600;">*valor mensual en plan semestral</h6>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg2,'Registro.asp?tip=2&vTipPlan=2362&vIdPlan=39&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg3" action="#" method="post">
								<h3 style="font-size: 17px; font-weight: 600;">Anuales</h4>
								<hr>
								<h4 style="font-size: 17px; font-weight: 600;">*desde $27.000 + IVA</h4>
								<h6 style="font-size: 17px; font-weight: 600;">*valor mensual en plan anual</h6>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg3,'Registro.asp?tip=3&vTipPlan=2362&vIdPlan=40&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<%elseif request.queryString("tip")=5 then%>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg1" action="#" method="post">
								<h3 style="font-size: 17px; font-weight: 600;">Mensuales</h4>
								<hr>
								<h4 style="font-size: 17px; font-weight: 600;">desde $28.000 + IVA</h4>
								<h6 style="font-size: 17px; font-weight: 600;">_</h6>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg1,'Registro.asp?tip=1&vTipPlan=2363&vIdPlan=38&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg2" action="#" method="post">
								<h3 style="font-size: 17px; font-weight: 600;">Semestrales</h4>
								<hr>
								<h4 style="font-size: 17px; font-weight: 600;">*desde $23.990 + IVA</h4>
								<h6 style="font-size: 17px; font-weight: 600;">*valor mensual en plan semestral</h6>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg2,'Registro.asp?tip=2&vTipPlan=2363&vIdPlan=39&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg3" action="#" method="post">
								<h3 style="font-size: 17px; font-weight: 600;">Anuales</h4>
								<hr>
								<h4 style="font-size: 17px; font-weight: 600;">*desde $21.990 + IVA</h4>
								<h6 style="font-size: 17px; font-weight: 600;">*valor mensual en plan anual</h6>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg3,'Registro.asp?tip=3&vTipPlan=2363&vIdPlan=40&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<%elseif request.queryString("tip")=6 then%>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg1" action="#" method="post">
								<h3 style="font-size: 17px; font-weight: 600;">Mensuales</h4>
								<hr>
								<h4 style="font-size: 17px; font-weight: 600;">desde $50.990 + IVA</h4>
								<h6 style="font-weight:bold; color:#FFF;">_</h6>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg1,'Registro.asp?tip=1&vTipPlan=2364&vIdPlan=38&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg2" action="#" method="post">
								<h3 style="font-size: 17px; font-weight: 600;">Semestrales</h4>
								<hr>
								<h4 style="font-size: 17px; font-weight: 600;">*desde $42.990 + IVA</h4>
								<h6 style="font-size: 17px; font-weight: 600;">*valor mensual en plan anual</h6>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg2,'Registro.asp?tip=2&vTipPlan=2364&vIdPlan=39&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<div class="col-md-4">
							<div class="box special">
								<form name="form_reg3" action="#" method="post">
								<h3 style="font-size: 17px; font-weight: 600;">Anuales</h4>
								<hr>
								<h4 style="font-size: 17px; font-weight: 600;">*desde $39.990 + IVA</h4>
								<h6 style="font-size: 17px; font-weight: 600;">*valor mensual en plan anual</h6>
								<ul class="actions">
									<button type="button" class="button fit small" style="background:#F7931E" onClick="javascript:irA(document.forms.form_reg3,'Registro.asp?tip=3&vTipPlan=2364&vIdPlan=40&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">REVISAR</button>
								</ul>
								</form>
							</div>
						</div>
						<%end if%>
					</div>

   <%if request.QueryString("tip")= "1" then%>
<form name="form2_crit" action="#" method="post" class="form-horizontal">
   <div class="site_wrapper" style="position: relative;">
<div id="planes" class="host_plans">
<div class="container">
    <%
	sql ="exec Listar_Planes "
	sql=sql & " '" & request.QueryString("vIdPlan") & "', "
	sql=sql & " '" & request.QueryString("vTipPlan") & "' "

	Set rs=nothing
	Set rs = cn.Execute(sql)
	if not rs.eof then
		do while not rs.eof
		
		vIdPlan	 	= rs("id_Plan")
		vIdTipPlan	= rs("id_tipo_Plan_padre")
		vNombrePlan	= rs("nombre")
		vValor		= rs("valor")
		vDesc1		= rs("descripcion")
		vDesc2		= rs("desc2")
		vDesc3		= rs("desc3")
		vDesc4		= rs("desc4")
		vDesc5		= rs("desc5")
		vCodigo		= rs("codigo")
	%>
		<div class="one_fourth_less">
		<div class="planbox">
			<div class="title"><h4 class="caps"><strong><%=vNombrePlan%></strong></h4></div>
			<div class="prices">


				<strong>$<%=FormatNumber(vValor,0)%><i></i></strong>/mes + IVA</br></br>						
			</div>
			<ul>
				<li><%=vDesc2%></li>
				<li><%=vDesc1%></li>
				<li><%=vDesc3%></li>
				<!--<li><%=vDesc4%></li>-->
				<li><%=vDesc5%></li>
			</ul>
			<a style="cursor:pointer;" onClick="javascript:irA(document.forms.form2_crit,'det_plan.asp?vIdPlan=<%=vIdPlan%>&vIdTipPlan=<%=vIdTipPlan%>&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>&WP=1&TB=<%=vCodigo%>');">Contratar</a>
		</div>
		</div>
	<%
		rs.movenext
		loop
	end if
	%>
</div>
</div>
</div>
</form>
<%elseif request.QueryString("tip")= "2" then%>
<form name="form2_crit" action="#" method="post" class="form-horizontal">
   <div class="site_wrapper" style="position: relative;">
<div id="planes" class="host_plans">
<div class="container">
    <%
	sql ="exec Listar_Planes "
	sql=sql & " '" & request.QueryString("vIdPlan") & "', "
	sql=sql & " '" & request.QueryString("vTipPlan") & "' "
	Set rs=nothing
	Set rs = cn.Execute(sql)
	if not rs.eof then
		do while not rs.eof
		
		vIdPlan	 	= rs("id_Plan")
		vNombrePlan		= rs("nombre")
		vValor		= rs("valor")
		vDesc1		= rs("descripcion")
		vDesc2		= rs("desc2")
		vDesc3		= rs("desc3")
		vDesc4		= rs("desc4")
		vDesc5		= rs("desc5")
		vCodigo		= rs("codigo")
	%>
		<div class="one_fourth_less">
		<div class="planbox">
			<div class="title"><h4 class="caps"><strong><%=vNombrePlan%></strong></h4></div>
			<div class="prices">
				<strong>$<%=FormatNumber(vValor,0)%><i></i></strong>/mes + IVA</br></br>
				<a style="cursor:pointer;" onClick="javascript:irA(document.forms.form2_crit,'det_plan.asp?vIdPlan=<%=vIdPlan%>&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>&WP=1&TB=<%=vCodigo%>');">Contratar</a>						
			</div>
			<ul>
				<li><%=vDesc2%></li>
				<li><%=vDesc1%></li>
				<li><%=vDesc3%></li>
				<!--<li><%=vDesc4%></li>-->
				<li><%=vDesc5%></li>
			</ul>
		</div>
		</div>
	<%
		rs.movenext
		loop
	end if
	%>
</div>
</div>
</div>
</form>
<%elseif request.QueryString("tip")= "3" then%>
<form name="form2_crit" action="#" method="post" class="form-horizontal">
   <div class="site_wrapper" style="position: relative;">
<div id="planes" class="host_plans">
<div class="container">
    <%
	sql ="exec Listar_Planes "
	sql=sql & " '" & request.QueryString("vIdPlan") & "', "
	sql=sql & " '" & request.QueryString("vTipPlan") & "' "
	Set rs=nothing
	Set rs = cn.Execute(sql)
	if not rs.eof then
		do while not rs.eof
		
		vIdPlan	 	= rs("id_Plan")
		vNombrePlan		= rs("nombre")
		vValor		= rs("valor")
		vDesc1		= rs("descripcion")
		vDesc2		= rs("desc2")
		vDesc3		= rs("desc3")
		vDesc4		= rs("desc4")
		vDesc5		= rs("desc5")
		vCodigo		= rs("codigo")
	%>
		<div class="one_fourth_less">
		<div class="planbox">
			<div class="title"><h4 class="caps"><strong><%=vNombrePlan%></strong></h4></div>
			<div class="prices">
				<strong>$<%=FormatNumber(vValor,0)%><i></i></strong>/mes + IVA</br></br>
				<a style="cursor:pointer;" onClick="javascript:irA(document.forms.form2_crit,'det_plan.asp?vIdPlan=<%=vIdPlan%>&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>&WP=1&TB=<%=vCodigo%>');">Contratar</a>						
			</div>
			<ul>
				<li><%=vDesc2%></li>
				<li><%=vDesc1%></li>
				<li><%=vDesc3%></li>
				<!--<li><%=vDesc4%></li>-->
				<li><%=vDesc5%></li>
			</ul>
		</div>
		</div>
	<%
		rs.movenext
		loop
	end if
	%>
</div>
</div>
</div>
</form>
<%end if%>
			</section>
<div class="modal fade" id="myModal7" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<form name="formContacto" method="post" >
<div class="modal-dialog">

	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">CONTACTO</h4>
		</div>
		<div class="modal-body">
			<div class="form-group">
				<label>NOMBRE</label>
				<input class="form-control text-box-modal" type="text" style="color:#F7931E" name="nom_cont" id="nom_cont"/>
			</div>
			<div class="form-group">
				<label>MAIL</label>
				<input class="form-control text-box-modal" type="text" style="color:#F7931E" name="mail_cont" id="mail_cont"/>
			</div>
			<div class="form-group">
				<label>ASUNTO</label>
					<div class="select-wrapper">
						<select name="textfield3" class="form-control text-box-modal" value="<%=vEstado%>">
							<option value="c">CONSULTAS</option>
							<option value="s">SUGERENCIAS</option>
							<option value="r">RECLAMOS</option>
							<option value="o">OTROS</option>
						</select>
					  </div>
			</div>
			<div class="form-group">
				<label>MENSAJE</label>
				<textarea class="text-area" name="men_cont" id="men_cont"></textarea>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-success" onClick="javascript:validaContacto(document.forms.formContacto,'index.asp?est=2');">ENVIAR</button>
		</div>
	</div>

</div>
</form>
</div>
<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<form name="formPrivacidad" method="post" >
	<div class="col-md-8">
	<div class="panel panel-default">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">Políticas de privacidad</h4>
		</div>
		<div class="panel-body">
			<div class="table-responsive">
				<h5>
				<p><b>General<br>
				Al acceder al sitio www.mundomaquinaria.cl el usuario está aceptando y reconoce que ha revisado y está de acuerdo con esta Política de Privacidad.
				<br>Mundo Maquinaria SpA se reserva el derecho a modificar la presente política de privacidad y será responsabilidad del usuario la lectura y acatamiento de esta cada vez que ingrese al sitio.
				<p>Acceso a la Información<br>
				El acceso a la información del sitio www.mundomaquinaria.cl tiene carácter gratuito, sin embargo hay información que está limitada para usuarios que previamente se hubieren registrado como tales y aceptado los Términos y Condiciones Generales del sitio.
				<br>Para acceder a ellos los usuarios registrados podrán acceder con su correo electrónico y clave que les correspondan.
				<p>Información de los usuarios<br>
				Mundo Maquinaria SpA recopila datos de los usuarios registrados que hagan uso de este portal conforme a los Términos y Condiciones Generales del mismo. La entrega de esta información será voluntaria y se indicará claramente el fin para el cual está siendo solicitada, previa a la aceptación que debe realizar el usuario.
				<p>Información a terceros<br>
				Mundo Maquinaria SpA no comunicará ni transferirá a terceros los datos personales de sus usuarios sin el consentimiento expreso del titular. No obstante lo anterior, en caso de ser requerido judicialmente se hará entrega de la información solicitada.
				<p>Uso de la información<br>
				Todos los derechos referidos a www.mundomaquinaria.cl y sus contenidos, incluidos los de propiedad intelectual, pertenecen a Mundo Maquinaria SpA.
				<br>Al acceder al sitio, el visitante tendrá derecho a revisar toda la información que esté disponible en él. Sin perjuicio de lo anterior, Mundo Maquinaria no se hace responsable por la veracidad o exactitud de la información que haya sido entregada por terceros.
				</h5>
			</div>
		</div>

	</div>
	</form>
</div>
</div>
<div class="modal fade" id="myModal5" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<form name="formTermUso" method="post" >
	<div class="modal-dialog">

		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Términos de uso</h4>
			</div>
			<div class="modal-body">

			</div>
		</div>

	</div>
	</form>
</div>
<div class="modal fade" id="myModal8" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<form name="formLogin" method="post" >
	<div class="modal-dialog">

		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Quiénes Somos</h4>
			</div>
			<div class="modal-body">

			</div>
		</div>

	</div>
	</form>
</div>
			<!-- Footer -->
				<footer id="footer">
					<ul class="icons">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<li><a href="https://twitter.com/mundomaquinaria" class="icon fa-twitter" target="_blank" style="color: #ffffff!important;font-size: 16px;background: transparent;border-radius: 0px !important;padding: 0px 0px;position: relative;"><span class="label" >Twitter</span></a></li>
						<li><a href="https://www.facebook.com/mundomaquinaria" class="icon fa-facebook" target="_blank" style="color: #ffffff!important;font-size: 16px;background: transparent;border-radius: 0px !important;padding: 0px 0px;position: relative;"><span class="label">Facebook</span></a></li>
						<li><a href="https://www.instagram.com/mundomaquinaria.cl/" class="icon fa-instagram" target="_blank" style="color: #ffffff!important;font-size: 16px;background: transparent;border-radius: 0px !important;padding: 0px 0px;position: relative;"><span class="label">Instagram</span></a></li>


					</ul>
					<ul class="copyright">
						<li><a data-toggle="modal" data-target="#myModal7"style="background: transparent;font-size: small;padding: 0 0 0 0; border-radius: 0;text-transform: capitalize;font-weight: 100;">Contacto </a></li>
						<li><a data-toggle="modal" data-target="#myModal3"style="background: transparent;font-size: small;padding: 0 0 0 0; border-radius: 0;text-transform: capitalize;font-weight: 100;">Privacidad</a></li>
						<li><a data-toggle="modal" data-target="#myModal8"style="background: transparent;font-size: small;padding: 0 0 0 0; border-radius: 0;text-transform: capitalize;font-weight: 100;">Quiénes somos</a></li>
						<li><a data-toggle="modal" data-target="#myModal5"style="background: transparent;font-size: small;padding: 0 0 0 0; border-radius: 0;text-transform: capitalize;font-weight: 100;">Términos de uso</a></li>
					</ul>
					<ul class="copyright" style="font-weight: 100;font-size: small">
						<li>&copy; Todos los derechos reservados.</li><li>Diseñado por: <a href="http://gofour.cl" style="background: transparent;font-size: small;padding: 0 0 0 0; border-radius: 0;text-transform: capitalize;font-weight: 100;">Go Four</a></li>
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
			if (tipParam != null) {
				goToByScroll("planes");
			}
		});
	</script>
	<style>
		#banner :last-child {
			margin-bottom: 0px !important;
		}
		.host_plans .planbox li {
			color: #f7931e;
		}
		.host_plans .planbox li strong {
			color: #f7931e !important;
		}
	</style>
</html>
