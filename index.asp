<!--#include file="con_app.asp"-->
<!DOCTYPE HTML>
<html>
	<head>
	<!--Mail vencimiento del plan-->
	<%
	Const cdoSendUsingPort = 2
	iServer = "smtp.gmail.com"
		Response.ContentType = "text/html"
		Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
		Response.CodePage = 65001
		Response.CharSet = "UTF-8"
		
		sql="exec VencimientoPlan "
		set Rs = nothing
		Set Rs = cn.Execute(sql)
		if not rs.eof then
			do while not rs.eof
				vIdPago			= rs("id_pago")
				vNombreUsuario  = rs("nombre")
				vMailUsuario	= rs("Mail")
				vFechaPago		= rs("fec_pago")
				vValor			= rs("valor")
				vTipoPago		= rs("tipoPago")
				vFecInicio		= rs("fec_inicio")
				vFecTermino		= rs("fec_termino")
				vIdPlan			= rs("id_Plan")
				vVigencia		= rs("vigencia")
				vIdTipoPlan		= rs("id_Tipo_Plan")
				vTipoPlan		= rs("tip")
				vDescPlan		= rs("tipPlan")
				vTotal			= rs("total")
				vDiasDur		= rs("diasduracion")
				
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
			MailObject.To	= vMailCotizacion & ";" & vMailUsuario
			MailObject.Subject = "Vigencia del Plan"
			Cuerpo = "<br><br><h3 style=color:#3B5998Estimado(a) Cliente " & vNombreUsuario & ", <br>&nbsp;&nbsp;&nbsp;&nbsp;Su plan esta próximo a vencer favor regularizar.<br> "
			Cuerpo = Cuerpo & "Los datos de su plan contratado son:</h3> <br><br><h4 style=color:#F7931E>  Tipo Plan: " & vTipoPlan & "<br>Nombre: " & vDescPlan & "<br> Valor total: " & vTotal & "<br> Fecha inicio: " & vFecInicio & "<br> Fecha Término: " & vFecTermino & "</a>"
			Cuerpo = Cuerpo & "<br>Días duración: " & vDiasDur & "<br> Tipo de pago: " & vTipoPago
			Cuerpo = Cuerpo & "</h4><br><br>"
			Cuerpo = Cuerpo & "<h3 style=color:#3B5998>Atentamente,<br>"
			Cuerpo = Cuerpo & "Equipo Mundo Maquinaria</h3>"
			Cuerpo = Cuerpo & "<br><br><img src= http://www.mundomaquinaria.cl/marchablanca/images/logo2.png>"

			MailObject.HTMLBody = Cuerpo
			MailObject.Send
			Set MailObject = Nothing
			Set cdoConfig = Nothing

			sql="exec MensajeEnviado "
			sql=sql & " '" & vIdPago & "'"
			set Rs1 = nothing
			Set Rs1 = cn.Execute(sql)
			
			rs.movenext
			loop
		end if
		%>
	<!--Fin vencimiento del plan -->
	
	
		<!-- Cuenta visitas-->
		<%


		Response.CodePage = 65001
		Response.CharSet = "utf-8"

		sql="exec CuentaVisitas "
		set Rs = nothing
		Set Rs = cn.Execute(sql)

		%>
		<!-- Fin Cuenta visitas-->
		<!-- [Renato] : Se comenta llamada de hoja de estilo, ya que no existe. -->
		<!-- <link rel="stylesheet" type="text/css" href="estilo.css" /> -->
		<title>Mundo Maquinaria</title>
		<link href="assets/css/bootstrap.css" rel="stylesheet" />
		<link href="assets/css/font-awesome.css" rel="stylesheet" />
 		<link href="assets/css/style.css" rel="stylesheet" />
		<link rel="icon" type="image/png" href="./images/icon.ico" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" href="assets/css/main.css" />
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
<!--

------Validaciones JavaScript ---------------------
----------------- GSC 2017-07-01 ------------------
-->
<script type="text/javascript">
function validaContacto(formulario, pagina){

	var Nombre		= document.getElementById('nom_cont2').value;
	var Mail		= document.getElementById('mail_cont2').value;
	var Mensaje		= document.getElementById('men_cont').value;

	if(Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)){
			mostrarMensaje('El Nombre no debe estar en blanco','error');
		return false;
		}

	if(Mail == null || Mail.length == 0 || /^\s+$/.test(Mail)){
			mostrarMensaje('El Mail no debe estar en blanco','error');
		return false;
		}
		expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if ( !expr.test(Mail) ){
        mostrarMensaje('La dirección de correo ' + Mail + ' es incorrecta','error');
		return false;
		}

	if(Mensaje == null || Mensaje.length == 0 || /^\s+$/.test(Mensaje)){
			mostrarMensaje('Debe escribir un mensaje','error');
		return false;
		}

	irA(formulario, pagina);
}
</script>
<script type="text/javascript">
function ValidaPopUp() {
	var resultado = false;
	$('.popUp-validacion').each(function( index ) {
		if($(this).height() > 0) {
			resultado = false;
			console.log("return false");
			return false;
		} else {
			resultado = true;	
		}
	});
	console.log("resultado: " + resultado);
	return resultado;
}

function validarCotizacion(formulario, pagina) {
	if(ValidaPopUp()) {
		var cmb_Equipo 			= document.getElementById('equipo').selectedIndex;
		var cmb_Region 			= document.getElementById('familia').selectedIndex;
		var Rut 				= document.getElementById('textfield').value;
		var Nombre 				= document.getElementById('textfield2').value;
		var Mail 				= document.getElementById('textfield3').value;
		var NombreContacto 		= document.getElementById('textfield4').value;
		var TelefonoContacto 	= document.getElementById('textfield5').value;

		// Patron para el correo
		var expr
		expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

		if(cmb_Equipo == null || cmb_Equipo == 0){
				//alert('ERROR: Debe seleccionar un Equipo');
				mostrarMensaje('Estimado Usuario, Para continuar con su búsqueda seleccione un EQUIPO', 'error');
				return false;
		}
		if(cmb_Region == null || cmb_Region == 0){
				mostrarMensaje('Estimado Usuario, Para continuar con su búsqueda seleccione una REGION', 'error');
				return false;
		}
		if(Rut == null || Rut.length == 0 || /^\s+$/.test(Rut)){
				mostrarMensaje('Estimado Usuario, Para realizar su cotización ingrese su RUT (Ej. 11111111-1)', 'error');
				return false;
		}
		if(Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)){
				mostrarMensaje('Estimado Usuario, Para realizar su cotización ingrese su NOMBRE', 'error');
				return false;
		}
		if(Mail == null || Mail.length == 0 || /^\s+$/.test(Mail)){
				mostrarMensaje('Estimado Usuario, Para realizar su cotización ingrese su Mail', 'error');
				return false;
		}
		if ( !expr.test(Mail) ){
					mostrarMensaje('Estimado Usuario, La dirección de correo "' + Mail + '" es incorrecta.', 'error');
			return false;
		}

		if(NombreContacto == null || NombreContacto.length == 0 || /^\s+$/.test(NombreContacto)){
				//alert('ERROR: El campo Nombre Contacto no debe ir vacío');
				mostrarMensaje('Estimado Usuario, Para realizar su cotización favor ingrese un NOMBRE DE CONTACTO', 'error');
				return false;
		}
		if(TelefonoContacto == null || TelefonoContacto.length != 9 || /^\s+$/.test(TelefonoContacto)){
				//alert('El telefono debe contener 9 digitos');
				mostrarMensaje('Estimado Usuario, El Teléfono debe contener 9 dígitos', 'error');
				return false;
		}

		if (!/^([0-9])*$/.test(TelefonoContacto)){
		//alert("El valor " + TelefonoContacto + " no es un número");
				mostrarMensaje('Estimado Usuario, El valor para Teléfono "' + TelefonoContacto + '" no es un número', 'error');
		return false;
		}
		irA(formulario, pagina);
	} else {
		mostrarMensaje('Estimado Usuario, favor corrija los errores', 'error');
	}
}
</script>
<!--  Ejecuciones sobre botones  -->
<%
if request.QueryString("est") = "new" then

	vRut = request.form("Rut_Reg")
	vNombre = request.form("Nom_Reg")
	vMail = request.form("Mail_Reg")
	vPass = request.form("password")

	sql="Exec ValidaRutMail "
	sql=sql & " '" & vRut & "', "     	 'nombre 
	sql=sql & " '" & vMail & "' "      'equipo	
	
	set Rs = nothing
	Set Rs = cn.Execute(sql)

	if not rs.eof then
		vMensaje = rs("mensaje")
		if vMensaje = "RUT" then
		%>
		<script type="text/javascript">
			window.location="index.asp?msg=5";
		</script>
		<%
		elseif vMensaje = "MAIL" then
		%>
		<script type="text/javascript">
			window.location="index.asp?msg=17";
		</script>
		<%
		
		else
	
		sql="Exec InsertaCliente "
		sql=sql & " '" & vNombre & "', "     	 'nombre 
		sql=sql & " '" & vRut & "', "      'equipo
		sql=sql & " '' " & ", " 	 'region
		sql=sql & " '', " 'ciudad
		sql=sql & " '" & vPass & "', " 'passw
		sql=sql & " '', " 'direccion
		sql=sql & " '', " 'rubro
		sql=sql & " '', " 'nombreContacto
		sql=sql & " '', " 'mailContacto
		sql=sql & " '" & vMail & "', " 'mailCotizacion
		sql=sql & " '', " 'telefonoContacto
		sql=sql & " '', " 'idPlan
		sql=sql & " '" & 1 & "', " 'vigencia 
		sql=sql & " '', " 'cargoContacto
		sql=sql & " '', " 'logo
		sql=sql & " '' " 'idTipoPago
		
		set Rs = nothing
		Set Rs = cn.Execute(sql)
		
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
	MailObject.To	= vMail
	MailObject.Subject	= "Registro - Mundo Maquinaria"
	Cuerpo = "<br><br>Estimado(a) se encuentra a solo un paso de pertenecer al equipo de Mundo Maquinaria, <br>&nbsp;&nbsp;&nbsp;&nbsp;Su usuario y contraseña temporal es:"
	Cuerpo = Cuerpo & " .<br><br>&nbsp;&nbsp;&nbsp;&nbsp;"
	Cuerpo = Cuerpo & "<br><br> RUT:" & vRut & "<br> Contraseña: " & vPass & "<br> </a>"
	Cuerpo = Cuerpo & "<br><br> Su cuenta quedara activada luego de que seleccione un plan."
	Cuerpo = Cuerpo & "<h3 style=color:#3B5998>Atentamente,<br>"
	Cuerpo = Cuerpo & "Equipo Mundo Maquinaria</h3>"
	Cuerpo = Cuerpo & "<br><br><img src= http://www.mundomaquinaria.cl/marchablanca/images/logo2.png>"
	MailObject.HTMLBody = Cuerpo
	MailObject.Send
	Set MailObject = Nothing
	Set cdoConfig = Nothing	
		
		
	%>
	<script type="text/javascript">
		window.location="Registro.asp?tip=0&rut=<%=vRut%>&nombre=<%=vNombre%>&mail=<%=vMail%>";
	</script>
	<%
	end if
	end if
end if

if request.QueryString("est") = "1" then
	sql="Exec Inserta_Cotizacion "
		sql=sql & request.Form("tipo") & ", "     	 'tipo
		sql=sql & request.Form("equipo") & ", "      'equipo
		sql=sql & request.Form("familia") & ", " 	 'region
		sql=sql & request.Form("subcatagory") & ", " 'ciudad
		sql=sql & " '', "
		sql=sql & " '', "
		sql=sql & " '', "
		sql=sql & " '', "
		sql=sql & " '" & request.Form("textfield") & "', "
		sql=sql & " '" & request.Form("textfield4") & "', "
		sql=sql & " '" & request.Form("textfield3") & "', "
		sql=sql & " '" & request.Form("textfield5") & "', "
		sql=sql & " '" & request.Form("textfield2") & "', "
		sql=sql & " '' "

		set Rs = nothing
		Set Rs = cn.Execute(sql)

	%>
		<script type="text/javascript">
			//alert("Cotización agregada exitosamente.");
			//mostrarMensaje('Cotización agregada exitosamente','success');
			window.location="index.asp?rutCotiza=<%=request.Form("textfield")%>&msg=1";
		</script>
		<%
end if
if request.QueryString("est") = "9" then
	
	sql="Exec actualizaOpcAvanzadas "
		sql=sql & request.QueryString("vIdCot") & ", "     	 
		sql=sql & " '" & request.Form("operador") & "', "     
		sql=sql & " '" & request.Form("combustible") & "', "
		sql=sql & " '" & request.Form("traslados") & "', "
		sql=sql & " '" & request.Form("mensaje") & "', "
		sql=sql & " '" & request.Form("plazos") & "'"
		set Rs = nothing
		Set Rs = cn.Execute(sql)

	%>
		<script type="text/javascript">
			window.location="index.asp?rutCotiza=<%=request.Form("textfield")%>&msg=1";
		</script>
		<%
end if
if request.QueryString("est") = "2" then

    nombre  = request.Form("nom_cont")
	mail    = request.Form("mail_cont")
	asunto  = request.Form("textfield3")
	mensaje = request.Form("men_cont")

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
	MailObject.To	= vCorreo_Cotizacion
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
	Cuerpo = Cuerpo & "<h3 style=color:#3B5998>Atentamente,<br>"
	Cuerpo = Cuerpo & "Equipo Mundo Maquinaria</h3>"
	Cuerpo = Cuerpo & "<br><br><img src= http://www.mundomaquinaria.cl/marchablanca/images/logo2.png>"
	MailObject.HTMLBody = Cuerpo
	MailObject.Send
	Set MailObject = Nothing
	Set cdoConfig = Nothing
		%>
		<script type="text/javascript">
			//alert("Mensaje enviado exitosamente")
			//mostrarMensaje('Mensaje enviado exitosamente','success');
			window.location="index.asp?msg=3";
		</script>
		<%
end if

<!--Inicio Tabla del carrito de compras-->
if request.QueryString("est")= "4" then
	var_chk_sel = request.QueryString("idCotiza")

	sql="exec EliminaCotizacion "
	sql=sql & " '" & var_chk_sel & "' "

	set Rs = nothing
	Set Rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//alert("Cotización eliminada exitosamente")
		//mostrarMensaje('Cotización eliminada exitosamente','success');
		window.location="index.asp?rutCotiza=<%=request.queryString("rut")%>&msg=2";
	</script>
<%
end if

if request.QueryString("est") = "5" then

		sql="exec ListaMailClientesUsuarioLogo "
		sql=sql & " '" & request.QueryString("rutCotiza") & "' "

		Response.ContentType = "text/html"
		Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
		Response.CodePage = 65001
		Response.CharSet = "UTF-8"

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
			MailObject.To	= vMailCotizacion & ";" & vMailUsuario
			MailObject.Subject = "Envio de Cotizacion"
			Cuerpo = "<br><br><h3 style=color:#3B5998Estimado(a) Cliente " & vNombreCliente & " de Mundo Maquinaria, <br>&nbsp;&nbsp;&nbsp;&nbsp;Se ha enviado una cotizacion "
			Cuerpo = Cuerpo & "con los siguientes datos:</h3> <br><br><h4 style=color:#F7931E>  Tipo Cotizacion: " & vTipoCotiza & "<br>Nombre: " & vNombreUsuario & "<br> mail: " & vMailUsuario & "<br> Telefono: " & vTelefonoUsuario & "<br> Equipo: " & vEquipo & "</a>"
			Cuerpo = Cuerpo & "<br>Region: " & vRegion & "<br> Ciudad: " & vCiudad & "<br> Mensaje: " & vMensaje
			Cuerpo = Cuerpo & "<br>Adicionales: <br><br>Con Operador:" & vOperador & "<br> Con Combustible: " & vCombustible & "<br> Con Traslados: " & vTraslados
			Cuerpo = Cuerpo & "</h4><br><br>"
			Cuerpo = Cuerpo & "<h3 style=color:#3B5998>Atentamente,<br>"
			Cuerpo = Cuerpo & "Equipo Mundo Maquinaria</h3>"
			Cuerpo = Cuerpo & "<br><br><img src= http://www.mundomaquinaria.cl/marchablanca/images/logo2.png>"

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
			//alert("Sus cotizaciones fueron enviadas a nuestros distintos proveedores. Favor espere a que el/ellos lo contacten")
			//mostrarMensaje('Sus cotizaciones fueron enviadas a nuestros distintos proveedores. Favor espere a que el/ellos lo contacten','info');
			window.location="index.asp?msg=4";
		</script>
		<%

end if
if request.QueryString("est") = "6" then
	var_cotiza=request.QueryString("tipo")
	if len(var_cotiza) > 0 then
	%>
	<script type="text/javascript">
		//alert("Cotizacion agregada exitosamente")
		//mostrarMensaje('Cotizacion agregada exitosamente','success');
		window.location="cotizacion.asp?est=5&rut=<%=vRut%>&msg=1";
	</script>
	<%

end if
	%>
		<script type="text/javascript">
			//alert("Cotizacion agregada exitosamente")
			//mostrarMensaje('Cotizacion agregada exitosamente','success');
			window.location="cotizacion.asp?est=5&rut=<%=vRut%>&msg=1";
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
		vRazonSocial	= rs("razonsocial")
		vNombre			= rs("nombre")
		vMail			= rs("mail")
		vTelefono		= rs("telefono")

	end if
%>
	<body class="landing">
		<div id="messageDiv" style="display: none;">
		</div>
		<div id="page-wrapper">

			<!-- Header -->
				<header id="header" class="alt">
					<h1><a href="index.asp"><img src="./images/logo_chico.png" /></a></h1>
					<div class="form-group" style="height: 15%;">
<nav id="nav">
    <ul>
        <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" viewBox="0 0 50 50" x="0px" y="0px" width="32px" height="32px" enable-background="new 0 0 50 50" class="svg-icon-user">
            <circle class="svg-icon-user-c" cx="25" cy="25" fill="none" r="24" stroke="#f7931e" stroke-linecap="round" stroke-miterlimit="10" stroke-width="2"></circle>
            <path class="svg-icon-user-p" d="M29.933,35.528c-0.146-1.612-0.09-2.737-0.09-4.21c0.73-0.383,2.038-2.825,2.259-4.888c0.574-0.047,1.479-0.607,1.744-2.818  c0.143-1.187-0.425-1.855-0.771-2.065c0.934-2.809,2.874-11.499-3.588-12.397c-0.665-1.168-2.368-1.759-4.581-1.759  c-8.854,0.163-9.922,6.686-7.981,14.156c-0.345,0.21-0.913,0.878-0.771,2.065c0.266,2.211,1.17,2.771,1.744,2.818  c0.22,2.062,1.58,4.505,2.312,4.888c0,1.473,0.055,2.598-0.091,4.21c-1.261,3.39-7.737,3.655-11.473,6.924  c3.906,3.933,10.236,6.746,16.916,6.746s14.532-5.274,15.839-6.713C37.688,39.186,31.197,38.93,29.933,35.528z"
                fill="#f7931e">
            </path>
        </svg>
        <li>
            <button class="button btn-entrar nav-button" id="btnEntrar" data-toggle="modal" data-target="#myModal1">
                ENTRAR
            </button>
        </li>
        <li>
            <div class="btn-header">
				<button type="button" class="button btn-entrar nav-button" id="btnPublicaTuMaquina" style="background: transparent;color: #f7931e;font-family: 'Montserrat', sans-serif;letter-spacing: 5px;border-left: solid 3px #f7931e;border-radius: 0px;font-weight: bold;" data-toggle="modal" data-target="#myModal2">
                    PUBLICAR
                </button> 
                </button>
            </div>
        </li>
    </ul>

					</div>
					<!-- [Renato] : Inicio -->
					<div class="form-group">
						<nav id="nav2" style="display: none;"></nav>
					</div>
					<!-- [Renato] : Fin -->
				</header>
                                <!--Logo Mobile -->
				<!-- <header id="header" class="alt logo-index">
					<h1><a href="index.asp"><img src="./images/logo_chico.png" /></a></h1>
				</header> -->
				<!--FIN Logo Mobile -->

			<!-- Banner -->
				<section id="banner" class="banner-index">
					<!--<h2>La máquina que buscas está aquí</h2>-->
					<h3 style="font-weight:bold; color:#FFFFFF"><img src="./assets/img/logoMMBlancoV2.png" class="img-logo-blanco" alt="11" width="552" height="156" longdesc="11"></h3>
					<h3 style="font-weight:bold; color:#FFFFFF">LA MAQUINA QUE BUSCAS A UN SOLO CLICK</h3>

					<ul class="actions">
						<form name="formCotizacion" method="post" >
						<nav id="nav1"><!-- [Renato] : Se cambia "id" para copiar el contenido innerHtml y replicar en el header. -->
						<ul class="nav-ul-top">

							<li>
								<div class="select-wrapper">
									<%
									sql ="exec Seleccionar_Datos_Comunes "
									sql = sql & "2 "
									Set rs=nothing
									Set rs = cn.Execute(sql)
									%>
									<select name="tipo" id="tipo" class="tipo-venta" onChange="javascript:TipoVentaChange(this);" style="font-weight:bold; color:#3B5998; cursor: pointer;" value="<%=vTipo%>">
										<%
										if not rs.eof then
											do while not rs.eof
												if cdbl(rs("Id_DatosComunes")) = cdbl(vDescrip) then
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
							</li>
							<li>
								<div class="select-wrapper">
									<%
									sql ="exec Seleccionar_Datos_Comunes "
									sql = sql & "1 "
									Set rs=nothing
									Set rs = cn.Execute(sql)
									%>
									<select name="equipo" id="equipo" class="tipo-venta" onChange = "javascript:ValorEquipo()" style="font-weight:bold; color:#3B5998; cursor: pointer;" value="<%=vEquipo%>">
										<%
										response.write "<option value=0>EQUIPO</option>"
										if not rs.eof then
											do while not rs.eof
												if cdbl(rs("Id_DatosComunes")) = cdbl(vDescrip) then
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
							</li>
							<li>
	<div class="select-wrapper">
		<script type="text/javascript">
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
			ValorRegion();
			}

			function sublist2(inform, selecteditem2)
			{
			    //console.log('sublist2()');
			    ValorRegion();
			}
	
			</script>
			<select size="1" id="familia" name="familia" onChange = "javascript:sublist(document.forms.formCotizacion, familia.value);" style="font-weight:bold; color:#3B5998; height: 3em; cursor: pointer;" value="<%=Ucase(vRegion)%>">

			<option selected value = "0">REGION</option>
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
	</div>
	</li>
	<li>
	<div class="select-wrapper">
		<SELECT id="subcatagory" name="subcatagory" onChange = "javascript:ValorCiudad()" size="1" style="font-weight:bold; color:#3B5998; height: 3em; cursor: pointer;" value="<%=Ucase(vCiudad)%>">
			<Option selected value="0">CIUDAD</option>
		</SELECT>
	</div>
	</li>
							<li>
								<div class="btn-header">
								<button type="button" class="button"  id="bt_cotizar" onclick="javascript:BtnCotizarClick();" style="background:#F7931E" data-toggle="modal" data-target="#myModal9">
									COTIZAR
								</button>
                             </div>
	<!-- POPUP-->			</li>
							
							<!--nico-->
							<li><svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" viewBox="0 0 50 50" x="0px" y="0px" width="32px" height="32px" enable-background="new 0 0 50 50" class="svg-icon-user">
            <circle class="svg-icon-user-c" cx="25" cy="25" fill="none" r="24" stroke="#f7931e" stroke-linecap="round" stroke-miterlimit="10" stroke-width="2"></circle>
            <path class="svg-icon-user-p" d="M29.933,35.528c-0.146-1.612-0.09-2.737-0.09-4.21c0.73-0.383,2.038-2.825,2.259-4.888c0.574-0.047,1.479-0.607,1.744-2.818  c0.143-1.187-0.425-1.855-0.771-2.065c0.934-2.809,2.874-11.499-3.588-12.397c-0.665-1.168-2.368-1.759-4.581-1.759  c-8.854,0.163-9.922,6.686-7.981,14.156c-0.345,0.21-0.913,0.878-0.771,2.065c0.266,2.211,1.17,2.771,1.744,2.818  c0.22,2.062,1.58,4.505,2.312,4.888c0,1.473,0.055,2.598-0.091,4.21c-1.261,3.39-7.737,3.655-11.473,6.924  c3.906,3.933,10.236,6.746,16.916,6.746s14.532-5.274,15.839-6.713C37.688,39.186,31.197,38.93,29.933,35.528z"
                fill="#f7931e">
            </path>
        </svg>
							<li>
								  <!--<div class="form-group">-->
										<div style="float: left;">
											<a data-toggle="modal" data-target="#myModal4" class="btn carrito glyphicon glyphicon-shopping-cart" ></a>
										</div>
										<%
										sql="exec ObtenerCantidadCarritoPorUsuario " & " '" & vRut2 & "' "
										set rs = nothing
										Set rs = cn.Execute(sql)

										if not rs.eof then
											Do while not rs.eof

											vCantidadCarrito = rs("CantidadCarrito")
											rs.movenext

											loop
										end if
										%>
										<div class="carrito-numero"><strong><%=vCantidadCarrito%></strong></div>
										<div class="modal fade" id="myModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
											<div class="col-md-12">
											 <!--   Basic Table  -->
											<div class="panel panel-default">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
													<h4 class="modal-title" id="myModalLabel" style="color:#FFFFFF">LISTADO DE SOLICITUD DE COTIZACIÓN</h4>
												</div>
												<div class="panel-body">
													<div class="table-responsive">
														<table class="table">
															<thead>
																<tr>
																	<TH>OPC</TH>
																	<TH>OPC. AV</TH>
																	<TH>TIPO COTIZACION</TH>
																	<TH>EQUIPO</TH>
																	<TH>REGIÓN</TH>
																	<TH>CIUDAD</TH>
																	<TH>RUT</TH>
																	<TH>NOMBRE</TH>
																	<TH>EMAIL</TH>
																	<TH>TELÉFONO</TH>
																</tr>
															</thead>
															<tbody>
															<%
															if vRut2 <> "" then
															sql="exec ListarCotizacionPorUsuario "
															sql=sql & " '" & vRut2 & "' "
															set rs = nothing
															Set rs = cn.Execute(sql)
															if not rs.eof then
																Do while not rs.eof
																vIdCotiza 		= rs("Id_Cotiza")
																vIdTipoCotiza 	= rs("Id_Tipo_Cotiza")
																vIdEquipo		= rs("Id_Equipo")
																vIdRegion		= rs("Id_Region")
																vIdCiudad		= rs("Id_Ciudad")
																vRut			= rs("rut")
																vNombre			= rs("nombre")
																vMail			= rs("mail")
																vTelefono		= rs("telefono")
																%>
																<tr>
																	
																	<td><button type="button"  style="background:#F7931E" onClick="javascript:irA(document.forms.formCotizacion,'index.asp?est=4&rut=<%=vRut%>&idCotiza=<%=vIdCotiza%>');">ELIMINAR</button></td>
																	<td>
																	<ul>
							<li>
								<div class="accordion-heading">
									<div class="widget-title">
										<a class="opt-avanz" data-toggle="modal" data-target="#modalOpcAvanz" style=" cursor: pointer;">
											<span class="icon"><i class="glyphicon glyphicon-wrench"></i></span>
										</a>
									</div>
								</div>
								<!-- Modal -->
								<div class="modal fade" id="modalOpcAvanz" role="dialog">
									<div class="modal-dialog">
										
										<!-- Modal content-->
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">&times;</button>
												<h4 class="modal-title">Opciones Avanzadas</h4>
											</div>
											<div class="modal-body align-left">
													<div class="checkbox">
														<label><input type="checkbox" name="operador" id="operador" value="1">Con Operador</label>
													</div>
													<div class="checkbox">
														<label><input type="checkbox" name="combustible" id="combustible" value="1">Combustible</label>
													</div>
													<div class="checkbox">
														<label><input type="checkbox" name="traslados" id="traslados" value="1">Traslados</label>
													</div>
													<div class="form-group">
														<label>Plazos de Arriendo</label>
															<div class="select-wrapper">
																<%
																sql ="exec Seleccionar_Datos_Comunes_Plazos "
																sql = sql & "12 "
																Set rsa=nothing
																Set rsa = cn.Execute(sql)
																%>
																<select name="plazos" id="plazos" style="font-weight:bold; color:#3B5998; cursor: pointer;" value="<%=vPlazos%>">
																	<%
																	'response.write "<option value=0>PLAZOS DE ARRIENDO</option>"
																	if not rsa.eof then
																		do while not rsa.eof
																			if cdbl(rsa("Id_DatosComunes")) = cdbl(vDescrip) then
																				response.write "<option selected value=" & rsa("Id_DatosComunes") & ">" & ucase(rsa("Descripcion")) & "</option>"
																			else
																				response.write "<option value=" & rsa("Id_DatosComunes") & ">" & ucase(rsa("Descripcion")) & "</option>"
																			end if
																			rsa.movenext
																		loop
																	end if
																	%>
																</select>
															  </div>
													</div>
													<div class="control-group">
														<label class="control-label">Mensaje:
															<textarea class="text-area" name="mensaje" id="mensaje"></textarea>
														</label>
													</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default" onClick="javascript:irA(document.forms.formCotizacion,'index.asp?est=9&vIdCot=<%=vIdCotiza%>&vPla=<%=request.Form("plazos")%>');">OK</button>
											</div>
										</div>
										
									</div>
								</div>
							</li>
						</ul>
																	</td>
																	<%
																	  sql="exec BuscaNombreTipoDato "
																	  sql=sql & " " & vIdTipoCotiza & " "
																	  set rs1 = nothing
																	  Set rs1 = cn.Execute(sql)
																	  %>
																	<td style="color:#3B5998"><%=Ucase(rs1("Descripcion"))
																	%></td>

																	<%
																	  sql="exec BuscaNombreTipoDato "
																	  sql=sql & " " & vIdEquipo & " "
																	  set rs2 = nothing
																	  Set rs2 = cn.Execute(sql)
																	  %>
																	<td style="color:#3B5998"><%=rs2("Descripcion")
																	%></td>

																	<%
																	  sql="exec BuscaNombreTipoDato "
																	  sql=sql & " " & rs("Id_Region") & " "
																	  set rs2 = nothing
																	  Set rs2 = cn.Execute(sql)
																	  %>
																	<td style="color:#3B5998"><%=Ucase(rs2("Descripcion"))
																	%></td>

																	<%
																	  sql="exec BuscaNombreTipoDato "
																	  sql=sql & " " & rs("Id_Ciudad") & " "
																	  set rs1 = nothing
																	  Set rs1 = cn.Execute(sql)
																	  %>
																	<td style="color:#3B5998"><%=Ucase(rs1("Descripcion"))
																	%></td>
																	<td style="color:#3B5998"><%=Ucase(vRut)%></td>
																	<td style="color:#3B5998"><%=Ucase(vNombre)%></td>
																	<td style="color:#3B5998"><%=Ucase(vMail)%></td>
																	<td style="color:#3B5998"><%=Ucase(vTelefono)%></td>
																</tr>
															<%
																rs.movenext

																loop
															end if
															end if
															%>

															</tbody>
														</table>
														<div class="checkbox">
															<label><input type="checkbox" name="acuerdo" id="acuerdo" value="falses"><a data-toggle="modal" data-target="#myModal10" style = "cursor: pointer;">Políticas de privacidad</a></label>
														</div>
														<!--<button type="button" class="button btn-entrar" style="background:#F7931E" onClick="javascript:irA(document.forms.formCotizacion,'cotizacion.asp?est=5&rut=<%=vRut%>&tipo=<%=vIdTipoCotiza%>');">ENVIAR A COTIZAR</button>-->
														<button type="button" class="button btn-entrar" style="background:#F7931E" onClick="javascript:validarRegistro(document.forms.formCotizacion,'cotizacion.asp?est=5&rut=<%=vRut%>&tipo=<%=vIdTipoCotiza%>');">ENVIAR A COTIZAR</button>
														<button type="button" class="button btn-entrar" style="background:#F7931E" onClick="javascript:irA(document.forms.formCotizacion,'index.asp?rutCotiza=<%=vRut%>');">AGREGAR</button>
													</div>
												</div>
											</div>
											  <!-- End  Basic Table  -->
										</div>
										</div>
							</li>
						</ul>
						
						
					</nav>
					<div class="modal fade" id="myModal9" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">

							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel" style="color:#FFFFFF">Cotizar</h4>
								</div>
								<div class="modal-body ">
									<div class="form-group">
										<label>RUT</label>
										<input class="form-control text-box-modal" placeholder="11111111-1" type="text" style="color:#F7931E" id ="textfield" name="textfield" value="<%=vRut2%>"/>
										<div data-role="popup" class="popUp-validacion" id="popUpRut"></div>
									</div>
									<div class="form-group">
										<label>RAZÓN SOCIAL / NOMBRE</label>
										<input class="form-control text-box-modal" placeholder="Nombre Empresa" type="text" style="color:#F7931E" id="textfield2" name="textfield2" value="<%=vRazonSocial%>"/>
										<div data-role="popup" class="popUp-validacion" id="popUpRS"></div>
									</div>
									<div class="form-group">
										<label>CORREO</label>
										<input class="form-control text-box-modal" placeholder="mail@mail.cl" type="text" style="color:#F7931E" id="textfield3" name="textfield3" value="<%=vMail%>"/>
										<div data-role="popup" class="popUp-validacion" id="popUpCorreo"></div>
									</div>
									<div class="form-group">
										<label>NOMBRE CONTACTO</label>
										<input class="form-control text-box-modal" placeholder="Nombre Contacto" type="text" style="color:#F7931E" id="textfield4" name="textfield4" value="<%=vNombre%>"/>
										<div data-role="popup" class="popUp-validacion" id="popUpContacto"></div>
									</div>
									<div class="form-group">
										<label>TELÉFONO CONTACTO</label>
										<input class="form-control text-box-modal" placeholder="Teléfono Contacto" type="text" style="color:#F7931E" id="textfield5" name="textfield5" value="<%=vTelefono%>"/>
										<div data-role="popup" class="popUp-validacion" id="popUpTContacto"></div>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-modal" style="background:#F7931E" onClick="javascript:validarCotizacion(document.forms.formCotizacion,'index.asp?est=1');">Cotizar</button>


								</div>
						</div>

						</div>
					</div>
				</form>
					</ul>
				</section>

			<!-- Main -->
				<section id="main" class="container">

					<section class="box special features">
						<div class="13u 10u(narrower)">
							<section>
<!-- Inicio Carrusel principal -->
							<div >
                    <div id="carousel-example" class="carousel slide slide-bdr" data-ride="carousel" >

                    <div class="carousel-inner"> 
                       <%
						sql="exec MantenedorPublicidad "
						sql=sql & " 4 , -1 , '' , 0 , 0, '', 1231, '',''"
						set rs4 = nothing
						Set rs4 = cn.Execute(sql)

						vIdPublicidad = rs4("Id_Publicidad")
						vUrl		  = rs4("url")
						
						%>
					   <div class="item active">
							<a href="<%=vUrl%>" target="_blank"><img src="<%=rs4("ruta")%>" alt="" /></a>
                       </div>
						<%
						sql="exec MantenedorPublicidad "
						sql=sql & " 5 , "
						sql=sql & " " & vIdPublicidad &" , "
						sql=sql & " '' , "
						sql=sql & " 0 , "
						sql=sql & " 0 , "
						sql=sql & " '', 1231, '','' "
						
						set rs5 = nothing
						Set rs5 = cn.Execute(sql)
						vUrl		  = rs5("url")
						if not rs5.eof then
							Do while not rs5.eof
						%>
                        <div class="item">
                            <a href="<%=vUrl%>" target="_blank"><img src="<%=rs5("ruta")%>" alt="" /></a>

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
              </div>

							</section>
						</div>
<!-- Fin Carrusel principal -->

<!-- Inicio Carrusel cuadro 1 -->
						<div class="features-row" >
							<section id="destacada" class="box3 special features col-md-12">
							<table>
							
<tr>
<td>
							<div id="carousel-example" class="carousel slide slide-bdr" data-ride="carousel" st style="width:262; height:175;">
								<div class="carousel-inner">
								<%
								sql="exec MantenedorPublicidad "
								sql=sql & " 4 , -1 , '' , 0 , 0, '', 1232, '',''"
								set rs4 = nothing
								Set rs4 = cn.Execute(sql)

								vIdPublicidad = rs4("Id_Publicidad")
								if rs4("url")= " " then
									vUrl = "http://www.mundomaquinaria.cl"
								else
									vUrl = rs4("url")
								end if
								%>
								<div class="item active">
									<a href="<%=vUrl%>" target="_blank"><img src="<%=rs4("ruta")%>" alt="" width="262" height="175" /></a>
								</div>
								<%
								sql="exec MantenedorPublicidad "
								sql=sql & " 5 , "
								sql=sql & " " & vIdPublicidad &" , "
								sql=sql & " '' , "
								sql=sql & " 0 , "
								sql=sql & " 0 , "
								sql=sql & " '', 1232, '',''"
								set rs5 = nothing
								Set rs5 = cn.Execute(sql)
								if not rs5.eof then
									Do while not rs5.eof
									vUrl		  = rs5("url")
								%>
								<div class="item">
									<a href="<%=vUrl%>" target="_blank"><img src="<%=rs5("ruta")%>" alt="" width="262" height="175" style="align:justify" /></a>
								</div>
								<%
									rs5.movenext
									loop
								else
								%>
								
								<%
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
								<!--<a class="left carousel-control" href="#carousel-example" data-slide="prev">
									<span class="glyphicon glyphicon-chevron-left"></span>
								</a>
								<a class="right carousel-control" href="#carousel-example" data-slide="next">
									<span class="glyphicon glyphicon-chevron-right"></span>
								</a>-->
							</div>
						<!-- Fin Carrusel cuadro 1 -->
	</td>
	<td>
						<!-- Inicio Carrusel cuadro 2 -->
							<div id="carousel-example" class="carousel slide slide-bdr" data-ride="carousel" style="width:262; height:175;">
								<div class="carousel-inner">
								<%
								sql="exec MantenedorPublicidad "
								sql=sql & " 4 , -1 , '' , 0 , 0, '', 1233, '',''"
								set rs4 = nothing
								Set rs4 = cn.Execute(sql)

								vIdPublicidad = rs4("Id_Publicidad")
								if rs4("url")= " " then
									vUrl = "http://www.mundomaquinaria.cl"
								else
									vUrl = rs4("url")
								end if
								%>
								<div class="item active">
									<a href="<%=vUrl%>" target="_blank"><img src="<%=rs4("ruta")%>" alt="" width="262" height="175" style="align:justify" /></a>
								</div>
								<%
								sql="exec MantenedorPublicidad "
								sql=sql & " 5 , "
								sql=sql & " " & vIdPublicidad &" , "
								sql=sql & " '' , "
								sql=sql & " 0 , "
								sql=sql & " 0 , "
								sql=sql & " '', 1233, '',''"
								set rs5 = nothing
								Set rs5 = cn.Execute(sql)
								
								if not rs5.eof then
									Do while not rs5.eof
									vUrl		  = rs5("url")
								%>
								<div class="item">
									<a href="<%=vUrl%>" target="_blank"><img src="<%=rs5("ruta")%>" alt="" width="262" height="175" style="align:justify" /></a>
								</div>
								<%
									rs5.movenext
									loop
								else
								%>
								
								<%
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
								<!--<a class="left carousel-control" href="#carousel-example" data-slide="prev">
									<span class="glyphicon glyphicon-chevron-left"></span>
								</a>
								<a class="right carousel-control" href="#carousel-example" data-slide="next">
									<span class="glyphicon glyphicon-chevron-right"></span>
								</a>-->
							</div>
							<!-- Fin Carrusel cuadro 2 -->
			</td>
			<td >
							<!-- Inicio Carrusel cuadro 3 -->
							<div id="carousel-example" class="carousel slide slide-bdr" data-ride="carousel" style="width:262; height:175;">
								<div class="carousel-inner">
								<%
								sql="exec MantenedorPublicidad "
								sql=sql & " 4 , -1 , '' , 0 , 0, '', 1235, '',''"
								set rs4 = nothing
								Set rs4 = cn.Execute(sql)

								vIdPublicidad = rs4("Id_Publicidad")
								if rs4("url")= " " then
									vUrl = "http://www.mundomaquinaria.cl"
								else
									vUrl = rs4("url")
								end if
								%>
								<div class="item active">
									<a href="<%=vUrl%>" target="_blank"><img src="<%=rs4("ruta")%>" alt="" width="262" height="175" /></a>
								</div>
								<%
								sql="exec MantenedorPublicidad "
								sql=sql & " 5 , "
								sql=sql & " " & vIdPublicidad &" , "
								sql=sql & " '' , "
								sql=sql & " 0 , "
								sql=sql & " 0 , "
								sql=sql & " '', 1235, '',''"
								set rs5 = nothing
								Set rs5 = cn.Execute(sql)
								
								if not rs5.eof then
									Do while not rs5.eof
									vUrl		  = rs5("url")
								%>
								<div class="item">
									<a href="<%=vUrl%>" target="_blank"><img src="<%=rs5("ruta")%>" alt="" width="262" height="175" style="align:justify" /></a>
								</div>
								<%
									rs5.movenext
									loop
								else
								%>
								
								<%
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
								<!--<a class="left carousel-control" href="#carousel-example" data-slide="prev">
									<span class="glyphicon glyphicon-chevron-left"></span>
								</a>
								<a class="right carousel-control" href="#carousel-example" data-slide="next">
									<span class="glyphicon glyphicon-chevron-right"></span>
								</a>-->
							</div>
							<!-- Fin Carrusel cuadro 3 -->
				</td>
			</tr>

		</table>
						</section>
						</div>
					</section>				
				</section>
				<section id="resultados_busqueda"  class="container" style="display:none;">
					<section class="box special features">
						<div class="13u 10u(narrower)">
							<section>
								hola busquedas

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
				<input class="form-control text-box-modal" type="text" style="color:#F7931E" name="nom_cont" id="nom_cont2"/>
			</div>
			<div class="form-group">
				<label>MAIL</label>
				<input class="form-control text-box-modal" type="text" style="color:#F7931E" name="mail_cont" id="mail_cont2"/>
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
			<h4 class="modal-title" id="myModalLabel">POLÍTICAS DE PRIVACIDAD</h4>
		</div>
		<div class="panel-body">
			<div class="table-responsive">
				<h5>
				<p><b>General</b><br>
				<div align="justify" class="text-box-modal">Al acceder al sitio www.mundomaquinaria.cl el usuario está aceptando y reconoce que ha revisado y está de acuerdo con esta Política de Privacidad.</div>
				<br><div align="justify" class="text-box-modal">Mundo Maquinaria SpA se reserva el derecho a modificar la presente política de privacidad y será responsabilidad del usuario la lectura y acatamiento de esta cada vez que ingrese al sitio.</div>
				<hr>
				<p><b>Acceso a la Información</b><br>
				<div align="justify" class="text-box-modal">El acceso a la información del sitio www.mundomaquinaria.cl tiene carácter gratuito, sin embargo hay información que está limitada para usuarios que previamente se hubieren registrado como tales y aceptado los Términos y Condiciones Generales del sitio.</div>
				<br><div align="justify" class="text-box-modal">Para acceder a ellos los usuarios registrados podrán acceder con su correo electrónico y clave que les correspondan.</div>
				<hr>
				<p><b>Información de los usuarios</b><br>
				<div align="justify" class="text-box-modal">Mundo Maquinaria SpA recopila datos de los usuarios registrados que hagan uso de este portal conforme a los Términos y Condiciones Generales del mismo. La entrega de esta información será voluntaria y se indicará claramente el fin para el cual está siendo solicitada, previa a la aceptación que debe realizar el usuario.</div><br>
				<br><div align="justify" class="text-box-modal">Al momento de que un ”visitante” (detallado en el punto 1.3 de Condiciones Generales y  definiciones previas de “Términos Legales”) realice una cotización, estará autorizando a Mundo Maquinaria SpA a utilizar su correo electrónico para enviarle información y/o novedades respecto al Sitio.</div>				
				<br><hr>
				<p><b>Información a terceros</b><br>
				<div align="justify" class="text-box-modal">Mundo Maquinaria SpA no comunicará ni transferirá a terceros los datos personales de sus usuarios sin el consentimiento expreso del titular. No obstante lo anterior, en caso de ser requerido judicialmente se hará entrega de la información solicitada.</div>
				<hr>
				<p><b>Uso de la información</b><br>
				<div align="justify" class="text-box-modal">Todos los derechos referidos a www.mundomaquinaria.cl y sus contenidos, incluidos los de propiedad intelectual, pertenecen a Mundo Maquinaria SpA.</div>
				<br><div align="justify" class="text-box-modal">Al acceder al sitio, el visitante tendrá derecho a revisar toda la información que esté disponible en él. Sin perjuicio de lo anterior, Mundo Maquinaria no se hace responsable por la veracidad o exactitud de la información que haya sido entregada por terceros.</div>
				<br></h5>
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
				<br><div align="justify" class="text-box-modal">Este contrato describe los términos y condiciones generales (en adelante los “TCG”) que se aplican al uso de los servicios (en adelante los “Servicios") ofrecidos por Mundo Maquinaria SpA (en adelante “Mundo Maquinaria”) a través de su sitio web www.mundomaquinaria.cl (en adelante el “Sitio”).</div><br>
				<br><div align="justify" class="text-box-modal">Cualquier persona que desee acceder y/o usar el Sitio o los Servicios podrá hacerlo sujetándose a éstos TCG junto con todas las demás políticas y principios que rigen el Sitio y que son incorporados a los presentes TCG por referencia. </div>
				<br><div align="justify" class="text-box-modal">TODA PERSONA QUE SE REGISTRE EN EL SITIO WWW.MUNDOMAQUINARIA.CL EN CALIDAD DE USUARIO DEBERÁ, EN FORMA PREVIA A SU UTILIZACIÓN, ACEPTAR ESTOS TÉRMINOS Y CONDICIONES GENERALES, LOS CUALES TENDRÁN SIEMPRE UN CARÁCTER OBLIGATORIO Y VINCULANTE.</div><br>
				<br><div align="justify" class="text-box-modal">El Usuario debe leer, entender y aceptar todas las condiciones establecidas en los presentes TCG así como en los demás documentos incorporados a los mismos por referencia, previo a su inscripción como Usuario de Mundo Maquinaria. </div>
				<br><div align="justify" class="text-box-modal">Mundo Maquinaria podrá realizar modificaciones a los TCG en cualquier momento, debiendo hacer públicos en el Sitio los términos modificados para ponerlos en conocimiento de los Usuarios y dando aviso de ello mediante correo electrónico al que estuviera registrado por parte del Usuario.</div><br>
				<br><div align="justify" class="text-box-modal">Los términos modificados entrarán en vigor en el plazo de 10 (diez) días desde su publicación en el Sitio. Transcurrido ese plazo, el silencio se considerará como aceptación del Usuario y el contrato continuará vinculando a ambas partes. </div>
                <br><div align="justify" class="text-box-modal">Si el Usuario no aceptare las modificaciones a los presentes TCG, deberá, en el mismo plazo indicado anteriormente, comunicarlo por escrito al correo electrónico contacto@mundomaquinaria.cl, cesando desde ese momento todos los efectos que emanan de estos TCG y quedando automáticamente inhabilitado como Usuario, siempre y cuando no tenga obligaciones o deudas  pendientes con Mundo Maquinaria, las que deberán solucionarse antes de dar por terminado el vínculo contractual entre las partes.</div><br><br>
                <br><div align="justify" class="text-box-modal">Los Servicios se prestarán a personas naturales o jurídicas que tengan capacidad legal para contratar. No podrán utilizar los servicios las personas que no tengan esa capacidad, los menores de edad o Usuarios de Mundo Maquinaria que hayan sido suspendidos temporalmente o inhabilitados definitivamente. </div><br>
                <br><div align="justify" class="text-box-modal">En el caso de personas jurídicas, debe tratarse de un representante legal con facultades necesarias y suficientes para contratar a nombre de tal entidad y de obligar a la misma en los términos de estos TCG. Por lo tanto, se considerará que cualquier persona jurídica que utilice los servicios de “Mundo Maquinaria” cumple con lo señalado anteriormente.</div><br>
				<hr>
                <p><b>1. CONDICIONES GENERALES Y DEFINICIONES PREVIAS.</b><br>
				<div align="justify" class="text-box-modal"> 1.1 El objetivo de los Servicios es proporcionar un sitio en internet para la búsqueda y oferta de maquinarias, así como servicios y productos afines. El Sitio incluye condiciones de uso y políticas de privacidad que fijan las medidas que Mundo Maquinaria puede tomar para que la información que le facilitan los Usuarios permanezca segura y sea utilizada únicamente para los fines a los que está destinada.</div><br>
				<br><div align="justify" class="text-box-modal"> 1.2 Mundo Maquinaria no es propietario de los bienes y servicios publicados u ofrecidos a través del Sitio, ni participa de modo alguno en el negocio de arriendo o venta de los mismos y no recibe comisión por las transacciones efectuadas entre los Usuarios. Asimismo, no comercializa los productos y servicios publicados. Su vinculación a estos productos, sus oferentes y las ofertas encontradas en el Sitio, se limita únicamente ser un medio de publicación en internet. La información publicada es de exclusiva responsabilidad de los Usuarios.</div><br><br>
				<br><div align="justify" class="text-box-modal"> 1.3 Niveles de interacción con el Sitio. Existen distintos niveles de vinculación con el Sitio, según las siguientes definiciones: </div>
				<div align="justify" class="text-box-modal">a. Visitante: Es todo aquel usuario que accede a una o más páginas de información publicada en el Sitio, no exigiéndose su identificación para dicho acceso.</div>
				<br><div align="justify" class="text-box-modal">b. Usuario: Es aquel Visitante registrado que hace uso del Sitio para ofrecer el arriendo, la venta de un producto determinado o la prestación de algún servicio.</div>
				<hr>
                <p><b> 2. INSCRIPCIÓN DEL USUARIO.</b><br>
				<div align="justify" class="text-box-modal">Para poder acceder a los Servicios es obligatorio que el Usuario se registre previamente en el Sitio completando el formulario de inscripción destinado a tal efecto, obligándose a proporcionar toda la información y datos requeridos en forma exacta, precisa y fidedigna  (en adelante los "Datos Personales"). El Usuario asume el compromiso de actualizar sus Datos Personales conforme resulte necesario. Mundo Maquinaria podrá utilizar diversos medios para identificar a sus Usuarios, pero NO se responsabiliza por la certeza ni veracidad de los Datos Personales que sus Usuarios le han entregado. Los Usuarios garantizan y responden, en cualquier caso, de la veracidad, exactitud, vigencia y autenticidad de los Datos Personales puestos a disposición de Mundo Maquinaria.</div><br><br><br><br>
				<br><div align="justify" class="text-box-modal">Mundo Maquinaria se reserva el derecho de solicitar algún comprobante y/o dato adicional a efectos de corroborar los Datos Personales, así como de suspender temporal o definitivamente a aquellos Usuarios cuyos datos no hayan podido ser confirmados. En estos casos de inhabilitación, se dará de baja todos los artículos publicados, así como las ofertas realizadas, sin que ello genere algún derecho a resarcimiento.</div><br><br>
				<br><div align="justify" class="text-box-modal">El Usuario accederá a su cuenta personal (en adelante la "Cuenta") mediante el ingreso de su correo electrónico a su elección, y de la clave de seguridad personal elegida (en adelante "Clave de Seguridad"). El Usuario se obliga a mantener la confidencialidad de su Clave de Seguridad. La Cuenta es personal, única e intransferible, y está prohibido que un mismo Usuario inscriba o posea más de una Cuenta. En caso que Mundo Maquinaria detecte distintas Cuentas que contengan datos coincidentes o relacionados, las podrá cancelar, suspender o inhabilitarlas.</div><br><br><br>
				<br><div align="justify" class="text-box-modal">El Usuario será el exclusivo responsable por todas las operaciones efectuadas en su Cuenta, pues el acceso a la misma está restringido al ingreso y uso de su Clave de Seguridad, de conocimiento exclusivo del Usuario. El Usuario se compromete a notificar a Mundo Maquinaria, en forma inmediata y por un medio idóneo y fehaciente, cualquier uso no autorizado de su Cuenta, así como el ingreso por terceros no autorizados a la misma. Está prohibido la venta, cesión o transferencia de la Cuenta (incluyendo la reputación y calificaciones) bajo ningún título. </div><br><br><br>
				<br><div align="justify" class="text-box-modal">Mundo Maquinaria se reserva el derecho de rechazar cualquier solicitud de inscripción o de cancelar una inscripción previamente aceptada, sin que esté obligado a comunicar o exponer las razones de su decisión y sin que ello genere algún derecho a indemnización o resarcimiento.</div><br>
				<hr>
                <p><b>3. TRATAMIENTO DE LOS DATOS PERSONALES.</b><br>
				<div align="justify" class="text-box-modal">En relación con el almacenamiento, custodia, conservación y tratamiento de los Datos Personales, conforme a lo indicado en la cláusula anterior, Mundo Maquinaria se obliga a dar pleno cumplimiento en todo momento a las disposiciones contenidas al respecto en la ley 19.628 sobre protección de la vida privada, como asimismo a cualquier otra norma de carácter legal o administrativo relacionada con ella, que la sustituya, reemplace o modifique total o parcialmente.</div><br><br>
				<br><div align="justify" class="text-box-modal">Conforme a lo anterior, al aceptar los presentes TCG, el Usuario autoriza a Mundo Maquinaria para que ésta pueda compartir los Datos Personales proporcionados a través del Sitio con los otros Usuarios, con la única y exclusiva finalidad de poner en contacto a eventuales vendedores y compradores de los productos que se publican  es en el Sitio, facilitando el encuentro de los mismos y el aprovechamiento de oportunidades comerciales entre ellos. Se deja expresa constancia que la presente autorización está limitada únicamente a estos fines comerciales inherentes a la actividad económica que Mundo Maquinaria desarrolla a través del Sitio.</div><br><br><br>
				<br><div align="justify" class="text-box-modal">Al momento de que un ”Usuario” (detallado en el punto 1.3 de Condiciones Generales y  definiciones previas de “Términos Legales”) se registre en el Sitio, estará autorizando a Mundo Maquinaria SpA a utilizar su correo electrónico para enviarle información y/o novedades respecto al Sitio.</div><br>
				<hr>
                <p><b>4. PUBLICACIÓN DE BIENES Y/O SERVICIOS.</b><br>
				<div align="justify" class="text-box-modal">4.1 Publicación de bienes y/o servicios.</b> El Usuario podrá ofrecer la venta y/o el arriendo de bienes y/o servicios en las categorías y sub-categorías apropiadas. Las publicaciones podrán incluir textos descriptivos, gráficos, fotografías y otros contenidos y condiciones pertinentes para la venta del bien o la contratación del servicio, siempre que no violen ninguna disposición de este acuerdo o demás políticas de Mundo Maquinaria. El producto ofrecido por el Usuario debe ser exacta y fidedignamente descrito en cuanto a sus condiciones y características relevantes. Se entiende y presume que mediante la inclusión del bien o servicio en el Sitio, el Usuario expresa su intención de vender y/o arrendar el bien por él ofrecido, o está facultado para ello por su titular y lo tiene disponible para su entrega inmediata. Se establece que los precios de los productos publicados deberán ser expresados netos de IVA, cuando corresponda la aplicación del mismo, y en moneda del curso legal. Mundo Maquinaria podrá remover cualquier publicación cuyo precio no sea expresado de esta forma para evitar confusiones o malos entendidos en cuanto al precio final del producto. En caso que se infrinja cualquiera de las disposiciones establecidas en esta cláusula, Mundo Maquinaria podrá editar el espacio, solicitar al Usuario que lo edite, o dar de baja la publicación donde se encuentre la infracción y en ningún caso se devolverán o bonificarán los cargos de publicación.</div><br><br><br><br><br><br><br><br><br>
				<br><div align="justify" class="text-box-modal">4.2 Inclusión de imágenes y fotografías.</b> En la medida que el tipo de aviso seleccionado lo permita, el Usuario puede incluir imágenes y fotografías del producto ofrecido siempre que las mismas se correspondan con el artículo, salvo que se trate de bienes, productos o servicios que por su naturaleza no permiten esa correspondencia. Mundo Maquinaria podrá impedir la publicación de la fotografía, e incluso del producto, si interpretara, a su exclusivo criterio, que la imagen no cumple con los presentes TCG.</div><br><br>
				<br><div align="justify" class="text-box-modal">4.3 Artículos Prohibidos.</b> Sólo podrán ser ingresados en las listas de bienes y/o servicios ofrecidos, aquellos que correspondan a la categoría y sub-categoría seleccionada. Los bienes, productos o servicios no incluidos en alguna de ellas se encuentran prohibidos de publicar. Mundo Maquinaria podrá cancelar una publicación si estima que esta: (i) no cumple con el espíritu del Sitio; (ii) está en contra de la moral y sanas costumbres; o (iii) es ilegal o no ajustada a derecho; sin que en cualquiera de estos casos exista derecho del Usuario a ser resarcido o indemnizado por esta cancelación.</div><br><br><br>
				<br><div align="justify" class="text-box-modal">4.4 Prohibición de Duplicación de Avisos:</b> Para poder dar una mejor experiencia a los potenciales compradores y al público en general que visite el Sitio, Mundo Maquinaria no aceptará avisos duplicados, es decir, un bien o servicio solo se puede publicar una sola vez. Esto es válido para los avisos que el Usuario disponga por cualquiera de los medios disponibles. En caso de detectarse duplicación de avisos, Mundo Maquinaria se reserva el derecho de cancelar el aviso sin derecho a compensación alguna a quien lo publicó.</div><br><br>
				<hr>
                <p><b>5. OBLIGACIONES DE LOS USUARIOS.</b><br>
				<div align="justify" class="text-box-modal">El Usuario debe tener capacidad legal para vender y/o arrendar el bien objeto de su oferta. Dado que Mundo Maquinaria es un punto de encuentro entre compradores y vendedores y no participa de las operaciones que se realizan entre ellos, el Usuario será responsable por todas las obligaciones y cargas impositivas que correspondan por la venta de sus artículos, sin que pudiera imputársele a Mundo Maquinaria algún tipo de responsabilidad por incumplimientos en tal sentido.</div><br><br>
				<br><div align="justify" class="text-box-modal">Mundo Maquinaria sólo pone a disposición de los Usuarios y público en general un espacio virtual que les permite comunicarse mediante Internet para encontrar una forma de vender,  comprar o arrendar bienes y servicios. Mundo Maquinaria no tiene participación ni injerencia alguna en el proceso de negociación y perfeccionamiento del contrato definitivo entre las partes. Por eso, Mundo Maquinaria no es responsable por el efectivo cumplimiento de las obligaciones fiscales o impositivas establecidas por la legislación vigente. Mundo Maquinaria tampoco es responsable de la información proporcionada por los Usuarios, no otorga garantías de ningún tipo, ni presta servicios de traslado o algún otro referente al proceso de compra y entrega.</div><br><br><br><br>
				<hr>
                <p><b>6. PRIVACIDAD DE LA INFORMACIÓN.</b><br>
				<div align="justify" class="text-box-modal">Para utilizar los Servicios los Usuarios deberán facilitar determinados Datos Personales. Esta información se procesa y almacena en servidores o medios magnéticos que mantienen altos estándares de seguridad y protección tanto física como tecnológica. Para mayor información sobre la privacidad de los Datos Personales y casos en los que será revelada la información personal, se puede consultar nuestra Política de Privacidad, la que forma parte integrante de los presentes TCG y del sitio www.mundomaquinaria.cl.</div><br><br>
				<hr>
                <p><b>7. PROHIBICIONES A LOS USUARIOS.</b><br>
				<div align="justify" class="text-box-modal">Los Usuarios no podrán publicar, vender y/o arrendar artículos prohibidos por los TCG, demás políticas de Mundo Maquinaria o leyes vigentes. También está prohibido insultar o agredir a otros Usuarios  través del Sitio.</div>
				<br><div align="justify" class="text-box-modal">Cualquier infracción o contravención a lo dispuesto en los presentes TCG será investigada por Mundo Maquinaria y el infractor podrá ser sancionado con la suspensión o cancelación de la Cuenta, la oferta realizada e incluso de su inscripción como Usuario y/o de cualquier otra forma que Mundo Maquinaria estime pertinente, sin perjuicio de las acciones legales que correspondan derivadas de una eventual responsabilidad civil y/o penal, como de aquellas destinadas a la indemnización de perjuicios civiles que hubiera podido causar a otros Usuarios o a Mundo Maquinaria.</div><br><br><br>
				<hr>
                <p><b>8. VIOLACIONES DEL SISTEMA O BASES DE DATOS.</b><br>
				<div align="justify" class="text-box-modal">No está permitida ninguna acción o uso de dispositivo, software, u otro medio tendiente a interferir tanto en las actividades y operatoria de Mundo Maquinaria como en las ofertas, descripciones, Cuentas o bases de datos de Mundo Maquinaria. Cualquier intromisión, tentativa o actividad violatoria o contraria a las leyes sobre derecho de propiedad intelectual y/o a las prohibiciones estipuladas en estos TCG harán responsable al infractor de las acciones legales pertinentes, así como de indemnizar los daños ocasionados.</div><br><br>
				<hr>
                <p><b>9. SANCIONES Y SUSPENSIÓN DE LAS OPERACIONES.</b><br>
				<div align="justify" class="text-box-modal">Sin perjuicio de otras medidas, Mundo Maquinaria podrá advertir, suspender en forma temporal o inhabilitar definitivamente la Cuenta de un Usuario o una publicación, iniciar las acciones que estime pertinentes y/o suspender la prestación de sus Servicios si (i) se quebrantara alguna ley, o cualquiera de las estipulaciones de los TCG y demás políticas de Mundo Maquinaria; (ii) si incumpliera sus compromisos como Usuario; (iii) si se incurriera a criterio de Mundo Maquinaria en conductas o actos dolosos o fraudulentos; (iv) no pudiera verificarse la identidad del Usuario o cualquier información proporcionada por el mismo fuere errónea; y (v) Mundo Maquinaria entendiera que las publicaciones u otras acciones pueden ser causa de responsabilidad para el Usuario que las publicó, para Mundo Maquinaria o para los Usuarios. En el caso de la suspensión o inhabilitación de un Usuario, todos los artículos que tuviera publicados serán removidos del sistema y en ningún caso se devolverán o bonificarán los cargos de publicación involucrados. También se removerán del sistema las ofertas de compra de bienes ofrecidos en subasta.</div><br><br><br><br><br><br><br>
				<hr>
                <p><b>10. RESPONSABILIDAD.</b><br>
				<div align="justify" class="text-box-modal">Mundo Maquinaria sólo pone a disposición de los Usuarios un espacio virtual que les permite ponerse en comunicación mediante Internet para encontrar una forma de vender o comprar servicios o bienes. Mundo Maquinaria no es el propietario de los artículos ofrecidos, no tiene posesión de ellos ni los ofrece en venta. Mundo Maquinaria no interviene en el perfeccionamiento de las operaciones realizadas entre los Usuarios ni en las condiciones por ellos estipuladas para las mismas, por ello no será responsable respecto de la existencia, calidad, cantidad, estado, integridad o legitimidad de los bienes ofrecidos, adquiridos o enajenados por los Usuarios, así como de la capacidad para contratar de los Usuarios o de la veracidad de los Datos Personales por ellos ingresados. Cada Usuario conoce y acepta ser el exclusivo responsable por los artículos que publica para su venta y/o arriendo y por las ofertas y/o compras que realiza.</div><br><br><br><br><br><br>
				<br><div align="justify" class="text-box-modal">Debido a que Mundo Maquinaria no tiene ninguna participación durante todo el tiempo en que el artículo se publica para la venta o arriendo, ni en la posterior negociación y perfeccionamiento del contrato definitivo entre las partes, no será responsable por el efectivo cumplimiento de las obligaciones asumidas por los Usuarios en el perfeccionamiento de la operación. El Usuario conoce y acepta que al realizar operaciones con otros Usuarios o terceros lo hace bajo su propio cuenta y riesgo. En ningún caso Mundo Maquinaria será responsable por lucro cesante, o por cualquier otro daño y/o perjuicio que haya podido sufrir el Usuario, debido a las operaciones realizadas o no realizadas por artículos publicados a través de Mundo Maquinaria.</div><br><br><br><br>
				<br><div align="justify" class="text-box-modal">Mundo Maquinaria NO será responsable por la realización de ofertas y/o operaciones con otros Usuarios basadas en la confianza depositada en el sistema o los Servicios brindados por Mundo Maquinaria.</div>
				<br><div align="justify" class="text-box-modal">En caso que uno o más Usuarios o algún tercero inicien cualquier tipo de reclamo o acciones legales contra otro u otros Usuarios, todos y cada uno de los Usuarios involucrados en dichos reclamos o acciones eximen de toda responsabilidad a Mundo Maquinaria y a todos sus socios, accionistas, directores, gerentes, ejecutivos, empleados, agentes, operarios, representantes y apoderados.</div><br><br>
				<hr>
                <p><b>11. ALCANCE DE LOS SERVICIOS DE MUNDO MAQUINARIA.</b><br>
				<div align="justify" class="text-box-modal">Este acuerdo no crea ningún contrato de sociedad, de mandato, de franquicia, o relación laboral entre Mundo Maquinaria y el Usuario. El Usuario reconoce y acepta que Mundo Maquinaria no es parte en ninguna operación, ni tiene control alguno sobre la calidad, seguridad o legalidad de los artículos anunciados, la veracidad o exactitud de los anuncios, la capacidad de los Usuarios para vender o comprar artículos. Mundo Maquinaria no puede asegurar que un Usuario completará una operación ni podrá verificar la identidad o Datos Personales ingresados por los Usuarios. Mundo Maquinaria no garantiza la veracidad de la publicidad de terceros que aparezca en el Sitio y no será responsable por la correspondencia o contratos que el Usuario celebre con dichos terceros o con otros Usuarios.</div><br><br><br><br>
				<hr>
                <p><b>12. FALLAS EN EL SISTEMA.</b><br>
				<div align="justify" class="text-box-modal">Mundo Maquinaria no se responsabiliza por cualquier daño, perjuicio o pérdida al Usuario causados por fallas en el sistema, en el servidor o en Internet. Mundo Maquinaria tampoco será responsable por cualquier virus que pudiera infectar el equipo del Usuario como consecuencia del acceso, uso o examen de su sitio web o a raíz de cualquier transferencia de datos, archivos, imágenes, textos, o audio contenidos en el mismo. Los Usuarios NO podrán imputarle responsabilidad alguna ni exigir pago por perjuicios directos o indirectos ni lucro cesante, en virtud de perjuicios resultantes de dificultades técnicas o fallas en los sistemas o en Internet. Mundo Maquinaria no garantiza el acceso y uso continuado o ininterrumpido de su sitio. El sistema puede eventualmente no estar disponible debido a dificultades técnicas o fallas de Internet, o por cualquier otra circunstancia ajena a Mundo Maquinaria; en tales casos se procurará restablecerlo con la mayor celeridad posible sin que por ello pueda imputársele algún tipo de responsabilidad. Mundo Maquinaria no será responsable por ningún error u omisión contenidos en su Sitio.</div><br><br><br><br><br><br><br>
				<hr>
                <p><b>13. TARIFAS COBROS POR EL SERVICIO.</b><br>
				<div align="justify" class="text-box-modal">La inscripción en Mundo Maquinaria es gratuita. Al publicar bienes o servicios para la venta o arriendo, el Usuario deberá pagar un cargo de publicación, cuyo costo es variable de acuerdo al plan que elija. El precio de dichos planes variará conforme a la cantidad de información que éstos permitan cargar o publicar en el Sitio.</div><br>
				<br><div align="justify" class="text-box-modal">Todo anuncio será activado una vez confirmado el pago por parte de Mundo Maquinaria. El anuncio podrá ser eliminado del Sitio si han transcurrido más de cuarenta y ocho (48) horas desde su ingreso al sistema y no se ha recibido la confirmación del pago.</div>
				<br><div align="justify" class="text-box-modal">Mundo Maquinaria se reserva el derecho de modificar, cambiar, agregar, o eliminar las tarifas vigentes, en cualquier momento, lo cual será notificado a los Usuarios. Sin embargo, Mundo Maquinaria podrá modificar temporalmente las tarifas, tanto en su forma como en su valor, por sus servicios en razón de promociones, haciéndose efectivas estas modificaciones cuando se haga pública la promoción o se realice el anuncio.</div><br><br>
				<hr>
                <p><b>14. PROMOCIONES Y AVISOS GRATIS.</b><br>
				<div align="justify" class="text-box-modal">Los avisos publicados en el Sitio deben ser pagados por el Usuario. La tarifa de éstos será variable según el plan seleccionado por el Usuario, sin perjuicio del derecho de Mundo Maquinaria a realizar una o más promociones con tarifas distintas por períodos de tiempo determinados.</div><br>
				<hr>
                <p><b>15. PROPIEDAD INTELECTUAL DEL CONTENIDO DEL SITIO.</b><br>
				<div align="justify" class="text-box-modal">Todos los contenidos de las pantallas relativas a los servicios de Mundo Maquinaria como así también los programas, bases de datos, redes, archivos que permiten al Usuario acceder y usar su Cuenta, son de propiedad de Mundo Maquinaria y están protegidas por las leyes y los tratados internacionales de derecho de autor, marcas, patentes, modelos y diseños industriales.</div><br>
				<br><div align="justify" class="text-box-modal">El uso indebido y la reproducción total o parcial de dichos contenidos quedan prohibidos.</div>
				<div align="justify" class="text-box-modal">El Sitio puede contener enlaces a otros sitios web lo cual no indica que sean propiedad u operados por Mundo Maquinaria. En virtud que Mundo Maquinaria no tiene control sobre tales sitios, NO será responsable por los contenidos, materiales, acciones y/o servicios prestados por los mismos, ni por daños o pérdidas ocasionadas por la utilización de los mismos, sean causadas directa o indirectamente. La presencia de enlaces a otros sitios web no implica una sociedad, relación, aprobación, respaldo de Mundo Maquinaria a dichos sitios y sus contenidos.</div><br><br><br>
				<hr>
                <p><b>16. INDEMNIDAD.</b><br>
				<div align="justify" class="text-box-modal">El Usuario se obliga a indemnizar todos los perjuicios y mantener indemne a Mundo Maquinaria, sus filiales, empresas controladas y/o controlantes, directivos, administradores, representantes y empleados, y en general a cualquier persona, natural o jurídica, relacionada con ella, por cualquier suma a que fuere condenada a pagar por causa de algún reclamo, demanda, querella u otra actuación ante cualquier entidad judicial que se interponga o deduzca en su contra que tuviere como causa o se relacione, directa o indirectamente, con un incumplimiento o inobservancia de los presentes TCG y demás políticas que se entienden incorporadas a ellos, o por la violación de cualesquiera leyes o derechos de terceros.</div><br><br><br><br>
				<hr>
                <p><b>17. PUBLICIDAD.</b><br>
				<div align="justify" class="text-box-modal">Mundo Maquinaria pone el Sitio a disposición tanto de Usuarios como de otros terceros, para que éstos publiquen fotografías, imágenes o logotipos con el objeto de promocionar y publicitar sus marcas o productos propios mediante el pago de una contraprestación en dinero.</div><br>
				<div align="justify" class="text-box-modal">Se deja expresa constancia que Mundo Maquinaria no tendrá injerencia alguna en la determinación de los contenidos ni las imágenes que se publiquen en virtud de lo anterior, y tendrá siempre el derecho a eliminar, en cualquier momento, todos aquellos contenidos que no cumplan con lo dispuesto en estos TCG, en los estándares acordados y demás políticas de Mundo Maquinaria, como también todo aquello que vaya en contra del orden público, la moral y/o las buenas costumbres.</div><br><br>
				<hr>
                <p><b>18. PAGOS</b><br>
				<div align="justify" class="text-box-modal">Los pagos que el Cliente deba hacer a Mundo Maquinaria SpA en razón a los planes que contrate, deberán efectuarse dentro del plazo de vencimientos que se indica en la respectiva factura que se emita mensualmente al efecto. Los pagos deberán realizarse obligatoriamente mediante cheque nominativo y cruzado a favor de Mundo Maquinaria Spa; directamente en las entidades bancarias descritas en la factura o cualquier otra institución que Mundo Maquinaria SpA informará oportunamente; o bajo la modalidad de cargo en cuenta corriente o tarjeta de crédito según el mandato y las alternativas que se presenten.</div><br><br><br>
				<br><div align="justify" class="text-box-modal">En caso de no pago íntegro y oportuno de cualquiera de las obligaciones asumidas por el Cliente en razón a los contratos de que da cuenta el presente instrumento, Mundo Maquinaria SpA podrá suspender el servicio de publicaciones, avisos u otros, que el Cliente haya contratado.</div><br>
				<hr>
                <p><b>19. GESTIÓN DE COBRANZA</b><br>
				<div align="justify" class="text-box-modal">De conformidad a lo previsto en la ley Nº19.628, sobre Protección de Datos Personales y en la ley Nº 19.496, sobre Protección de los Derechos de los Consumidores, el Cliente autoriza desde ya y expresamente a Mundo Maquinaria para informar y hacer publicar en registros o bancos de datos personales, la circunstancia de encontrarse impago de una o más de las obligaciones que ha asumido en razón a los servicios contratados mediante la suscripción del presente instrumento y que den cuenta la o las facturas respectivas.</div><br><br><br>

				</h5>
			</div>
		</div>

	</div>
	</form>
</div>
</div>
<!-- Modal Login -->
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<form name="formLogin" method="post" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">INICIO SESIÓN</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
					<label>RUT</label>
					<input class="form-control text-box-modal" placeholder="11111111-1" type="text" id="user_rut" name="user_rut" pattern="[0-9]|k"/>
					<div data-role="popup" class="popUp-validacion" id="popUpUserRut"></div>
				</div>
				<div class="form-group">
					<label>CONTRASEÑA</label>
					<input class="form-control text-box-modal" type="password" name="passw" id="txtPassw"/>
				</div>
				</div>
				<div class="modal-footer">
					<!-- Olvidaste tu contraseña -->
					<a data-toggle="modal" data-target="#myModal10" style="cursor:pointer;color:#F7931E;">OLVIDASTE TU CONTRASEÑA </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-modal" onClick="javascript:validacion(document.forms.formLogin,'login2.asp?opc=in');">INGRESAR</button>
				</div>
			</div>
		</div>
	</form>
	<div class="modal fade" id="myModal10" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<script type="text/javascript">
			function fCarga(formulario, pagina)
			{
				if(formulario.textcorreo.value=="" )
				{
					mostrarMensaje('Para Continuar debe Completar los datos','error');
					return false;
				}
				irA(formulario, pagina);
			}
		</script>
		<form name="formLogin2" method="post" >
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">RECUPERACIÓN DE USUARIO O CONTRASEÑA</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
						<label>INGRESE MAIL REGISTRADO</label>
						<input class="form-control text-box-modal" type="text" name="textcorreo" pattern="[0-9]|k"/>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-modal" onClick="JavaScript:fCarga(document.forms.formLogin2,'Envio_datos.asp');">Enviar</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<!-- Modal Login Fin -->
<!-- Modal Registro -->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<form name="formReg1" method="post" >
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">REGISTRO</h4>
				</div>
				<div class="modal-body ">
					<div class="form-group">
						<label>RAZÓN SOCIAL / NOMBRE</label>
						<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="Nom_Reg" name="Nom_Reg" value="<%=vNombre%>"/>
					</div>
					<div class="form-group">
						<label>RUT</label>
						<input class="form-control text-box-modal" placeholder="11111111-1" type="text" style="color:#F7931E" id ="Rut_Reg" name="Rut_Reg" value="<%=vRut%>"/>
						<div data-role="popup" class="popUp-validacion" id="popUpRegRut"></div>
					</div>
					<div class="form-group">
						<label>CORREO</label>
						<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="Mail_Reg" name="Mail_Reg" value="<%=vMail%>"/>
					</div>
					<div class="form-group">
						<label>CONTRASEÑA</label>
						<input class="form-control text-box-modal" placeholder="Min 8 digitos. Entre nùmeros y letras" type="password" style="color:#F7931E" id ="password" name="password" value="<%=vPassword%>"/>
						<div data-role="popup" class="popUp-validacion" id="popUpRegPass"></div>
					</div>
					<div class="form-group">
						<label>REINGRESAR CONTRASEÑA</label>
						<input class="form-control text-box-modal" type="password" placeholder="********" style="color:#F7931E" id ="password2" name="password2" value="<%=vPassword%>"/>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-modal" style="background:#F7931E" onClick="javascript:validaDatos(document.forms.formReg1,'index.asp?est=new');">ENVIAR</button>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- Modal Registro Fin -->
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
						<!--<section><img src="images/qr_img.png" style="float:right;">&nbsp;&nbsp;&nbsp;&nbsp;</section>-->
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
			<script type="text/javascript" src="assets/js/jquery.rut.js"></script>
			<script type="text/javascript" src="assets/js/jquery.rut.min.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		var mensaje = $.getURLParam("msg");
		if (mensaje == 1) {
			mostrarMensaje('Estimado Usuario, cotización agregada exitosamente', 'success');
		} else if (mensaje == 2) {
			mostrarMensaje('Estimado Usuario, cotización eliminada exitosamente', 'success')
		} else if (mensaje == 3) {
			mostrarMensaje('Mensaje enviado exitosamente', 'success');
		} else if (mensaje == 4) {
			mostrarMensaje('Sus cotizaciones fueron enviadas a nuestros distintos proveedores. Favor espere a que el/ellos lo contacten', 'info');
		} else if (mensaje == 5) {
			mostrarMensaje('Estimado Usuario, el RUT ingresado ya es parte de nuestros registros', 'error');
		} else if (mensaje == 6) {
			mostrarMensaje('Estimado Usuario, error al iniciar sesión. Intente nuevamente.', 'error');
		} else if (mensaje == 7) {
			mostrarMensaje('Se envió un correo con sus datos al mail registrado.', 'info');
		} else if (mensaje == 8) {
			var texto = $.getURLParam("txt");
			mostrarMensaje(texto, 'error');
		} else if (mensaje == 9) {
			mostrarMensaje('Cotización agregada exitosamente', 'success');
		} else if (mensaje == 10) {
			mostrarMensaje('Mensaje enviado exitosamente', 'success');
		} else if (mensaje == 11) {
			mostrarMensaje('Cotización eliminada exitosamente','success');
		} else if (mensaje == 12) {
			mostrarMensaje('Sus cotizaciones fueron enviadas a nuestros distintos proveedores. Favor espere a que el/ellos lo contacten', 'info');
		} else if (mensaje == 13) {
			mostrarMensaje('Bienvenido a Mundo Maquinaria. Su pago se realizó con éxito, se envió un email con sus datos de ingreso registrado', 'info');
		} else if (mensaje == 14) {
			mostrarMensaje('Estimado Usuario, su RUT es incorrecto.', 'error');
		} else if (mensaje == 15) {
			mostrarMensaje('Estimado Usuario, su contraseña es incorrecta.', 'error');
		} else if (mensaje == 16) {
			mostrarMensaje('Estimado Usuario, se envio un correo con sus datos al mail registrado.', 'success');
		} else if (mensaje == 17) {
			mostrarMensaje('Estimado Usuario, el MAIL ingresado ya es parte de nuestros registros', 'error');
		}

		$('#textfield').blur(function(){
			var rut = $('#textfield').val();
			var rutFormateado = $.formatRut(rut);
			$('#textfield').val(rutFormateado);

			if (rut != '')
			{
				if (checkRut(rut, 'popUpRut')) { cargaAplicacion(); }
			}
			else if (rut == '')
			{
				mensajePopUp('Rut es obligatorio', 'popUpRut');
			}
			else if (rut != '')
			{
				checkRut(rut, 'popUpRut');
			}
		});

		$('#user_rut').blur(function(){
			var rut = $('#user_rut').val();
			var rutFormateado = $.formatRut(rut);
			$('#user_rut').val(rutFormateado);

			if (rut != '')
			{
				checkRut(rut, 'popUpUserRut');
			}
			else if (rut == '')
			{
				mensajePopUp('Rut es obligatorio', 'popUpUserRut');
			}
		});

		$('#Rut_Reg').blur(function() {
			var rut = $('#Rut_Reg').val();
			var rutFormateado = $.formatRut(rut);
			$('#Rut_Reg').val(rutFormateado);

			if (rut != '')
			{
				checkRut(rut, 'popUpRegRut');
			}
			else if (rut == '')
			{
				mensajePopUp('Rut es obligatorio', 'popUpRegRut');
			}
		});

		$('#textfield2').blur(function(){
			CampoObligatorio('textfield2', 'Razón Social/Nombre','popUpRS');
		});

		$('#textfield3').blur(function(){
			var textoCorreo = $('#textfield3').val()
			var resultado = CampoObligatorio('textfield3', 'Correo','popUpCorreo');
			if (resultado == false) {
				var expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			if ( !expr.test(textoCorreo) ){
					mensajePopUp('La dirección de correo "' + textoCorreo + '" es incorrecta','popUpCorreo');
				}
			}
		});

		$('#textfield4').blur(function(){
			CampoObligatorio('textfield4', 'Nombre Contacto','popUpContacto');
		});

		$('#textfield5').blur(function(){
			var resultado = CampoObligatorio('textfield5', 'Teléfono Contacto','popUpTContacto');
			if (!resultado) { //resultado == false, campo contiene datos.
				var telefono = $('#textfield5').val();
				if (telefono.length != 9) {
					mensajePopUp('Estimado Usuario, El Teléfono debe contener 9 dígitos','popUpTContacto');
				} else if (!/^([0-9])*$/.test(telefono)) {
					mensajePopUp('Estimado Usuario, El valor no es un número', 'popUpTContacto');
				}
			}
		});
	});

	function TipoVentaChange(e) {
		//console.log("hola mundo")
		// console.log("e: " + e);
		// console.log("e.val(): " + e.value);

		var btnCotizar = document.getElementById("bt_cotizar2");
		var idBtnCotizar = "";
		if (btnCotizar == null) { //Obtener Id según el filtro que se encuentra visible.
			idBtnCotizar = "bt_cotizar";
		} else {
			idBtnCotizar = "bt_cotizar2";
		}
		//console.log("idBtnCotizar: " + idBtnCotizar);

		if(e.value=="18"){ //($(this).val()=="18"){
			CambiarTextoBtnCotizar(idBtnCotizar, "BUSCAR", false);

			//$("#familia").val("0");
			//$("#familia").attr("disabled","disabled")
			//$("#subcatagory").attr("disabled","disabled")
			//$("#subcatagory").html("");
			//$("#subcatagory").append($("<option>").text("CIUDAD"));
		}else{
			$("#familia").removeAttr("disabled")
			$("#subcatagory").removeAttr("disabled")
			// $("#bt_cotizar").text("COTIZAR");
			// $("#bt_cotizar").attr("data-toggle","modal");
			CambiarTextoBtnCotizar(idBtnCotizar, "COTIZAR", true);
		}
	}

	function CambiarTextoBtnCotizar(id, texto, dataToggle) {
		//console.log("CambiarTextoBtnCotizar")
		$("#" + id).text(texto);
		if (dataToggle) {
			$("#" + id).attr("data-toggle","modal");
		} else {
			$("#" + id).removeAttr("data-toggle");
		}
	}
	
	function BtnCotizarClick() {
		var cmbTipoVenta = document.getElementById("tipoVenta2");
		var cmbTipoVentaVal = "";
		if (cmbTipoVenta == null) {
			cmbTipoVentaVal = $("#tipo").val();
		} else {
			cmbTipoVentaVal = cmbTipoVenta.value;
		}

		//console.log("cmbTipoVentaVal: " + cmbTipoVentaVal);
		
		if (cmbTipoVentaVal == "18") { //($("#tipo").val()=="18"){
			location.href="resultado_busqueda.asp?opc=sch&eq=" + $("#equipo").val();	
		}
	}

	function CampoObligatorio(id, descripcion, popUp) {
		if ($('#'+id).val() == '')
		{
			mensajePopUp(descripcion + ' es obligatorio', popUp);
			return true;
		}
		else
		{
			$('#' + popUp).animate({fontSize: '0px'}, "fast");
			$('#' + popUp).animate({height: '0px'}, "fast");
			return false;
		}
	}

	function ValorEquipo() {
		var equipo = document.getElementById("equipo");
		var equipo2 = document.getElementById("equipo2");

		if (equipo2 != null) {
			equipo.selectedIndex = equipo2.selectedIndex;
		}
		console.log('Equipo selectedIndex: ' + equipo.selectedIndex);
	}

	function ValorRegion() {
		var region = document.getElementById("familia");
		var region2 = document.getElementById("familia2");

		if (region2 != null) {
			region.selectedIndex = region2.selectedIndex;
		}
		console.log('Region selectedIndex: ' + region.selectedIndex);
		CopiarComboCiudad();
	}

	function CopiarComboCiudad() {
		var ciudad = document.getElementById("subcatagory");
		var ciudad2 = document.getElementById("subcatagory2");
		
		if (ciudad2 != null) {
			var html1 = ciudad.innerHTML;
			html1 = html1.replace('subcategory', 'subcategory2');
			ciudad2.innerHTML =  html1;
		}
		console.log('CopiarComboCiudad()');
	}
	
	function ValorCiudad() {
		var ciudad = document.getElementById("subcatagory");
		var ciudad2 = document.getElementById("subcatagory2");

		if (ciudad2 != null) {
			ciudad.selectedIndex = ciudad2.selectedIndex;
		}
		console.log('Ciudad selectedIndex: ' + ciudad.selectedIndex);
	}

	function validarRegistro(formulario, pagina){		
			
			if(!document.getElementById('acuerdo').checked	){
				mostrarMensaje('Estimado Usuario, debe aprobar las politicas de privacidad', 'error');
				document.form1_crit.acuerdo.focus()
				return false;
			}
			
			irA(formulario, pagina);	
		}
</script>
	<script>
	//Agregado Funciones para lo nuevo  16.10.2017
	$(function(){

		//console.log("hola mundo")
		// $(".tipo-venta").on("change",function(e){ //$("#tipo").on("change",function(e){
			
		// 	console.log("hola mundo")
		// 	var btnCotizar = document.getElementById("bt_cotizar2");
		// 	var idBtnCotizar = "";
		// 	if (btnCotizar == null) { //
		// 		idBtnCotizar = "bt_cotizar";
		// 	} else {
		// 		idBtnCotizar = "bt_cotizar2";
		// 	}
		// 	console.log("idBtnCotizar: " + idBtnCotizar);

		// 	if($(this).val()=="18"){
		// 		// $("#bt_cotizar").text("BUSCAR");
		// 		// $("#bt_cotizar").removeAttr("data-toggle");
		// 		CambiarTextoBtnCotizar(idBtnCotizar, "BUSCAR", false);

		// 		$("#familia").val("0");
		// 		$("#familia").attr("disabled","disabled")
		// 		$("#subcatagory").attr("disabled","disabled")
		// 		$("#subcatagory").html("");
		// 		$("#subcatagory").append($("<option>").text("CIUDAD"));
		// 	}else{
		// 		$("#familia").removeAttr("disabled")
		// 		$("#subcatagory").removeAttr("disabled")
		// 		// $("#bt_cotizar").text("COTIZAR");
		// 		// $("#bt_cotizar").attr("data-toggle","modal");
		// 		CambiarTextoBtnCotizar(idBtnCotizar, "COTIZAR", true);
		// 	}
		// });

		// $("#bt_cotizar").on("click",function(e){
		// 	if($("#tipo").val()=="18"){
		// 	    location.href="resultado_busqueda.asp?eq=" + $("#equipo").val();	
		// 	}
		// })
	})
</script>
	
	</body>
</html>
