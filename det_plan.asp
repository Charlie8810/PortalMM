<!--#include file="con_app.asp"-->
<!DOCTYPE HTML>
<html>
	<head>
		<%
		Const cdoSendUsingPort = 2
iServer = "smtp.gmail.com"
		Response.CodePage = 65001
		Response.CharSet = "utf-8"
		%>
		
		<link href="assets/css/bootstrap.css" rel="stylesheet" />
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
<script language = "JavaScript">
			<%
			productos_Sql = "SELECT Id_DatosComunes, Descripcion, Nivel_Superior FROM Datos_Comunes WHERE Tipo=4 and Nivel = 1 and Estado = 1 order by Descripcion asc "
			Set rs=nothing
			Set rs = cn.Execute(productos_Sql)
			x=0
			%>

			// FUNCION DE COMBO BOX COMBINADO

			function sublist(inform, selecteditem)
			{
			inform.subcatagory.length = 0

			<%
			count= 0
			y=0
			do while not rs.eof
			%>

			x = <%= trim(y) %>;

			subcat = new Array();
			subcatagorys = "<%=(rs("Descripcion")) %>";
			subcatagoryof = "<%=(rs("Nivel_Superior"))%>";
			subcatagoryid = "<%=(rs("Id_DatosComunes"))%>";
			subcat[x,0] = subcatagorys;
			subcat[x,1] = subcatagoryof;
			subcat[x,2] = subcatagoryid;
			if (subcat[x,1] == selecteditem) {
			var option<%= trim(count) %> = new Option(subcat[x,0], subcat[x,2]);
			inform.subcatagory.options[inform.subcatagory.length]=option<%= trim(count)%>;
			}
			<%
			count = count + 1
			y = y + 1
			rs.movenext
			loop
			rs.close
			%>
			}

		</script>
<script type="text/javascript">

</script>
	</head>
<%
if request.QueryString("opc") = "new" then   
	
	vNombre	=	request.form("nombre")
	vRut	=	request.form("rut")
	vIdTipPlan = request.form("tip_plan")
	vIdPlan = request.QueryString("vIdPlan")
	vMail = request.QueryString("mail")
	vTB		= request.QueryString("TB")
	
	sql="Exec ActualizaRegistro "
	sql=sql & " '" & request.form("nombre") & "', " 					'nombre 
	sql=sql & " '" & request.form("rut") & "', " 						'rut
	sql=sql & " '" & request.form("familia") & "', "	'region
	sql=sql & " '" & request.form("subcatagory") & "', "'ciudad
	sql=sql & " '', " 									'passw
	sql=sql & " '" & request.form("dir_fac") & "', " 	'direccion
	sql=sql & " '" & request.form("giro") & "', " 		'rubro
	sql=sql & " '" & request.form("nom_cont") & "', " 	'nombreContacto
	sql=sql & " '" & request.form("mail_cont") & "', " 	'mailContacto
	sql=sql & " '" & vMail & "', " 						'mailCotizacion
	sql=sql & " '" & request.form("tel_cont") & "', " 	'telefonoContacto
	sql=sql & " '" & vIdPlan & "', " 					'idPlan
	sql=sql & " '', " 									'vigencia 
	sql=sql & " '" & request.form("car_cont") & "', " 	'cargoContacto
	sql=sql & " '', " 									'logo
	sql=sql & " '' " 									'idTipoPago
	
	set Rs = nothing
	Set Rs = cn.Execute(sql)
	
	
	
%>
<script type="text/javascript">
	window.location="det_plan.asp?tipPag=1&vIdPlan=<%=vIdPlan%>&vRut=<%=vRut%>&TB=<%=vTB%>&msg=1";
</script>
<%
end if
if request.QueryString("opc")="PagManual" then

	Nombre  = request.Form("nombre")
	Mail    = request.Form("mail")
	Rut  = request.Form("rut")
	
	'Envio de mail para el administrador de mundomaquinaria
	
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
	MailObject.From	= "contacto@mundomaquinaria.cl"
	MailObject.To	= vCorreo_mundo_maquinaria
	MailObject.Subject = "Registro Cliente - Mundo Maquinaria"
	Cuerpo = "<br><br>Estimado(a) Administrador de Mundo Maquinaria, <br>&nbsp;&nbsp;&nbsp;&nbsp;Se ha registrado un nuevo cliente con pago manual. Favor validar el pago."
	Cuerpo = Cuerpo & " .<br><br>&nbsp;&nbsp;&nbsp;&nbsp;"
	Cuerpo = Cuerpo & "Los datos del cliente son: <br><br> Nombre:" & nombre & "<br> Mail: " & mail & "<br> Rut: " & rut & "</a>"
	Cuerpo = Cuerpo & "<br><br>"
	Cuerpo = Cuerpo & "Atentamente,<br>"
	Cuerpo = Cuerpo & "Web Mundo Maquinaria"
	Cuerpo = Cuerpo & "<br><br><br><br><br><br>Este mensaje ha sido generado automaticamente por favor no responder. Se han omitido intencionalmente los acentos."
	MailObject.HTMLBody = Cuerpo
	MailObject.Send
	Set MailObject = Nothing
	Set cdoConfig = Nothing
	
	'Mensaje paa el cliente que se registro.
	
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
	MailObject.From	= "contacto@mundomaquinaria.cl"
	MailObject.To	= mail
	MailObject.Subject = "Registro Cliente - Mundo Maquinaria"
	Cuerpo = "<br><br>Estimado(a) Cliente de Mundo Maquinaria, <br>&nbsp;&nbsp;&nbsp;&nbsp;Su solicitud esta siendo procesada. La administracion de mundo maquinaria se contactara con usted a la brevedad."
	Cuerpo = Cuerpo & " .<br><br>&nbsp;&nbsp;&nbsp;&nbsp;"
	Cuerpo = Cuerpo & "Los datos registrados son: <br><br> Nombre:" & nombre & "<br> Mail: " & mail & "<br> Rut: " & rut & "</a>"
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
	window.location="validacionclientemanual.asp?msg=1";
</script>
<%
end if
%>	
	
	
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
	MailObject.From	= vCorreo_mundo_maquinaria
	MailObject.To	= vCorreo_mundo_maquinaria
	'MailObject.To	= "gscarmona1@gmail.com"
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
			//alert("Mensaje enviado exitosamente.");
			window.location="index.asp?msg=2";
		</script>
		<%
end if
if request.QueryString("est") = "5" then  
		
		sql="exec ListaMailClientesUsuarioLogo "
		sql=sql & " '" & request.QueryString("rut") & "' "
		'response.write(sql)
		'response.end()
		
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
			
			rs.movenext
			loop
		
		end if
end if
%>
<%
vIdPlan = request.QueryString("vIdPlan")
vRut = request.QueryString("rut")
vNombre = request.QueryString("nombre")
vMail = request.QueryString("mail")
vTB		= request.QueryString("TB")
%>


	<body class="landing">
		<div id="messageDiv" style="display: none;"></div>	
		<div id="page-wrapper">

			<!-- Header -->
				<header id="header" class="alt header-registro">
					
					<h1><a href="index.asp"><img src="./images/logo_chico.png" /></a></h1>
					<div class="form-group" style="height: 15%;">
						<!-- #include file="HeaderMenu.asp" -->
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
					<div  style="margin-bottom: 25px;">
						<div class="12u">

							<!-- Table -->
								<section class="box box-table">
									<%if request.QueryString("tipPag") = "1" then%>
									<h3><p align="justify">Seleccione su forma de pago</p></h3>
									<hr>
									<table>
									<tr><form name="btnPago2" method="post">
										<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.btnPago2,'validacionclientemanual.asp?rut=<%=request.QueryString("vRut")%>');">PAGO MANUAL</button>
									</form></tr>
									<tr><form name="btnPago" method="get" action="https://webpay3g.transbank.cl/filtroUnificado/buttonService">
										<input type="hidden" name="buttonId" value="<%=vTB%>"/>
										<input type="image" src="https://www.transbank.cl/public/img/botonwebpay.gif"/>
									</form></tr>
									</table>
									<%else%>
									<h3><p align="justify">Detalle de contratación de su plan</p></h3>
									<hr>
									<form name="form1_crit" method="post">
									<h5><p align="justify" style="font-weight:bold; color:#3B5998; ">Detalle de datos del cliente</p></h5>
									<div class="form-group">
										<label>RAZÓN SOCIAL / NOMBRE :</label>
										<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="nombre" name="nombre" value="<%=vNombre%>" readonly /></td>
										<label>RUT :</label>
										<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="rut" name="rut" value="<%=vRut%>" readonly />
										<label>CORREO EMPRESA:</label>
										<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="mail" name="mail" value="<%=vMail%>" readonly />
										<label>DIRECCIÓN DE FACTURACIÓN :</label>
										<input placeholder="DIRECCIÓN DE FACTURACIÓN" class="form-control text-box-modal" type="text" style="color:#F7931E" id="dir_fac" name="dir_fac"/>
										<label>REGIÓN :</label>
										<!--<input class="form-control text-box-modal" type="text" style="color:#F7931E" id ="region" name="region"/>-->
										<select class="form-control text-box-modal" size="1" id="familia" name="familia" onChange = "javascript:sublist(this.form, familia.value);" style="font-weight:bold; color:#3B5998; height: 3em; cursor: pointer;" value="<%=Ucase(vRegion)%>">
											<option selected value = "0">SELECCIONE SU REGIÓN</option>
											<%familias_Sql = "SELECT Id_DatosComunes, Descripcion FROM Datos_Comunes WHERE Tipo = 3 and Nivel = 1 and Estado = 1"
											Set rs=nothing
											Set rs = cn.Execute(familias_Sql)
											do while not rs.eof
											%>
											<option value="<%=rs("Id_DatosComunes")%>"><%=Ucase(rs("Descripcion"))%></option>
											<%rs.movenext
											loop
											%>
										</select>
										<label>CIUDAD :</label>
										<!--<input class="form-control text-box-modal" type="text" style="color:#F7931E" id ="ciudad" name="ciudad"/>-->
										<SELECT class="form-control text-box-modal" id="subcatagory" name="subcatagory" size="1" style="font-weight:bold; color:#3B5998; height: 3em; cursor: pointer;" value="<%=Ucase(vCiudad)%>">
											<Option selected value="0">SELECCIONE SU CIUDAD</option>
										</SELECT>
										<label>GIRO :</label>
										<input placeholder="GIRO" class="form-control text-box-modal" type="text" style="color:#F7931E" id ="giro" name="giro"/>
										<label>NOMBRE DE CONTACTO :</label>
										<input placeholder="NOMBRE DE CONTACTO" class="form-control text-box-modal" type="text" style="color:#F7931E" id ="nom_cont" name="nom_cont"/>
										<label>MAIL DE CONTACTO :</label>
										<input placeholder="MAIL DE CONTACTO" class="form-control text-box-modal" type="text" style="color:#F7931E" id ="mail_cont" name="mail_cont"/>
										<label>REINGERSAR MAIL DE CONTACTO :</label>
										<input placeholder="REINGERSAR MAIL DE CONTACTO" class="form-control text-box-modal" type="text" style="color:#F7931E" id ="mail_cont2" name="mail_cont2"/>
										<label>TELEÉFONO DE CONTACTO :</label>
										<input placeholder="TELEÉFONO DE CONTACTO" class="form-control text-box-modal" type="text" style="color:#F7931E" id ="tel_cont" name="tel_cont"/>
										<label>CARGO DE CONTACTO :</label>
										<input placeholder="CARGO DE CONTACTO" class="form-control text-box-modal" type="text" style="color:#F7931E" id ="car_cont" name="car_cont"/>
																				<label style="color:#F7931E">*Todos los campos son obligatorios.	</label>								
										</div>
										<hr>
										<%

										sql = "exec ListarPlanes_Id"
										sql=sql & " " & vIdPlan & " "

										Set rs=nothing
										Set rs = cn.Execute(sql)
										vValorWP	= rs("vValorWP")
										vTip		= rs("tip")
										vTipo		= rs("tipo")
										vPlanes		= rs("planes")
										Desc1		= rs("descripcion")
										Desc2		= rs("desc2")
										Desc3		= rs("desc3")
										Desc4		= rs("desc4")
										Valor		= rs("valor")	
										%>
										<h4><p align="justify" style="font-weight:bold; color:#3B5998; ">Detalle de datos del plan</p></h4>
										<div class="form-group">
											<label>TIPO PLAN</label>
											<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="tip_plan" name="tip_plan" value="<%=vTipo%>" readonly />
											<label>NOMBRE PLAN</label>
											<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="plan" name="plan" value="<%=vPlanes%>" readonly />
											<label>CANTIDAD REGIONES</label>
											<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="regiones" name="regiones" value="<%=Desc1%>" readonly />
											<label>CANTIDAD EQUIPOS</label>
											<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="equipos" name="equipos" value="<%=Desc2%>" readonly />
											<label>VALOR TOTAL DEL PLAN</label>
											<%if vTip = "MENSUAL" then%>
												<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="valor" name="valor" value="$<%=FormatNumber(Valor,0)%>" readonly />
											<%elseif vTip = "SEMESTRAL" then%>
												<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="valor" name="valor" value="$<%=FormatNumber((Valor*6),0)%>" readonly />
											<%elseif vTip = "ANUAL" then%>
												<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="valor" name="valor" value="$<%=FormatNumber((Valor*12),0)%>" readonly />
											<%end if%>
										</div>
										<hr>
										<div class="checkbox">
											<label><input type="checkbox" name="acuerdo" id="acuerdo" value="falses"><a data-toggle="modal" data-target="#myModal10" style = "cursor: pointer;">Términos Legales</a></label>
											
										</div>
										<div class="form-actions">
										  <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'registro.asp?rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>');">VOLVER</button>
										  <button type="button" class="btn btn-success" onClick="javascript:validarRegistro(document.forms.form1_crit,'det_plan.asp?opc=new&vIdPlan=<%=vIdPlan%>&TB=<%=vTB%>');">GUARDAR</button>
										
									</form>		
								
								<%end if%>
								</div>
								</div>
							</section>

						</div>
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
							<option value="0">OTROS</option>
						</select>
					  </div>
			</div>
			<div class="form-group">
				<label>MENSAJE</label>
				<textarea class="text-area" name="men_cont" id="men_cont"></textarea>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-success" onClick="javascript:validaRegistro(document.forms.formContacto,'index.asp?est=2');">ENVIAR</button>
		</div>
	</div>
	
</div>
</form>
</div>
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
<div class="modal fade" id="myModal10" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
<!-- #include file="ModalHeaderMenu.asp" -->

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
						<li><a href="https://www.facebook.com/mundomaquinaria" class="icon fa-facebook" target="_blank"><span class="label">Facebook</span></a></li>
						<li><a href="https://www.instagram.com/mundomaquinaria.cl/" class="icon fa-instagram" target="_blank"><span class="label">Instagram</span></a></li>
						
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
			if (mensaje == 1) {
				mostrarMensaje('Se registró correctamente, se le enviará un mail con su información de ingreso.', 'success');
			} else if (mensaje == 2) {
				mostrarMensaje('Mensaje enviado exitosamente.','success');
			}
		});

		function validarRegistro(formulario, pagina){		
			var Direccion 			= document.getElementById('dir_fac').value;
			var Region 				= document.getElementById('familia').selectedIndex;
			var Ciudad 				= document.getElementById('subcatagory').selectedIndex;
			var Giro 				= document.getElementById('giro').value;
			var NombreContacto 		= document.getElementById('nom_cont').value;
			var MailContacto 		= document.getElementById('mail_cont').value;
			var MailContacto2 		= document.getElementById('mail_cont2').value;
			var TelefonoContacto 	= document.getElementById('tel_cont').value;
			var CargoContacto 		= document.getElementById('car_cont').value;
			
			if(Direccion == null || Direccion.length == 0 || /^\s+$/.test(Direccion)){
				//alert('ERROR: El campo Rut no debe ir vacío');
				mostrarMensaje('Estimado Usuario, Debe ingresar una DIRECCION válida', 'error');
				return false;
			}
			if(Region == null || Region == 0){
				//alert('ERROR: Debe seleccionar un Equipo');
				mostrarMensaje('Estimado Usuario, Para continuar debe seleccione una REGION', 'error');
				return false;
			}

			if(Giro == null || Giro.length == 0 || /^\s+$/.test(Giro)){
				//alert('ERROR: El campo Rut no debe ir vacío');
				mostrarMensaje('Estimado Usuario, Debe ingresar un GIRO válido', 'error');
				return false;
			}
			if(NombreContacto == null || NombreContacto.length == 0 || /^\s+$/.test(NombreContacto)){
				//alert('ERROR: El campo Rut no debe ir vacío');
				mostrarMensaje('Estimado Usuario, Debe ingresar un NOMBRE DE CONTACTO válido', 'error');
				return false;
			}
			if(MailContacto == null || MailContacto.length == 0 || /^\s+$/.test(MailContacto)){
				//alert('ERROR: El campo Rut no debe ir vacío');
				mostrarMensaje('Estimado Usuario, Debe ingresar un MAIL DE CONTACTO válido', 'error');
				return false;
			}
			if(MailContacto != MailContacto2 ){
				mostrarMensaje('Los correos ingresados no son iguales', 'error');
				//alert("Las contraseñas no son iguales")
				return false;
			}
			if(TelefonoContacto == null || TelefonoContacto.length == 0 || /^\s+$/.test(TelefonoContacto)){
				mostrarMensaje('Estimado Usuario, Debe ingresar un TELEFONO DE CONTACTO válido', 'error');
				return false;
			}
			if(CargoContacto == null || CargoContacto.length == 0 || /^\s+$/.test(CargoContacto)){
				mostrarMensaje('Estimado Usuario, Debe ingresar un CARGO DE CONTACTO válido', 'error');
				return false;
			}
			if(!document.getElementById('acuerdo').checked	){
				mostrarMensaje('Estimado Usuario, Debe aprobar los términos legales', 'error');
				//alert("Estimado Usuario, Debe aprobar los terminos legales")
				document.form1_crit.acuerdo.focus()
				return false;
			}
			
			irA(formulario, pagina);	
		}
		// function comprobar(){		
		// 	if(!document.getElementById('acuerdo').checked	){
		// 		mostrarMensaje('Estimado Usuario, Debe aprobar los términos legales', 'error');
		// 		//alert("Estimado Usuario, Debe aprobar los terminos legales")
		// 		document.form1_crit.acuerdo.focus()
		// 		return false;
		// 	}
		// 	return true;	
		// }
	</script>


	</body>
</html>