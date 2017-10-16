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
	Const cdoSendUsingPort = 2
iServer = "smtp.gmail.com"
                Response.CodePage = 65001 
                Response.CharSet = "utf-8"

			%>
		<!-- [Renato] : Se comenta llamada de hoja de estilo, ya que no existe. -->
		<!-- <link rel="stylesheet" type="text/css" href="estilo.css" /> -->

		<link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
		<link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
		<link href="assets/css/style.css" rel="stylesheet" />
		<link rel="icon" type="image/png" href="./images/icon.ico" />
		<title>Mundo Maquinaria</title>
		<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8; ISO-8859-1"> -->
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
<%


if request.QueryString("est") = "2" then

    nombre  = request.Form("textfield")
	mail    = request.Form("textfield2")
	asunto  = request.Form("textfield3")
	mensaje = request.Form("textfield4")

	'ENVÍO DEL FORMULARIO DE CONTACTO
	sch = "http://schemas.microsoft.com/cdo/configuration/"
	Set cdoConfig = CreateObject("CDO.Configuration")
	With cdoConfig.Fields
		.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = iServer
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 50
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
	.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "contacto@mundomaquinaria.cl" 
	.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "webweb008"
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = 1
	.Update
	End With

	Set MailObject = Server.CreateObject("CDO.Message")
	Set MailObject.Configuration = cdoConfig
	MailObject.From	= vCorreo_Cotizacion
	MailObject.To	= mail
	if asunto = "c" then
			MailObject.Subject	= "Consultas"
	elseif asunto = "r" then
		MailObject.Subject	= "Reclamos"
	elseif asunto = "s" then
		MailObject.Subject	= "Sugerencias"
	elseif asunto = "o" then
		MailObject.Subject	= "Otros"
	end if
	'MailObject.Subject = "Contacto - Mundo Maquinaria"
	Cuerpo = "<br><br><h3 style=color:#3B5998>Estimado(a) Administrador de Mundo Maquinaria, <br>&nbsp;&nbsp;&nbsp;&nbsp;Se ha registrado un mensaje desde http://www.mundomaquinaria.cl con los siguientes datos:</h3>"
	Cuerpo = Cuerpo & " .<br><br>&nbsp;&nbsp;&nbsp;&nbsp;"
	Cuerpo = Cuerpo & " <br><br><h4 style=color:#F7931E> nombre:" & nombre & "<br> mail: " & mail & "<br> mensaje: " & mensaje & "</h4></a>"
	Cuerpo = Cuerpo & "<br><br>"
	Cuerpo = Cuerpo & "<h3 style=color:#3B5998>Atentamente,<br>"
	Cuerpo = Cuerpo & "Equipo Mundo Maquinaria</h3>"
	Cuerpo = Cuerpo & "<br><br><img src= http://www.mundomaquinaria.cl/marchablanca/images/logo2.png>"
	MailObject.HTMLBody = Cuerpo
	MailObject.Send
	Set MailObject = Nothing
	Set cdoConfig = Nothing
		%>
		<script type="text/javascript">
			//mostrarMensaje('Mensaje enviado exitosamente.', 'success');
			window.location="index.asp?msg=1";
		</script>
		<%
end if
if request.QueryString("est") = "5" then
		sql="exec ListaMailClientesUsuarioLogo "
		sql=sql & " '" & request.QueryString("rut") & "' "

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
				vPlazos			= rs("plazos")

			sch = "http://schemas.microsoft.com/cdo/configuration/"
			Set cdoConfig = CreateObject("CDO.Configuration")
			With cdoConfig.Fields
		.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = iServer
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 50
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
	.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "contacto@mundomaquinaria.cl" 
	.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "webweb008"
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = 1
	.Update
			End With

			Set MailObject = Server.CreateObject("CDO.Message")
			Set MailObject.Configuration = cdoConfig

			MailObject.From	= vCorreo_Cotizacion
			MailObject.To	= vMailUsuario
			MailObject.Subject = "Envio de Cotizacion"
			Cuerpo = "<br><br><h3 style=color:#3B5998>Estimado(a) Cliente de Mundo Maquinaria, <br>&nbsp;&nbsp;&nbsp;&nbsp;Se ha enviado una cotizacion con los siguientes datos:</h3>"
			Cuerpo = Cuerpo & " <br><br><h4 style=color:#F7931E> Tipo Cotizacion: " & vTipoCotiza & "<br>Nombre: " & vNombreUsuario & "<br> mail: " & vMailUsuario & "<br> Telefono: " & vTelefonoUsuario & "<br> Equipo: " & vEquipo & "</a>"
			Cuerpo = Cuerpo & "<br>Region: " & vRegion 
			Cuerpo = Cuerpo & "<br> Ciudad: " & vCiudad 
			if vMensaje <> "" then
				Cuerpo = Cuerpo & "<br> Mensaje: " & vMensaje
			end if
			Cuerpo = Cuerpo & "<br>Adicionales: <br><br>"
			if vOperador <> "NO" then
				Cuerpo = Cuerpo & "Con Operador:" & vOperador 
			end if 
			if vCombustible <> "NO" then
				Cuerpo = Cuerpo & "<br> Con Combustible: " 
				Cuerpo = Cuerpo & vCombustible
			end if
			if vTraslados <> "NO" then		
				Cuerpo = Cuerpo & "<br> Con Traslados: " 
				Cuerpo = Cuerpo & vTraslados
			end if
			if vPlazos <> "" then
				Cuerpo = Cuerpo & "<br> Condicion de Plazo: " & vPlazos
			end if
			Cuerpo = Cuerpo & "</h4><br><br>"
			Cuerpo = Cuerpo & "<h3 style=color:#3B5998>Atentamente,<br>"
			Cuerpo = Cuerpo & "Equipo Mundo Maquinaria</h3>"
			Cuerpo = Cuerpo & "<br><br><img src= http://www.mundomaquinaria.cl/marchablanca/images/logo2.png>"

			MailObject.HTMLBody = Cuerpo
			MailObject.Send
			Set MailObject = Nothing
			Set cdoConfig = Nothing


			'Ini Mail distinto Usuario 
			sch = "http://schemas.microsoft.com/cdo/configuration/"
			Set cdoConfig = CreateObject("CDO.Configuration")
			With cdoConfig.Fields
					.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = iServer
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 50
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
	.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "contacto@mundomaquinaria.cl" 
	.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "webweb008"
	.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = 1
	.Update
			End With

			Set MailObject = Server.CreateObject("CDO.Message")
			Set MailObject.Configuration = cdoConfig

			MailObject.From	= vCorreo_Cotizacion
			MailObject.To	= vMailCotizacion 
			MailObject.Subject = "Envio de Cotizacion"
			Cuerpo = "<br><br><h3 style=color:#3B5998>Estimado(a) Cliente de Mundo Maquinaria, <br>&nbsp;&nbsp;&nbsp;&nbsp;Se realizo un cotiacion que coincide con sus Equipos y Regiones los datos son los siguientes:</h3>"
			Cuerpo = Cuerpo & " <br><br><h4 style=color:#F7931E> Tipo Cotizacion: " & vTipoCotiza & "<br>Nombre: " & vNombreUsuario & "<br> mail: " & vMailUsuario & "<br> Telefono: " & vTelefonoUsuario & "<br> Equipo: " & vEquipo & "</a>"
			Cuerpo = Cuerpo & "<br>Region: " & vRegion 
			Cuerpo = Cuerpo & "<br> Ciudad: " & vCiudad 
			if vMensaje <> "" then
				Cuerpo = Cuerpo & "<br> Mensaje: " & vMensaje
			end if
			Cuerpo = Cuerpo & "<br>Adicionales: <br><br>"
			if vOperador <> "NO" then
				Cuerpo = Cuerpo & "Con Operador:" & vOperador 
			end if 
			if vCombustible <> "NO" then
				Cuerpo = Cuerpo & "<br> Con Combustible: " 
				Cuerpo = Cuerpo & vCombustible
			end if
			if vTraslados <> "NO" then		
				Cuerpo = Cuerpo & "<br> Con Traslados: " 
				Cuerpo = Cuerpo & vTraslados
			end if
			if vPlazos <> "" then
				Cuerpo = Cuerpo & "<br> Condicion de Plazo: " & vPlazos
			end if
			Cuerpo = Cuerpo & "</h4><br><br>"
			Cuerpo = Cuerpo & "<h3 style=color:#3B5998>Atentamente,<br>"
			Cuerpo = Cuerpo & "Equipo Mundo Maquinaria</h3>"
			Cuerpo = Cuerpo & "<br><br><img src= http://www.mundomaquinaria.cl/marchablanca/images/logo2.png>"

			MailObject.HTMLBody = Cuerpo
			MailObject.Send
			Set MailObject = Nothing
			Set cdoConfig = Nothing
			
			'Fin Mail distinto
			'ACTUALIZA EL ESTADO A 0 DE LA TABLA COTIZACION
			sql="exec ActualizaEstadoCotizacion "
			sql=sql & " '" & vIdCotiza & "', "
			sql=sql & " 1 "
			set Rs1 = nothing
			Set Rs1 = cn.Execute(sql)

			rs.movenext
			loop
		else
			'ACTUALIZA EL ESTADO A 3 DE LA TABLA COTIZACION "NO COTIZADO"
			sql="exec ActualizaEstadoCotizacion "
			sql=sql & " '" & vIdCotiza & "', "
			sql=sql & " 3 "
			set Rs1 = nothing
			Set Rs1 = cn.Execute(sql)
		'	vTipoVacio = 1
		'	vMensaje		= "<p align=justify style=color:#F7931E>Lamentablemente para la busqueda realizada no existen proveedores que cumplan estas condiciones, estamos trabajando por incrementar nuestra red de proveedores en el país.</p>"
		end if
end if
%>
	<body class="landing">
		<div id="messageDiv" class="" style="display: none;">
			<button type="button" class="close" data-dismiss="modal" onclick="ocultarMessage()" aria-hidden="true">×</button>
			<br />
			<p>message</p>
		</div>
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
										mostrarMensaje('Para Continuar debe Completar los datos de Ingreso', 'error');
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
													<input class="form-control text-box-modal" placeholder="11111111-1" type="text" style="color:#F7931E" id ="Rut_Reg" name="Rut_Reg" value="<%=vRut%>"/>
												</div>
												<div class="form-group">
													<label>RAZÓN SOCIAL / NOMBRE</label>
													<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="Nom_Reg" name="Nom_Reg" value="<%=vNombre%>"/>
												</div>
												<div class="form-group">
													<label>CORREO</label>
													<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="Mail_Reg" name="Mail_Reg" value="<%=vMail%>"/>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-modal" style="background:#F7931E" onClick="javascript:validaDatos(document.forms.formReg1,'index.asp?est=new');">ENVIAR</button>
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
				<section id="banner">
					<!-- Main -->
				<section id="main" class="container">
					<div class="row" style="margin-bottom: 25px;">
						<div class="12u">

							<!-- Table -->
								<section class="box box-table">
									<h3><p align="justify">Este es el detalle de su cotización.</p></h3>

									<div class="table-wrapper">
										<table>
											<thead>
												<tr>
													<th>EQUIPO</th>
													<th>TIPO COTIZACIÓN</th>
													<th>REGIÓN</th>
													<th>CIUDAD</th>

												</tr>
											</thead>
											<tbody>
											<%
											
											sql="exec GRILLACOTIZACION "
											sql=sql & " '" & request.QueryString("rut") & "' "
											set Rs3 = nothing
											Set Rs3 = cn.Execute(sql)
											if not rs3.eof then
												do while not rs3.eof
												vEquipo2		= rs3("equipo")
												vTipoCotiza2	= rs3("TipoCotiza")
												vRegion2		= rs3("region")
												vCiudad2		= rs3("ciudad")
												
											%>
												<tr>
													<td style="color:#F7931E;"><%=Ucase(vEquipo2)%></td>
													<td style="color:#F7931E;"><%=Ucase(vTipoCotiza2)%></td>
													<td style="color:#F7931E;"><%=Ucase(vRegion2)%></td>
													<td style="color:#F7931E;"><%=Ucase(vCiudad2)%></td>

												</tr>
											<%
											rs3.movenext
											loop
											end if
											%>
											</tbody>

										</table>
									</div>
								</section>

						</div>
					</div>
					<div class="row col-md-9" style="float: right;">
						<section id="destacada" class="box special features col-md-7">
							<div id="carousel-example" class="carousel slide slide-bdr" data-ride="carousel">
								<div class="carousel-inner">
								<%
								sql="exec MantenedorPublicidad "
								sql=sql & " 4 , -1 , '' , 0 , 0, '', 1233, ''"
								set rs4 = nothing
								Set rs4 = cn.Execute(sql)

								vIdPublicidad = rs4("Id_Publicidad")

								%>
								<div class="item active">
									<img src="<%=rs4("ruta")%>" alt="" />
								</div>
								<%
								sql="exec MantenedorPublicidad "
								sql=sql & " 5 , "
								sql=sql & " " & vIdPublicidad &" , "
								sql=sql & " '' , "
								sql=sql & " 0 , "
								sql=sql & " 0 , "
								sql=sql & " '', 1233, ''"
								set rs5 = nothing
								Set rs5 = cn.Execute(sql)
								if not rs5.eof then
									Do while not rs5.eof
								%>
								<div class="item">
									<img src="<%=rs5("ruta")%>" alt="" />

								</div>
								<%
									rs5.movenext
									loop
								end if
								%>
								</div>
								<!--INDICATORS-->
								 <ol class="carousel-indicators">
									<li data-target="#carousel-example" data-slide-to="0" class="active"></li>
									<li data-target="#carousel-example" data-slide-to="1"></li>
									<li data-target="#carousel-example" data-slide-to="2"></li>
								</ol>
								<!--PREVIUS-NEXT BUTTONS-->
								<a class="left carousel-control" href="#carousel-example" data-slide="prev">
									<span class="glyphicon glyphicon-chevron-left"></span>
								</a>
								<a class="right carousel-control" href="#carousel-example" data-slide="next">
									<span class="glyphicon glyphicon-chevron-right"></span>
								</a>
							</div>
						</section>
					</div>


				</section>
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
	<div class="modal-dialog modal-privacidad">
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
	<form name="formPrivacidad" method="post" >
	<div class="modal-dialog modal-privacidad">
	<div class="panel panel-default">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">TÉRMINOS Y CONDICIONES GENERALES DEL SITIO WWW.MUNDOMAQUINARIA.CL</h4>
		</div>
		<div class="panel-body">
			<div class="table-responsive">
				<h5>
				<p>Este contrato describe los términos y condiciones generales (en adelante los “TCG”) que se aplican al uso de los servicios (en adelante los “Servicios") ofrecidos por Mundo Maquinaria SpA (en adelante “Mundo Maquinaria”) a través de su sitio web www.mundomaquinaria.cl (en adelante el “Sitio”).<br>
				<br>Cualquier persona que desee acceder y/o usar el Sitio o los Servicios podrá hacerlo sujetándose a éstos TCG junto con todas las demás políticas y principios que rigen el Sitio y que son incorporados a los presentes TCG por referencia. <br>
				<br>TODA PERSONA QUE SE REGISTRE EN EL SITIO WWW.MUNDOMAQUINARIA.CL EN CALIDAD DE USUARIO DEBERÁ, EN FORMA PREVIA A SU UTILIZACIÓN, ACEPTAR ESTOS TÉRMINOS Y CONDICIONES GENERALES, LOS CUALES TENDRÁN SIEMPRE UN CARÁCTER OBLIGATORIO Y VINCULANTE.<br>
				<p>El Usuario debe leer, entender y aceptar todas las condiciones establecidas en los presentes TCG así como en los demás documentos incorporados a los mismos por referencia, previo a su inscripción como Usuario de Mundo Maquinaria. <br>
				<br>Mundo Maquinaria podrá realizar modificaciones a los TCG en cualquier momento, debiendo hacer públicos en el Sitio los términos modificados para ponerlos en conocimiento de los Usuarios y dando aviso de ello mediante correo electrónico al que estuviera registrado por parte del Usuario. Los términos modificados entrarán en vigor en el plazo de 10 (diez) días desde su publicación en el Sitio. Transcurrido ese plazo, el silencio se considerará como aceptación del Usuario y el contrato continuará vinculando a ambas partes. Si el Usuario no aceptare las modificaciones a los presentes TCG, deberá, en el mismo plazo indicado anteriormente, comunicarlo por escrito al correo electrónico contacto@mundomaquinaria.cl, cesando desde ese momento todos los efectos que emanan de estos TCG y quedando automáticamente inhabilitado como Usuario, siempre y cuando no tenga obligaciones o deudas  pendientes con Mundo Maquinaria, las que deberán solucionarse antes de dar por terminado el vínculo contractual entre las partes.<br>
				<br>Los Servicios se prestarán a personas naturales o jurídicas que tengan capacidad legal para contratar. No podrán utilizar los servicios las personas que no tengan esa capacidad, los menores de edad o Usuarios de Mundo Maquinaria que hayan sido suspendidos temporalmente o inhabilitados definitivamente. En el caso de personas jurídicas, debe tratarse de un representante legal con facultades necesarias y suficientes para contratar a nombre de tal entidad y de obligar a la misma en los términos de estos TCG. Por lo tanto, se considerará que cualquier persona jurídica que utilice los servicios de “Mundo Maquinaria” cumple con lo señalado anteriormente.<br>
				<br><b>1. CONDICIONES GENERALES Y DEFINICIONES PREVIAS.</b><br>
				<br> 1.1 El objetivo de los Servicios es proporcionar un sitio en internet para la búsqueda y oferta de maquinarias, así como servicios y productos afines. El Sitio incluye condiciones de uso y políticas de privacidad que fijan las medidas que Mundo Maquinaria puede tomar para que la información que le facilitan los Usuarios permanezca segura y sea utilizada únicamente para los fines a los que está destinada. <br>
				<br> 1.2 Mundo Maquinaria no es propietario de los bienes y servicios publicados u ofrecidos a través del Sitio, ni participa de modo alguno en el negocio de arriendo o venta de los mismos y no recibe comisión por las transacciones efectuadas entre los Usuarios. Asimismo, no comercializa los productos y servicios publicados. Su vinculación a estos productos, sus oferentes y las ofertas encontradas en el Sitio, se limita únicamente ser un medio de publicación en internet. La información publicada es de exclusiva responsabilidad de los Usuarios. <br>
				<br> 1.3 Niveles de interacción con el Sitio. Existen distintos niveles de vinculación con el Sitio, según las siguientes definiciones: <br>
				<br>a. Visitante: Es todo aquel usuario que accede a una o más páginas de información publicada en el Sitio, no exigiéndose su identificación para dicho acceso.<br>
				<br>b. Usuario: Es aquel Visitante registrado que hace uso del Sitio para ofrecer el arriendo, la venta de un producto determinado o la prestación de algún servicio. <br>
				<br> 2. INSCRIPCIÓN DEL USUARIO.<br>
				<br>Para poder acceder a los Servicios es obligatorio que el Usuario se registre previamente en el Sitio completando el formulario de inscripción destinado a tal efecto, obligándose a proporcionar toda la información y datos requeridos en forma exacta, precisa y fidedigna  (en adelante los "Datos Personales"). El Usuario asume el compromiso de actualizar sus Datos Personales conforme resulte necesario. Mundo Maquinaria podrá utilizar diversos medios para identificar a sus Usuarios, pero NO se responsabiliza por la certeza ni veracidad de los Datos Personales que sus Usuarios le han entregado. Los Usuarios garantizan y responden, en cualquier caso, de la veracidad, exactitud, vigencia y autenticidad de los Datos Personales puestos a disposición de Mundo Maquinaria.<br>
				<br>Mundo Maquinaria se reserva el derecho de solicitar algún comprobante y/o dato adicional a efectos de corroborar los Datos Personales, así como de suspender temporal o definitivamente a aquellos Usuarios cuyos datos no hayan podido ser confirmados. En estos casos de inhabilitación, se dará de baja todos los artículos publicados, así como las ofertas realizadas, sin que ello genere algún derecho a resarcimiento.<br>
				<br>El Usuario accederá a su cuenta personal (en adelante la "Cuenta") mediante el ingreso de su correo electrónico a su elección, y de la clave de seguridad personal elegida (en adelante "Clave de Seguridad"). El Usuario se obliga a mantener la confidencialidad de su Clave de Seguridad. La Cuenta es personal, única e intransferible, y está prohibido que un mismo Usuario inscriba o posea más de una Cuenta. En caso que Mundo Maquinaria detecte distintas Cuentas que contengan datos coincidentes o relacionados, las podrá cancelar, suspender o inhabilitarlas.<br>
				<br>El Usuario será el exclusivo responsable por todas las operaciones efectuadas en su Cuenta, pues el acceso a la misma está restringido al ingreso y uso de su Clave de Seguridad, de conocimiento exclusivo del Usuario. El Usuario se compromete a notificar a Mundo Maquinaria, en forma inmediata y por un medio idóneo y fehaciente, cualquier uso no autorizado de su Cuenta, así como el ingreso por terceros no autorizados a la misma. Está prohibido la venta, cesión o transferencia de la Cuenta (incluyendo la reputación y calificaciones) bajo ningún título.
					Mundo Maquinaria se reserva el derecho de rechazar cualquier solicitud de inscripción o de cancelar una inscripción previamente aceptada, sin que esté obligado a comunicar o exponer las razones de su decisión y sin que ello genere algún derecho a indemnización o resarcimiento.<br>
				<br><b>3. TRATAMIENTO DE LOS DATOS PERSONALES.</b><br>
				<br>En relación con el almacenamiento, custodia, conservación y tratamiento de los Datos Personales, conforme a lo indicado en la cláusula anterior, Mundo Maquinaria se obliga a dar pleno cumplimiento en todo momento a las disposiciones contenidas al respecto en la ley 19.628 sobre protección de la vida privada, como asimismo a cualquier otra norma de carácter legal o administrativo relacionada con ella, que la sustituya, reemplace o modifique total o parcialmente.<br>
				<br>Conforme a lo anterior, al aceptar los presentes TCG, el Usuario autoriza a Mundo Maquinaria para que ésta pueda compartir los Datos Personales proporcionados a través del Sitio con los otros Usuarios, con la única y exclusiva finalidad de poner en contacto a eventuales vendedores y compradores de los productos que se publican  es en el Sitio, facilitando el encuentro de los mismos y el aprovechamiento de oportunidades comerciales entre ellos. Se deja expresa constancia que la presente autorización está limitada únicamente a estos fines comerciales inherentes a la actividad económica que Mundo Maquinaria desarrolla a través del Sitio.
				<br><br><b>4. PUBLICACIÓN DE BIENES Y/O SERVICIOS.</b>
				<br><br><b>4.1 Publicación de bienes y/o servicios.</b> El Usuario podrá ofrecer la venta y/o el arriendo de bienes y/o servicios en las categorías y sub-categorías apropiadas. Las publicaciones podrán incluir textos descriptivos, gráficos, fotografías y otros contenidos y condiciones pertinentes para la venta del bien o la contratación del servicio, siempre que no violen ninguna disposición de este acuerdo o demás políticas de Mundo Maquinaria. El producto ofrecido por el Usuario debe ser exacta y fidedignamente descrito en cuanto a sus condiciones y características relevantes. Se entiende y presume que mediante la inclusión del bien o servicio en el Sitio, el Usuario expresa su intención de vender y/o arrendar el bien por él ofrecido, o está facultado para ello por su titular y lo tiene disponible para su entrega inmediata. Se establece que los precios de los productos publicados deberán ser expresados netos de IVA, cuando corresponda la aplicación del mismo, y en moneda del curso legal. Mundo Maquinaria podrá remover cualquier publicación cuyo precio no sea expresado de esta forma para evitar confusiones o malos entendidos en cuanto al precio final del producto. En caso que se infrinja cualquiera de las disposiciones establecidas en esta cláusula, Mundo Maquinaria podrá editar el espacio, solicitar al Usuario que lo edite, o dar de baja la publicación donde se encuentre la infracción y en ningún caso se devolverán o bonificarán los cargos de publicación.
				<br><br><b>4.2 Inclusión de imágenes y fotografías.</b> En la medida que el tipo de aviso seleccionado lo permita, el Usuario puede incluir imágenes y fotografías del producto ofrecido siempre que las mismas se correspondan con el artículo, salvo que se trate de bienes, productos o servicios que por su naturaleza no permiten esa correspondencia. Mundo Maquinaria podrá impedir la publicación de la fotografía, e incluso del producto, si interpretara, a su exclusivo criterio, que la imagen no cumple con los presentes TCG.
				<br><br><b>4.3 Artículos Prohibidos.</b> Sólo podrán ser ingresados en las listas de bienes y/o servicios ofrecidos, aquellos que correspondan a la categoría y sub-categoría seleccionada. Los bienes, productos o servicios no incluidos en alguna de ellas se encuentran prohibidos de publicar. Mundo Maquinaria podrá cancelar una publicación si estima que esta: (i) no cumple con el espíritu del Sitio; (ii) está en contra de la moral y sanas costumbres; o (iii) es ilegal o no ajustada a derecho; sin que en cualquiera de estos casos exista derecho del Usuario a ser resarcido o indemnizado por esta cancelación.
				<br><br><b>4.4 Prohibición de Duplicación de Avisos:</b> Para poder dar una mejor experiencia a los potenciales compradores y al público en general que visite el Sitio, Mundo Maquinaria no aceptará avisos duplicados, es decir, un bien o servicio solo se puede publicar una sola vez. Esto es válido para los avisos que el Usuario disponga por cualquiera de los medios disponibles. En caso de detectarse duplicación de avisos, Mundo Maquinaria se reserva el derecho de cancelar el aviso sin derecho a compensación alguna a quien lo publicó.
				<br><br><b>5. OBLIGACIONES DE LOS USUARIOS.</b>
				<br><br>El Usuario debe tener capacidad legal para vender y/o arrendar el bien objeto de su oferta. Dado que Mundo Maquinaria es un punto de encuentro entre compradores y vendedores y no participa de las operaciones que se realizan entre ellos, el Usuario será responsable por todas las obligaciones y cargas impositivas que correspondan por la venta de sus artículos, sin que pudiera imputársele a Mundo Maquinaria algún tipo de responsabilidad por incumplimientos en tal sentido.
				<br><br>Mundo Maquinaria sólo pone a disposición de los Usuarios y público en general un espacio virtual que les permite comunicarse mediante Internet para encontrar una forma de vender,  comprar o arrendar bienes y servicios. Mundo Maquinaria no tiene participación ni injerencia alguna en el proceso de negociación y perfeccionamiento del contrato definitivo entre las partes. Por eso, Mundo Maquinaria no es responsable por el efectivo cumplimiento de las obligaciones fiscales o impositivas establecidas por la legislación vigente. Mundo Maquinaria tampoco es responsable de la información proporcionada por los Usuarios, no otorga garantías de ningún tipo, ni presta servicios de traslado o algún otro referente al proceso de compra y entrega.
				<br><br><b>6. PRIVACIDAD DE LA INFORMACIÓN.</b>
				<br><br>Para utilizar los Servicios los Usuarios deberán facilitar determinados Datos Personales. Esta información se procesa y almacena en servidores o medios magnéticos que mantienen altos estándares de seguridad y protección tanto física como tecnológica. Para mayor información sobre la privacidad de los Datos Personales y casos en los que será revelada la información personal, se puede consultar nuestra Política de Privacidad, la que forma parte integrante de los presentes TCG y del sitio www.mundomaquinaria.cl.
				<br><br><b>7. PROHIBICIONES A LOS USUARIOS.</b>
				<br><br>Los Usuarios no podrán publicar, vender y/o arrendar artículos prohibidos por los TCG, demás políticas de Mundo Maquinaria o leyes vigentes. También está prohibido insultar o agredir a otros Usuarios  través del Sitio.
				<br><br>Cualquier infracción o contravención a lo dispuesto en los presentes TCG será investigada por Mundo Maquinaria y el infractor podrá ser sancionado con la suspensión o cancelación de la Cuenta, la oferta realizada e incluso de su inscripción como Usuario y/o de cualquier otra forma que Mundo Maquinaria estime pertinente, sin perjuicio de las acciones legales que correspondan derivadas de una eventual responsabilidad civil y/o penal, como de aquellas destinadas a la indemnización de perjuicios civiles que hubiera podido causar a otros Usuarios o a Mundo Maquinaria.
				<br><br><b>8. VIOLACIONES DEL SISTEMA O BASES DE DATOS.
				<br><br>No está permitida ninguna acción o uso de dispositivo, software, u otro medio tendiente a interferir tanto en las actividades y operatoria de Mundo Maquinaria como en las ofertas, descripciones, Cuentas o bases de datos de Mundo Maquinaria. Cualquier intromisión, tentativa o actividad violatoria o contraria a las leyes sobre derecho de propiedad intelectual y/o a las prohibiciones estipuladas en estos TCG harán responsable al infractor de las acciones legales pertinentes, así como de indemnizar los daños ocasionados.
				<br><br>9. SANCIONES Y SUSPENSIÓN DE LAS OPERACIONES.
				<br><br>Sin perjuicio de otras medidas, Mundo Maquinaria podrá advertir, suspender en forma temporal o inhabilitar definitivamente la Cuenta de un Usuario o una publicación, iniciar las acciones que estime pertinentes y/o suspender la prestación de sus Servicios si (i) se quebrantara alguna ley, o cualquiera de las estipulaciones de los TCG y demás políticas de Mundo Maquinaria; (ii) si incumpliera sus compromisos como Usuario; (iii) si se incurriera a criterio de Mundo Maquinaria en conductas o actos dolosos o fraudulentos; (iv) no pudiera verificarse la identidad del Usuario o cualquier información proporcionada por el mismo fuere errónea; y (v) Mundo Maquinaria entendiera que las publicaciones u otras acciones pueden ser causa de responsabilidad para el Usuario que las publicó, para Mundo Maquinaria o para los Usuarios. En el caso de la suspensión o inhabilitación de un Usuario, todos los artículos que tuviera publicados serán removidos del sistema y en ningún caso se devolverán o bonificarán los cargos de publicación involucrados. También se removerán del sistema las ofertas de compra de bienes ofrecidos en subasta.
				<br><br>10. RESPONSABILIDAD.</b>
				<br><br>Mundo Maquinaria sólo pone a disposición de los Usuarios un espacio virtual que les permite ponerse en comunicación mediante Internet para encontrar una forma de vender o comprar servicios o bienes. Mundo Maquinaria no es el propietario de los artículos ofrecidos, no tiene posesión de ellos ni los ofrece en venta. Mundo Maquinaria no interviene en el perfeccionamiento de las operaciones realizadas entre los Usuarios ni en las condiciones por ellos estipuladas para las mismas, por ello no será responsable respecto de la existencia, calidad, cantidad, estado, integridad o legitimidad de los bienes ofrecidos, adquiridos o enajenados por los Usuarios, así como de la capacidad para contratar de los Usuarios o de la veracidad de los Datos Personales por ellos ingresados. Cada Usuario conoce y acepta ser el exclusivo responsable por los artículos que publica para su venta y/o arriendo y por las ofertas y/o compras que realiza.
				<br><br>Debido a que Mundo Maquinaria no tiene ninguna participación durante todo el tiempo en que el artículo se publica para la venta o arriendo, ni en la posterior negociación y perfeccionamiento del contrato definitivo entre las partes, no será responsable por el efectivo cumplimiento de las obligaciones asumidas por los Usuarios en el perfeccionamiento de la operación. El Usuario conoce y acepta que al realizar operaciones con otros Usuarios o terceros lo hace bajo su propio cuenta y riesgo. En ningún caso Mundo Maquinaria será responsable por lucro cesante, o por cualquier otro daño y/o perjuicio que haya podido sufrir el Usuario, debido a las operaciones realizadas o no realizadas por artículos publicados a través de Mundo Maquinaria.
				<br><br>Mundo Maquinaria NO será responsable por la realización de ofertas y/o operaciones con otros Usuarios basadas en la confianza depositada en el sistema o los Servicios brindados por Mundo Maquinaria.
				<br><br>En caso que uno o más Usuarios o algún tercero inicien cualquier tipo de reclamo o acciones legales contra otro u otros Usuarios, todos y cada uno de los Usuarios involucrados en dichos reclamos o acciones eximen de toda responsabilidad a Mundo Maquinaria y a todos sus socios, accionistas, directores, gerentes, ejecutivos, empleados, agentes, operarios, representantes y apoderados.
				<br><br><b>11. ALCANCE DE LOS SERVICIOS DE MUNDO MAQUINARIA.</b>
				<br><br>Este acuerdo no crea ningún contrato de sociedad, de mandato, de franquicia, o relación laboral entre Mundo Maquinaria y el Usuario. El Usuario reconoce y acepta que Mundo Maquinaria no es parte en ninguna operación, ni tiene control alguno sobre la calidad, seguridad o legalidad de los artículos anunciados, la veracidad o exactitud de los anuncios, la capacidad de los Usuarios para vender o comprar artículos. Mundo Maquinaria no puede asegurar que un Usuario completará una operación ni podrá verificar la identidad o Datos Personales ingresados por los Usuarios. Mundo Maquinaria no garantiza la veracidad de la publicidad de terceros que aparezca en el Sitio y no será responsable por la correspondencia o contratos que el Usuario celebre con dichos terceros o con otros Usuarios.
				<br><br><b>12. FALLAS EN EL SISTEMA.</b>
				<br><br>Mundo Maquinaria no se responsabiliza por cualquier daño, perjuicio o pérdida al Usuario causados por fallas en el sistema, en el servidor o en Internet. Mundo Maquinaria tampoco será responsable por cualquier virus que pudiera infectar el equipo del Usuario como consecuencia del acceso, uso o examen de su sitio web o a raíz de cualquier transferencia de datos, archivos, imágenes, textos, o audio contenidos en el mismo. Los Usuarios NO podrán imputarle responsabilidad alguna ni exigir pago por perjuicios directos o indirectos ni lucro cesante, en virtud de perjuicios resultantes de dificultades técnicas o fallas en los sistemas o en Internet. Mundo Maquinaria no garantiza el acceso y uso continuado o ininterrumpido de su sitio. El sistema puede eventualmente no estar disponible debido a dificultades técnicas o fallas de Internet, o por cualquier otra circunstancia ajena a Mundo Maquinaria; en tales casos se procurará restablecerlo con la mayor celeridad posible sin que por ello pueda imputársele algún tipo de responsabilidad. Mundo Maquinaria no será responsable por ningún error u omisión contenidos en su Sitio.
				<br><br><b>13. TARIFAS COBROS POR EL SERVICIO. </b>
				<br><br>La inscripción en Mundo Maquinaria es gratuita. Al publicar bienes o servicios para la venta o arriendo, el Usuario deberá pagar un cargo de publicación, cuyo costo es variable de acuerdo al plan que elija. El precio de dichos planes variará conforme a la cantidad de información que éstos permitan cargar o publicar en el Sitio.
				<br><br>Todo anuncio será activado una vez confirmado el pago por parte de Mundo Maquinaria. El anuncio podrá ser eliminado del Sitio si han transcurrido más de cuarenta y ocho (48) horas desde su ingreso al sistema y no se ha recibido la confirmación del pago.
				<br><br>Mundo Maquinaria se reserva el derecho de modificar, cambiar, agregar, o eliminar las tarifas vigentes, en cualquier momento, lo cual será notificado a los Usuarios. Sin embargo, Mundo Maquinaria podrá modificar temporalmente las tarifas, tanto en su forma como en su valor, por sus servicios en razón de promociones, haciéndose efectivas estas modificaciones cuando se haga pública la promoción o se realice el anuncio.
				<br><br><b>14. PROMOCIONES Y AVISOS GRATIS.</b>
				<br><br>Los avisos publicados en el Sitio deben ser pagados por el Usuario. La tarifa de éstos será variable según el plan seleccionado por el Usuario, sin perjuicio del derecho de Mundo Maquinaria a realizar una o más promociones con tarifas distintas por períodos de tiempo determinados.
				<br><br><b>15. PROPIEDAD INTELECTUAL DEL CONTENIDO DEL SITIO.</b>
				<br><br>Todos los contenidos de las pantallas relativas a los servicios de Mundo Maquinaria como así también los programas, bases de datos, redes, archivos que permiten al Usuario acceder y usar su Cuenta, son de propiedad de Mundo Maquinaria y están protegidas por las leyes y los tratados internacionales de derecho de autor, marcas, patentes, modelos y diseños industriales.
				<br><br>El uso indebido y la reproducción total o parcial de dichos contenidos quedan prohibidos.
				<br><br>El Sitio puede contener enlaces a otros sitios web lo cual no indica que sean propiedad u operados por Mundo Maquinaria. En virtud que Mundo Maquinaria no tiene control sobre tales sitios, NO será responsable por los contenidos, materiales, acciones y/o servicios prestados por los mismos, ni por daños o pérdidas ocasionadas por la utilización de los mismos, sean causadas directa o indirectamente. La presencia de enlaces a otros sitios web no implica una sociedad, relación, aprobación, respaldo de Mundo Maquinaria a dichos sitios y sus contenidos.
				<br><br><b>16. INDEMNIDAD.</b>
				<br><br>El Usuario se obliga a indemnizar todos los perjuicios y mantener indemne a Mundo Maquinaria, sus filiales, empresas controladas y/o controlantes, directivos, administradores, representantes y empleados, y en general a cualquier persona, natural o jurídica, relacionada con ella, por cualquier suma a que fuere condenada a pagar por causa de algún reclamo, demanda, querella u otra actuación ante cualquier entidad judicial que se interponga o deduzca en su contra que tuviere como causa o se relacione, directa o indirectamente, con un incumplimiento o inobservancia de los presentes TCG y demás políticas que se entienden incorporadas a ellos, o por la violación de cualesquiera leyes o derechos de terceros.
				<br><br><b>17. PUBLICIDAD.</b>
				<br><br>Mundo Maquinaria pone el Sitio a disposición tanto de Usuarios como de otros terceros, para que éstos publiquen fotografías, imágenes o logotipos con el objeto de promocionar y publicitar sus marcas o productos propios mediante el pago de una contraprestación en dinero.
				<br><br>Se deja expresa constancia que Mundo Maquinaria no tendrá injerencia alguna en la determinación de los contenidos ni las imágenes que se publiquen en virtud de lo anterior, y tendrá siempre el derecho a eliminar, en cualquier momento, todos aquellos contenidos que no cumplan con lo dispuesto en estos TCG, en los estándares acordados y demás políticas de Mundo Maquinaria, como también todo aquello que vaya en contra del orden público, la moral y/o las buenas costumbres.
				<br><br><b>18. PAGOS</b>
				<br><br>Los pagos que el Cliente deba hacer a Mundo Maquinaria SpA en razón a los planes que contrate, deberán efectuarse dentro del plazo de vencimientos que se indica en la respectiva factura que se emita mensualmente al efecto. Los pagos deberán realizarse obligatoriamente mediante cheque nominativo y cruzado a favor de Mundo Maquinaria Spa; directamente en las entidades bancarias descritas en la factura o cualquier otra institución que Mundo Maquinaria SpA informará oportunamente; o bajo la modalidad de cargo en cuenta corriente o tarjeta de crédito según el mandato y las alternativas que se presenten.
				<br><br>En caso de no pago íntegro y oportuno de cualquiera de las obligaciones asumidas por el Cliente en razón a los contratos de que da cuenta el presente instrumento, Mundo Maquinaria SpA podrá suspender el servicio de publicaciones, avisos u otros, que el Cliente haya contratado.
				<br><br><b>19. GESTIÓN DE COBRANZA</b>
				<br><br>De conformidad a lo previsto en la ley Nº19.628, sobre Protección de Datos Personales y en la ley Nº 19.496, sobre Protección de los Derechos de los Consumidores, el Cliente autoriza desde ya y expresamente a Mundo Maquinaria para informar y hacer publicar en registros o bancos de datos personales, la circunstancia de encontrarse impago de una o más de las obligaciones que ha asumido en razón a los servicios contratados mediante la suscripción del presente instrumento y que den cuenta la o las facturas respectivas.

				</h5>
			</div>
		</div>

	</div>
	</form>
</div>
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
						<li><a href="https://twitter.com/mundomaquinaria" class="icon fa-twitter" target="_blank"><span class="label">Twitter</span></a></li>
						<li><a href="#" class="icon fa-facebook" target="_blank"><span class="label">Facebook</span></a></li>
						<li><a href="#" class="icon fa-instagram" target="_blank"><span class="label">Instagram</span></a></li>

					</ul>
					<ul class="copyright">
						<li><a data-toggle="modal" data-target="#myModal7">Contacto </a></li>
						<li><a data-toggle="modal" data-target="#myModal3">Privacidad</a></li>
						<li><a data-toggle="modal" data-target="#myModal8">Quiénes somos</a></li>
						<li><a data-toggle="modal" data-target="#myModal5">Términos de uso</a></li>
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
		<script type="text/javascript">
		  $(document).ready(function(){
				var mensaje = $.getURLParam("msg");
				if (mensaje != null) {
					if (mensaje == 1) {
						mostrarMensaje('Mensaje enviado exitosamente.', 'success');
					}
				}
			});
		</script>
	</body>
</html>
