<!--#include file="con_app.asp"-->
<!DOCTYPE HTML>
<!--
	Alpha by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
	<!--Mail vencimiento del plan-->
	<%
	
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
			Cuerpo = "<br><br><h3 style=color:#3B5998Estimado(a) Cliente " & vNombreUsuario & ", <br>&nbsp;&nbsp;&nbsp;&nbsp;Su plan esta pr�ximo a vencer favor regularizar.<br> "
			Cuerpo = Cuerpo & "Los datos de su plan contratado son:</h3> <br><br><h4 style=color:#F7931E>  Tipo Plan: " & vTipoPlan & "<br>Nombre: " & vDescPlan & "<br> Valor total: " & vTotal & "<br> Fecha inicio: " & vFecInicio & "<br> Fecha T�rmino: " & vFecTermino & "</a>"
			Cuerpo = Cuerpo & "<br>D�as duraci�n: " & vDiasDur & "<br> Tipo de pago: " & vTipoPago
			Cuerpo = Cuerpo & "</h4><br><br>"
			Cuerpo = Cuerpo & "<h3 style=color:#3B5998>Atentamente,<br>"
			Cuerpo = Cuerpo & "Equipo Mundo Maquinaria</h3>"
			Cuerpo = Cuerpo & "<br><br><img src= http://www.mundomaquinaria.cl/marchablanca/images/logo2.png>"

			MailObject.HTMLBody = Cuerpo
			MailObject.Send
			Set MailObject = Nothing
			Set cdoConfig = Nothing

			rs.movenext
			loop
		end if
		%>
	<!--Fin vencimiento del plan -->
	
	
		<!-- Cuenta visitas-->
		<%
Const cdoSendUsingPort = 2
iServer = "smtp.gmail.com"

		Response.CodePage = 65001
		Response.CharSet = "utf-8"

		sql="exec CuentaVisitas "
		set Rs = nothing
		Set Rs = cn.Execute(sql)

		%>
		<!-- Fin Cuenta visitas-->
		<!-- [Renato] : Se comenta llamada de hoja de estilo, ya que no existe. -->
		<!-- <link rel="stylesheet" type="text/css" href="estilo.css" /> -->

		<link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
		<link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
		<link href="assets/css/style.css" rel="stylesheet" />
		<link rel="icon" type="image/png" href="./images/icon.ico" />
		<title>Mundo Maquinaria</title>

		<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8; ISO-8859-1">-->
		<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />-->
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
        mostrarMensaje('La direcci�n de correo ' + Mail + ' es incorrecta','error');
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
// function validaDatos(formulario, pagina){
// 	var Rut 				= document.getElementById('Rut_Reg').value;
// 	var Nombre 				= document.getElementById('Nom_Reg').value;
// 	var Mail 				= document.getElementById('Mail_Reg').value;
// 	var Pass1 				= document.getElementById('password').value;
// 	var Pass2 				= document.getElementById('password2').value;

// 	if(Rut == null || Rut.length == 0 || /^\s+$/.test(Rut)){
// 		mostrarMensaje('El campo Rut no debe ser vac�o','error');
// 		return false;
// 	}

// 	if(Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)){
// 			mostrarMensaje('El campo Nombre no debe ser vac�o','error');
// 		return false;
// 		}
// 	/*if(Mail == null || Nombre.length == 0 ||/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3,4})+$/.test(Mail){*/
// 	if(Mail == null || Mail.length == 0 || /^\s+$/.test(Mail)){
// 			mostrarMensaje('El Mail es incorrecto','error');
// 		return false;
// 		}
// 	expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
//     if ( !expr.test(Mail) ){
//         mostrarMensaje('La direcci�n de correo ' + Mail + ' es incorrecta','error');
// 		return false;
// 		}
// 	if(Pass1 != Pass2 ){
// 		//mostrarMensaje('Las contrase�as no son iguales', 'error');
// 		mostrarMensaje('Estimado Usuario, Las contrase�as ingresadas no son iguales', 'error');
// 		//alert("Las contrase�as no son iguales")
// 		return false;
// 	}
// 		irA(formulario, pagina);

// }
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
				mostrarMensaje('Estimado Usuario, Para continuar con su b�squeda seleccione un EQUIPO', 'error');
				return false;
		}
		if(cmb_Region == null || cmb_Region == 0){
				//alert('ERROR: Debe seleccionar una Regi�n');
				mostrarMensaje('Estimado Usuario, Para continuar con su b�squeda seleccione una REGION', 'error');
				return false;
		}
		if(Rut == null || Rut.length == 0 || /^\s+$/.test(Rut)){
				//alert('ERROR: El campo Rut no debe ir vac�o');
				mostrarMensaje('Estimado Usuario, Para realizar su cotizaci�n ingrese su RUT (Ej. 11111111-1)', 'error');
				return false;
		}

		if(Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)){
				//alert('ERROR: El campo Nombre no debe ir vac�o');
				mostrarMensaje('Estimado Usuario, Para realizar su cotizaci�n ingrese su NOMBRE', 'error');
				return false;
		}
		if(Mail == null || Mail.length == 0 || /^\s+$/.test(Mail)){
				//alert('ERROR: El campo Mail no debe ir vac�o');
				mostrarMensaje('Estimado Usuario, Para realizar su cotizaci�n ingrese su Mail', 'error');
				return false;
		}
		if ( !expr.test(Mail) ){
			//alert("Error: La direcci�n de correo " + Mail + " es incorrecta.");
					mostrarMensaje('Estimado Usuario, La direcci�n de correo "' + Mail + '" es incorrecta.', 'error');
			return false;
		}

		if(NombreContacto == null || NombreContacto.length == 0 || /^\s+$/.test(NombreContacto)){
				//alert('ERROR: El campo Nombre Contacto no debe ir vac�o');
				mostrarMensaje('Estimado Usuario, Para realizar su cotizaci�n favor ingrese un NOMBRE DE CONTACTO', 'error');
				return false;
		}
		if(TelefonoContacto == null || TelefonoContacto.length != 9 || /^\s+$/.test(TelefonoContacto)){
				//alert('El telefono debe contener 9 digitos');
				mostrarMensaje('Estimado Usuario, El Tel�fono debe contener 9 d�gitos', 'error');
				return false;
		}

		if (!/^([0-9])*$/.test(TelefonoContacto)){
		//alert("El valor " + TelefonoContacto + " no es un n�mero");
				mostrarMensaje('Estimado Usuario, El valor para Tel�fono "' + TelefonoContacto + '" no es un n�mero', 'error');
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
	'sql = "select IDCLIENTE from Cliente c ,Usuario u where  c.id_usuario = u.id_usuario and u.Rut ='"&vRut&"' or mailCotizacion = '"&vMail&"' and u.estado = 9"
	set Rs = nothing
	Set Rs = cn.Execute(sql)

	if not rs.eof then
		vMensaje = rs("mensaje")
		if vMensaje = "RUT" then
		%>
		<script type="text/javascript">
			//mostrarMensaje('Estimado Usuario, el RUT ingresado ya es parte de nuestros registros', 'error');
			window.location="index.asp?msg=5";
		</script>
		<%
		elseif vMensaje = "MAIL" then
		%>
		<script type="text/javascript">
			//mostrarMensaje('Estimado Usuario, el RUT ingresado ya es parte de nuestros registros', 'error');
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
		
	'ENV�O DEL FORMULARIO DE CONTACTO
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
	Cuerpo = "<br><br>Estimado(a) se encuentra a solo un paso de pertenecer al equipo de Mundo Maquinaria, <br>&nbsp;&nbsp;&nbsp;&nbsp;Su usuario y contrase�a temporal es:"
	Cuerpo = Cuerpo & " .<br><br>&nbsp;&nbsp;&nbsp;&nbsp;"
	Cuerpo = Cuerpo & "<br><br> RUT:" & vRut & "<br> Contrase�a: " & vPass & "<br> </a>"
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
		//alert("El clinete ya existe.");
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
		sql=sql & " '" & request.Form("operador") & "', "
		sql=sql & " '" & request.Form("combustible") & "', "
		sql=sql & " '" & request.Form("traslados") & "', "
		sql=sql & " '" & request.Form("mensaje") & "', "
		sql=sql & " '" & request.Form("textfield") & "', "
		sql=sql & " '" & request.Form("textfield4") & "', "
		sql=sql & " '" & request.Form("textfield3") & "', "
		sql=sql & " '" & request.Form("textfield5") & "', "
		sql=sql & " '" & request.Form("textfield2") & "', "
		sql=sql & " '" & request.Form("plazos") & "' "

		set Rs = nothing
		Set Rs = cn.Execute(sql)

	%>
		<script type="text/javascript">
			//alert("Cotizaci�n agregada exitosamente.");
			//mostrarMensaje('Cotizaci�n agregada exitosamente','success');
			window.location="index.asp?rutCotiza=<%=request.Form("textfield")%>&msg=1";
		</script>
		<%
end if
if request.QueryString("est") = "2" then

    nombre  = request.Form("nom_cont")
	mail    = request.Form("mail_cont")
	asunto  = request.Form("textfield3")
	mensaje = request.Form("men_cont")

	'ENV�O DEL FORMULARIO DE CONTACTO
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
		//alert("Cotizaci�n eliminada exitosamente")
		//mostrarMensaje('Cotizaci�n eliminada exitosamente','success');
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
						<!-- #include file="HeaderMenu.asp" -->
					</div>
					<!-- [Renato] : Inicio -->
					<div class="form-group">
						<nav id="nav2" style="display: none;"></nav>
					</div>
					<!-- [Renato] : Fin -->
				</header>

			<!-- Banner -->
				<section id="banner" class="banner-index">
					<h2>La m�quina que buscas est� aqu�</h2>
					<p>Maquinarias en arriendo, venta y servicio t�cnico.</p>

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
									<select name="tipo" id="tipo" style="font-weight:bold; color:#3B5998; cursor: pointer;" value="<%=vTipo%>">
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
									<select name="equipo" id="equipo" style="font-weight:bold; color:#3B5998; cursor: pointer;" value="<%=vEquipo%>">
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
		<script language = "JavaScript">
			<%
			productos_Sql = "SELECT Id_DatosComunes, Descripcion, Nivel_Superior FROM Datos_Comunes WHERE Tipo=4 and Nivel = 1 and Estado = 1 order by Descripcion asc "
			Set rs=nothing
			Set rs = cn.Execute(productos_Sql)
			x=0

			productos_Sql2 = "SELECT Id_DatosComunes, Descripcion, Nivel_Superior FROM Datos_Comunes WHERE Tipo=4 and Nivel = 1 and Estado = 1 order by Descripcion asc "
			Set rs2=nothing
			Set rs2 = cn.Execute(productos_Sql2)
			x2=0
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

			function sublist2(inform, selecteditem2)
			{
			// console.log('$subcatagory.length: ' + $('#subcatagory').length);
			$('#subcatagory2')["0"].length = 0; //inform.subcatagory.length = 0

			<%
			count2= 0
			y2=0
			do while not rs2.eof
			%>

			x2 = <%= trim(y) %>;

			subcat2 = new Array();
			subcatagorys2 = "<%=(rs2("Descripcion")) %>";
			subcatagoryof2 = "<%=(rs2("Nivel_Superior"))%>";
			subcatagoryid2 = "<%=(rs2("Id_DatosComunes"))%>";
			subcat2[x2,0] = subcatagorys2;
			subcat2[x2,1] = subcatagoryof2;
			subcat2[x2,2] = subcatagoryid2;
			if (subcat2[x2,1] == selecteditem2) {
			var option<%= trim(count2) %> = new Option(subcat2[x2,0], subcat2[x2,2]);
			$('#subcatagory2')["0"].options[$('#subcatagory2')["0"].length]=option<%= trim(count2)%>;
			// console.log('inform.subcatagory.length: ' + inform.subcatagory.length);
			// console.log('$subcatagory.length: ' + $('#subcatagory')["0"].length);
			}
			<%
			count2 = count2 + 1
			y2 = y2 + 1
			rs2.movenext
			loop
			rs2.close
			%>
			}

		</script>
		<script language = "JavaScript">
				<%	
				productos_Sql2 = "SELECT Id_DatosComunes, Descripcion, Nivel_Superior FROM Datos_Comunes WHERE Tipo=4 and Nivel = 1 and Estado = 1 order by Descripcion asc "
				Set rs2=nothing
				Set rs2 = cn.Execute(productos_Sql2)
				x2=0
				%>
	
				function sublist2(inform, selecteditem2)
				{
				// console.log('$subcatagory.length: ' + $('#subcatagory').length);
				$('#subcatagory2')["0"].length = 0; //inform.subcatagory.length = 0
	
				<%
				count2= 0
				y2=0
				do while not rs2.eof
				%>
	
				x2 = <%= trim(y) %>;
	
				subcat2 = new Array();
				subcatagorys2 = "<%=(rs2("Descripcion")) %>";
				subcatagoryof2 = "<%=(rs2("Nivel_Superior"))%>";
				subcatagoryid2 = "<%=(rs2("Id_DatosComunes"))%>";
				subcat2[x2,0] = subcatagorys2;
				subcat2[x2,1] = subcatagoryof2;
				subcat2[x2,2] = subcatagoryid2;
				if (subcat2[x2,1] == selecteditem2) {
				var option<%= trim(count2) %> = new Option(subcat2[x2,0], subcat2[x2,2]);
				$('#subcatagory2')["0"].options[$('#subcatagory2')["0"].length]=option<%= trim(count2)%>;
				console.log('$subcatagory2.length: ' + $('#subcatagory2')["0"].length);
				}
				<%
				count2 = count2 + 1
				y2 = y2 + 1
				rs2.movenext
				loop
				rs2.close
				%>
				}
	
			</script>

			<select size="1" id="familia" name="familia" onChange = "javascript:sublist(this.form, familia.value);" style="font-weight:bold; color:#3B5998; height: 3em; cursor: pointer;" value="<%=Ucase(vRegion)%>">

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
		<SELECT id="subcatagory" name="subcatagory" size="1" style="font-weight:bold; color:#3B5998; height: 3em; cursor: pointer;" value="<%=Ucase(vCiudad)%>">
			<Option selected value="0">CIUDAD</option>
		</SELECT>
	</div>
	</li>
							<li>
								<div class="btn-header">
								<button type="button" class="button" id="bt_cotizar" style="background:#F7931E" data-toggle="modal" data-target="#myModal9">
									COTIZAR
								</button>
                                                                </div>
								<div class="modal fade" id="myModal9" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">

										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">Cotizar</h4>
											</div>
											<div class="modal-body ">
												<div class="form-group">
													<label>RUT</label>
													<input class="form-control text-box-modal" placeholder="11111111-1" type="text" style="color:#F7931E" id ="textfield" name="textfield" value="<%=vRut2%>"/>
													<div data-role="popup" class="popUp-validacion" id="popUpRut"></div>
												</div>
												<div class="form-group">
													<label>RAZ�N SOCIAL / NOMBRE</label>
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
													<label>TEL�FONO CONTACTO</label>
													<input class="form-control text-box-modal" placeholder="Tel�fono Contacto" type="text" style="color:#F7931E" id="textfield5" name="textfield5" value="<%=vTelefono%>"/>
													<div data-role="popup" class="popUp-validacion" id="popUpTContacto"></div>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-modal" style="background:#F7931E" onClick="javascript:validarCotizacion(document.forms.formCotizacion,'index.asp?est=1');">Cotizar</button>


											</div>
									</div>

									</div>
								</div>

	<!-- POPUP-->			</li>

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
											<!--<form name="formContact3" method="post" >-->
											<div class="col-md-12">
											 <!--   Basic Table  -->
											<div class="panel panel-default">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
													<h4 class="modal-title" id="myModalLabel">Listado de Solicitud de Cotizaci�n</h4>
												</div>
												<!-- <div class="panel-heading">
													Listado de Solicitud de Cotizacion
												</div> -->
												<div class="panel-body">
													<div class="table-responsive">
														<table class="table">
															<thead>
																<tr>
																	<TH>OPC</TH>
																	<TH>TIPO COTIZACION</TH>
																	<TH>EQUIPO</TH>
																	<TH>REGI�N</TH>
																	<TH>CIUDAD</TH>
																	<TH>RUT</TH>
																	<TH>NOMBRE</TH>
																	<TH>EMAIL</TH>
																	<TH>TEL�FONO</TH>
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
														<button type="button" class="button btn-entrar" style="background:#F7931E" onClick="javascript:irA(document.forms.formCotizacion,'cotizacion.asp?est=5&rut=<%=vRut%>&tipo=<%=vIdTipoCotiza%>');">ENVIAR A COTIZAR</button>
														<!--<button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.formCotizacion,'index.asp?est=4&rut=<%=vRut%>');">ELIMINAR</button>-->
														<button type="button" class="button btn-entrar" style="background:#F7931E" onClick="javascript:irA(document.forms.formCotizacion,'index.asp?rutCotiza=<%=vRut%>');">AGREGAR</button>
													</div>
												</div>
											</div>
											  <!-- End  Basic Table  -->
										</div>
										<!--</form>-->
										</div>
									<!--</div>-->
							</li>
						</ul>
						<ul>
							<li>
								<div class="accordion-heading">
									<div class="widget-title">
										<a class="opt-avanz" data-toggle="modal" data-target="#modalOpcAvanz" style=" cursor: pointer;">
											<span class="icon"><i class="glyphicon glyphicon-wrench"></i> Opciones Avanzadas</span>
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
																Set rs=nothing
																Set rs = cn.Execute(sql)
																%>
																<select name="plazos" id="plazos" style="font-weight:bold; color:#3B5998; cursor: pointer;" value="<%=vPlazos%>">
																	<%
																	response.write "<option value=0>PLAZOS DE ARRIENDO</option>"
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
													</div>
													<div class="control-group">
														<label class="control-label">Mensaje:
															<textarea class="text-area" name="mensaje" id="mensaje"></textarea>
														</label>
													</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
											</div>
										</div>
									</div>
								</div>
							</li>
						</ul>
						</form>
					</nav>

					</ul>
				</section>

			<!-- Main -->
				<section id="main" class="container">

					<section class="box special features">
						<div class="13u 10u(narrower)">
							<section>
								 <div >
                    <div id="carousel-example" class="carousel slide slide-bdr" data-ride="carousel" >

                    <div class="carousel-inner">
                       <%
						sql="exec MantenedorPublicidad "
						sql=sql & " 4 , -1 , '' , 0 , 0, '', 1231, ''"

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
						sql=sql & " '', 1231, '' "

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
              </div>

							</section>
						</div>

						<div class="features-row" >
							<section style="border-style: solid; border-width: 1px;">
								<%
								sql="exec MantenedorPublicidad "
								sql=sql & " 5 , "
								sql=sql & " " & vIdPublicidad &" , "
								sql=sql & " '' , "
								sql=sql & " 0 , "
								sql=sql & " 0 , "
								sql=sql & " '', 1232, '' "
								set rs6 = nothing
								Set rs6 = cn.Execute(sql)
								if not rs6.eof then
								%>
								<p><img src="<%=rs6("ruta")%>" alt="" /></p>
								<%end if%>
							</section >
							<section style="border-style: solid; border-width: 1px;">
								<%
								sql="exec MantenedorPublicidad "
								sql=sql & " 5 , "
								sql=sql & " " & vIdPublicidad &" , "
								sql=sql & " '' , "
								sql=sql & " 0 , "
								sql=sql & " 0 , "
								sql=sql & " '', 1233, '' "

								set rs7 = nothing
								Set rs7 = cn.Execute(sql)
								if not rs7.eof then
								%>
								<p><img src="<%=rs7("ruta")%>" alt="" /></p>
								<%end if%>
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
			<h4 class="modal-title" id="myModalLabel">Pol�ticas de privacidad</h4>
		</div>
		<div class="panel-body">
			<div class="table-responsive">
				<h5>
				<p><b>General<br>
				<p align="justify">Al acceder al sitio www.mundomaquinaria.cl el usuario est� aceptando y reconoce que ha revisado y est� de acuerdo con esta Pol�tica de Privacidad.
				<br><p align="justify">Mundo Maquinaria SpA se reserva el derecho a modificar la presente pol�tica de privacidad y ser� responsabilidad del usuario la lectura y acatamiento de esta cada vez que ingrese al sitio.
				<p>Acceso a la Informaci�n<br>
				<p align="justify">El acceso a la informaci�n del sitio www.mundomaquinaria.cl tiene car�cter gratuito, sin embargo hay informaci�n que est� limitada para usuarios que previamente se hubieren registrado como tales y aceptado los T�rminos y Condiciones Generales del sitio.
				<br><p align="justify">Para acceder a ellos los usuarios registrados podr�n acceder con su correo electr�nico y clave que les correspondan.
				<p>Informaci�n de los usuarios<br>
				<p align="justify">Mundo Maquinaria SpA recopila datos de los usuarios registrados que hagan uso de este portal conforme a los T�rminos y Condiciones Generales del mismo. La entrega de esta informaci�n ser� voluntaria y se indicar� claramente el fin para el cual est� siendo solicitada, previa a la aceptaci�n que debe realizar el usuario.</p>
				<p>Informaci�n a terceros<br>
				<p align="justify">Mundo Maquinaria SpA no comunicar� ni transferir� a terceros los datos personales de sus usuarios sin el consentimiento expreso del titular. No obstante lo anterior, en caso de ser requerido judicialmente se har� entrega de la informaci�n solicitada.
				<p>Uso de la informaci�n<br>
				<p align="justify">Todos los derechos referidos a www.mundomaquinaria.cl y sus contenidos, incluidos los de propiedad intelectual, pertenecen a Mundo Maquinaria SpA.
				<br><p align="justify">Al acceder al sitio, el visitante tendr� derecho a revisar toda la informaci�n que est� disponible en �l. Sin perjuicio de lo anterior, Mundo Maquinaria no se hace responsable por la veracidad o exactitud de la informaci�n que haya sido entregada por terceros.</p>
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
			<h4 class="modal-title" id="myModalLabel">T�RMINOS Y CONDICIONES GENERALES DEL SITIO WWW.MUNDOMAQUINARIA.CL</h4>
		</div>
		<div class="panel-body">
			<div class="table-responsive">
				<h5>
				<p align="justify">Este contrato describe los t�rminos y condiciones generales (en adelante los �TCG�) que se aplican al uso de los servicios (en adelante los �Servicios") ofrecidos por Mundo Maquinaria SpA (en adelante �Mundo Maquinaria�) a trav�s de su sitio web www.mundomaquinaria.cl (en adelante el �Sitio�).<br>
				<br><p align="justify">Cualquier persona que desee acceder y/o usar el Sitio o los Servicios podr� hacerlo sujet�ndose a �stos TCG junto con todas las dem�s pol�ticas y principios que rigen el Sitio y que son incorporados a los presentes TCG por referencia. <br>
				<br><p align="justify">TODA PERSONA QUE SE REGISTRE EN EL SITIO WWW.MUNDOMAQUINARIA.CL EN CALIDAD DE USUARIO DEBER�, EN FORMA PREVIA A SU UTILIZACI�N, ACEPTAR ESTOS T�RMINOS Y CONDICIONES GENERALES, LOS CUALES TENDR�N SIEMPRE UN CAR�CTER OBLIGATORIO Y VINCULANTE.<br>
				<p align="justify">El Usuario debe leer, entender y aceptar todas las condiciones establecidas en los presentes TCG as� como en los dem�s documentos incorporados a los mismos por referencia, previo a su inscripci�n como Usuario de Mundo Maquinaria. <br>
				<br><p align="justify">Mundo Maquinaria podr� realizar modificaciones a los TCG en cualquier momento, debiendo hacer p�blicos en el Sitio los t�rminos modificados para ponerlos en conocimiento de los Usuarios y dando aviso de ello mediante correo electr�nico al que estuviera registrado por parte del Usuario. Los t�rminos modificados entrar�n en vigor en el plazo de 10 (diez) d�as desde su publicaci�n en el Sitio. Transcurrido ese plazo, el silencio se considerar� como aceptaci�n del Usuario y el contrato continuar� vinculando a ambas partes. Si el Usuario no aceptare las modificaciones a los presentes TCG, deber�, en el mismo plazo indicado anteriormente, comunicarlo por escrito al correo electr�nico contacto@mundomaquinaria.cl, cesando desde ese momento todos los efectos que emanan de estos TCG y quedando autom�ticamente inhabilitado como Usuario, siempre y cuando no tenga obligaciones o deudas  pendientes con Mundo Maquinaria, las que deber�n solucionarse antes de dar por terminado el v�nculo contractual entre las partes.<br>
				<br><p align="justify">Los Servicios se prestar�n a personas naturales o jur�dicas que tengan capacidad legal para contratar. No podr�n utilizar los servicios las personas que no tengan esa capacidad, los menores de edad o Usuarios de Mundo Maquinaria que hayan sido suspendidos temporalmente o inhabilitados definitivamente. En el caso de personas jur�dicas, debe tratarse de un representante legal con facultades necesarias y suficientes para contratar a nombre de tal entidad y de obligar a la misma en los t�rminos de estos TCG. Por lo tanto, se considerar� que cualquier persona jur�dica que utilice los servicios de �Mundo Maquinaria� cumple con lo se�alado anteriormente.<br>
				<br><b>1. CONDICIONES GENERALES Y DEFINICIONES PREVIAS.</b><br>
				<br><p align="justify"> 1.1 El objetivo de los Servicios es proporcionar un sitio en internet para la b�squeda y oferta de maquinarias, as� como servicios y productos afines. El Sitio incluye condiciones de uso y pol�ticas de privacidad que fijan las medidas que Mundo Maquinaria puede tomar para que la informaci�n que le facilitan los Usuarios permanezca segura y sea utilizada �nicamente para los fines a los que est� destinada. <br>
				<br><p align="justify"> 1.2 Mundo Maquinaria no es propietario de los bienes y servicios publicados u ofrecidos a trav�s del Sitio, ni participa de modo alguno en el negocio de arriendo o venta de los mismos y no recibe comisi�n por las transacciones efectuadas entre los Usuarios. Asimismo, no comercializa los productos y servicios publicados. Su vinculaci�n a estos productos, sus oferentes y las ofertas encontradas en el Sitio, se limita �nicamente ser un medio de publicaci�n en internet. La informaci�n publicada es de exclusiva responsabilidad de los Usuarios. <br>
				<br><p align="justify"> 1.3 Niveles de interacci�n con el Sitio. Existen distintos niveles de vinculaci�n con el Sitio, seg�n las siguientes definiciones: <br>
				<br><p align="justify">a. Visitante: Es todo aquel usuario que accede a una o m�s p�ginas de informaci�n publicada en el Sitio, no exigi�ndose su identificaci�n para dicho acceso.<br>
				<br><p align="justify">b. Usuario: Es aquel Visitante registrado que hace uso del Sitio para ofrecer el arriendo, la venta de un producto determinado o la prestaci�n de alg�n servicio. <br>
				<br> 2. INSCRIPCI�N DEL USUARIO.<br>
				<br><p align="justify">Para poder acceder a los Servicios es obligatorio que el Usuario se registre previamente en el Sitio completando el formulario de inscripci�n destinado a tal efecto, oblig�ndose a proporcionar toda la informaci�n y datos requeridos en forma exacta, precisa y fidedigna  (en adelante los "Datos Personales"). El Usuario asume el compromiso de actualizar sus Datos Personales conforme resulte necesario. Mundo Maquinaria podr� utilizar diversos medios para identificar a sus Usuarios, pero NO se responsabiliza por la certeza ni veracidad de los Datos Personales que sus Usuarios le han entregado. Los Usuarios garantizan y responden, en cualquier caso, de la veracidad, exactitud, vigencia y autenticidad de los Datos Personales puestos a disposici�n de Mundo Maquinaria.<br>
				<br><p align="justify">Mundo Maquinaria se reserva el derecho de solicitar alg�n comprobante y/o dato adicional a efectos de corroborar los Datos Personales, as� como de suspender temporal o definitivamente a aquellos Usuarios cuyos datos no hayan podido ser confirmados. En estos casos de inhabilitaci�n, se dar� de baja todos los art�culos publicados, as� como las ofertas realizadas, sin que ello genere alg�n derecho a resarcimiento.<br>
				<br><p align="justify">El Usuario acceder� a su cuenta personal (en adelante la "Cuenta") mediante el ingreso de su correo electr�nico a su elecci�n, y de la clave de seguridad personal elegida (en adelante "Clave de Seguridad"). El Usuario se obliga a mantener la confidencialidad de su Clave de Seguridad. La Cuenta es personal, �nica e intransferible, y est� prohibido que un mismo Usuario inscriba o posea m�s de una Cuenta. En caso que Mundo Maquinaria detecte distintas Cuentas que contengan datos coincidentes o relacionados, las podr� cancelar, suspender o inhabilitarlas.<br>
				<br><p align="justify">El Usuario ser� el exclusivo responsable por todas las operaciones efectuadas en su Cuenta, pues el acceso a la misma est� restringido al ingreso y uso de su Clave de Seguridad, de conocimiento exclusivo del Usuario. El Usuario se compromete a notificar a Mundo Maquinaria, en forma inmediata y por un medio id�neo y fehaciente, cualquier uso no autorizado de su Cuenta, as� como el ingreso por terceros no autorizados a la misma. Est� prohibido la venta, cesi�n o transferencia de la Cuenta (incluyendo la reputaci�n y calificaciones) bajo ning�n t�tulo.
					<p align="justify">Mundo Maquinaria se reserva el derecho de rechazar cualquier solicitud de inscripci�n o de cancelar una inscripci�n previamente aceptada, sin que est� obligado a comunicar o exponer las razones de su decisi�n y sin que ello genere alg�n derecho a indemnizaci�n o resarcimiento.<br>
				<br><b>3. TRATAMIENTO DE LOS DATOS PERSONALES.</b><br>
				<br><p align="justify">En relaci�n con el almacenamiento, custodia, conservaci�n y tratamiento de los Datos Personales, conforme a lo indicado en la cl�usula anterior, Mundo Maquinaria se obliga a dar pleno cumplimiento en todo momento a las disposiciones contenidas al respecto en la ley 19.628 sobre protecci�n de la vida privada, como asimismo a cualquier otra norma de car�cter legal o administrativo relacionada con ella, que la sustituya, reemplace o modifique total o parcialmente.<br>
				<br><p align="justify">Conforme a lo anterior, al aceptar los presentes TCG, el Usuario autoriza a Mundo Maquinaria para que �sta pueda compartir los Datos Personales proporcionados a trav�s del Sitio con los otros Usuarios, con la �nica y exclusiva finalidad de poner en contacto a eventuales vendedores y compradores de los productos que se publican  es en el Sitio, facilitando el encuentro de los mismos y el aprovechamiento de oportunidades comerciales entre ellos. Se deja expresa constancia que la presente autorizaci�n est� limitada �nicamente a estos fines comerciales inherentes a la actividad econ�mica que Mundo Maquinaria desarrolla a trav�s del Sitio.
				<br><br><b><p align="justify">4. PUBLICACI�N DE BIENES Y/O SERVICIOS.</b>
				<br><br><b><p align="justify">4.1 Publicaci�n de bienes y/o servicios.</b> El Usuario podr� ofrecer la venta y/o el arriendo de bienes y/o servicios en las categor�as y sub-categor�as apropiadas. Las publicaciones podr�n incluir textos descriptivos, gr�ficos, fotograf�as y otros contenidos y condiciones pertinentes para la venta del bien o la contrataci�n del servicio, siempre que no violen ninguna disposici�n de este acuerdo o dem�s pol�ticas de Mundo Maquinaria. El producto ofrecido por el Usuario debe ser exacta y fidedignamente descrito en cuanto a sus condiciones y caracter�sticas relevantes. Se entiende y presume que mediante la inclusi�n del bien o servicio en el Sitio, el Usuario expresa su intenci�n de vender y/o arrendar el bien por �l ofrecido, o est� facultado para ello por su titular y lo tiene disponible para su entrega inmediata. Se establece que los precios de los productos publicados deber�n ser expresados netos de IVA, cuando corresponda la aplicaci�n del mismo, y en moneda del curso legal. Mundo Maquinaria podr� remover cualquier publicaci�n cuyo precio no sea expresado de esta forma para evitar confusiones o malos entendidos en cuanto al precio final del producto. En caso que se infrinja cualquiera de las disposiciones establecidas en esta cl�usula, Mundo Maquinaria podr� editar el espacio, solicitar al Usuario que lo edite, o dar de baja la publicaci�n donde se encuentre la infracci�n y en ning�n caso se devolver�n o bonificar�n los cargos de publicaci�n.
				<br><br><b><p align="justify">4.2 Inclusi�n de im�genes y fotograf�as.</b> En la medida que el tipo de aviso seleccionado lo permita, el Usuario puede incluir im�genes y fotograf�as del producto ofrecido siempre que las mismas se correspondan con el art�culo, salvo que se trate de bienes, productos o servicios que por su naturaleza no permiten esa correspondencia. Mundo Maquinaria podr� impedir la publicaci�n de la fotograf�a, e incluso del producto, si interpretara, a su exclusivo criterio, que la imagen no cumple con los presentes TCG.
				<br><br><b><p align="justify">4.3 Art�culos Prohibidos.</b> S�lo podr�n ser ingresados en las listas de bienes y/o servicios ofrecidos, aquellos que correspondan a la categor�a y sub-categor�a seleccionada. Los bienes, productos o servicios no incluidos en alguna de ellas se encuentran prohibidos de publicar. Mundo Maquinaria podr� cancelar una publicaci�n si estima que esta: (i) no cumple con el esp�ritu del Sitio; (ii) est� en contra de la moral y sanas costumbres; o (iii) es ilegal o no ajustada a derecho; sin que en cualquiera de estos casos exista derecho del Usuario a ser resarcido o indemnizado por esta cancelaci�n.
				<br><br><b><p align="justify">4.4 Prohibici�n de Duplicaci�n de Avisos:</b> Para poder dar una mejor experiencia a los potenciales compradores y al p�blico en general que visite el Sitio, Mundo Maquinaria no aceptar� avisos duplicados, es decir, un bien o servicio solo se puede publicar una sola vez. Esto es v�lido para los avisos que el Usuario disponga por cualquiera de los medios disponibles. En caso de detectarse duplicaci�n de avisos, Mundo Maquinaria se reserva el derecho de cancelar el aviso sin derecho a compensaci�n alguna a quien lo public�.
				<br><br><b>5. OBLIGACIONES DE LOS USUARIOS.</b>
				<br><br><p align="justify">El Usuario debe tener capacidad legal para vender y/o arrendar el bien objeto de su oferta. Dado que Mundo Maquinaria es un punto de encuentro entre compradores y vendedores y no participa de las operaciones que se realizan entre ellos, el Usuario ser� responsable por todas las obligaciones y cargas impositivas que correspondan por la venta de sus art�culos, sin que pudiera imput�rsele a Mundo Maquinaria alg�n tipo de responsabilidad por incumplimientos en tal sentido.
				<br><br><p align="justify">Mundo Maquinaria s�lo pone a disposici�n de los Usuarios y p�blico en general un espacio virtual que les permite comunicarse mediante Internet para encontrar una forma de vender,  comprar o arrendar bienes y servicios. Mundo Maquinaria no tiene participaci�n ni injerencia alguna en el proceso de negociaci�n y perfeccionamiento del contrato definitivo entre las partes. Por eso, Mundo Maquinaria no es responsable por el efectivo cumplimiento de las obligaciones fiscales o impositivas establecidas por la legislaci�n vigente. Mundo Maquinaria tampoco es responsable de la informaci�n proporcionada por los Usuarios, no otorga garant�as de ning�n tipo, ni presta servicios de traslado o alg�n otro referente al proceso de compra y entrega.
				<br><br><b>6. PRIVACIDAD DE LA INFORMACI�N.</b>
				<br><br><p align="justify">Para utilizar los Servicios los Usuarios deber�n facilitar determinados Datos Personales. Esta informaci�n se procesa y almacena en servidores o medios magn�ticos que mantienen altos est�ndares de seguridad y protecci�n tanto f�sica como tecnol�gica. Para mayor informaci�n sobre la privacidad de los Datos Personales y casos en los que ser� revelada la informaci�n personal, se puede consultar nuestra Pol�tica de Privacidad, la que forma parte integrante de los presentes TCG y del sitio www.mundomaquinaria.cl.
				<br><br><b>7. PROHIBICIONES A LOS USUARIOS.</b>
				<br><br><p align="justify">Los Usuarios no podr�n publicar, vender y/o arrendar art�culos prohibidos por los TCG, dem�s pol�ticas de Mundo Maquinaria o leyes vigentes. Tambi�n est� prohibido insultar o agredir a otros Usuarios  trav�s del Sitio.
				<br><br><p align="justify">Cualquier infracci�n o contravenci�n a lo dispuesto en los presentes TCG ser� investigada por Mundo Maquinaria y el infractor podr� ser sancionado con la suspensi�n o cancelaci�n de la Cuenta, la oferta realizada e incluso de su inscripci�n como Usuario y/o de cualquier otra forma que Mundo Maquinaria estime pertinente, sin perjuicio de las acciones legales que correspondan derivadas de una eventual responsabilidad civil y/o penal, como de aquellas destinadas a la indemnizaci�n de perjuicios civiles que hubiera podido causar a otros Usuarios o a Mundo Maquinaria.
				<br><br><b>8. VIOLACIONES DEL SISTEMA O BASES DE DATOS.
				<br><br><p align="justify">No est� permitida ninguna acci�n o uso de dispositivo, software, u otro medio tendiente a interferir tanto en las actividades y operatoria de Mundo Maquinaria como en las ofertas, descripciones, Cuentas o bases de datos de Mundo Maquinaria. Cualquier intromisi�n, tentativa o actividad violatoria o contraria a las leyes sobre derecho de propiedad intelectual y/o a las prohibiciones estipuladas en estos TCG har�n responsable al infractor de las acciones legales pertinentes, as� como de indemnizar los da�os ocasionados.
				<br><br>9. SANCIONES Y SUSPENSI�N DE LAS OPERACIONES.
				<br><br><p align="justify">Sin perjuicio de otras medidas, Mundo Maquinaria podr� advertir, suspender en forma temporal o inhabilitar definitivamente la Cuenta de un Usuario o una publicaci�n, iniciar las acciones que estime pertinentes y/o suspender la prestaci�n de sus Servicios si (i) se quebrantara alguna ley, o cualquiera de las estipulaciones de los TCG y dem�s pol�ticas de Mundo Maquinaria; (ii) si incumpliera sus compromisos como Usuario; (iii) si se incurriera a criterio de Mundo Maquinaria en conductas o actos dolosos o fraudulentos; (iv) no pudiera verificarse la identidad del Usuario o cualquier informaci�n proporcionada por el mismo fuere err�nea; y (v) Mundo Maquinaria entendiera que las publicaciones u otras acciones pueden ser causa de responsabilidad para el Usuario que las public�, para Mundo Maquinaria o para los Usuarios. En el caso de la suspensi�n o inhabilitaci�n de un Usuario, todos los art�culos que tuviera publicados ser�n removidos del sistema y en ning�n caso se devolver�n o bonificar�n los cargos de publicaci�n involucrados. Tambi�n se remover�n del sistema las ofertas de compra de bienes ofrecidos en subasta.
				<br><br>10. RESPONSABILIDAD.</b>
				<br><br><p align="justify">Mundo Maquinaria s�lo pone a disposici�n de los Usuarios un espacio virtual que les permite ponerse en comunicaci�n mediante Internet para encontrar una forma de vender o comprar servicios o bienes. Mundo Maquinaria no es el propietario de los art�culos ofrecidos, no tiene posesi�n de ellos ni los ofrece en venta. Mundo Maquinaria no interviene en el perfeccionamiento de las operaciones realizadas entre los Usuarios ni en las condiciones por ellos estipuladas para las mismas, por ello no ser� responsable respecto de la existencia, calidad, cantidad, estado, integridad o legitimidad de los bienes ofrecidos, adquiridos o enajenados por los Usuarios, as� como de la capacidad para contratar de los Usuarios o de la veracidad de los Datos Personales por ellos ingresados. Cada Usuario conoce y acepta ser el exclusivo responsable por los art�culos que publica para su venta y/o arriendo y por las ofertas y/o compras que realiza.
				<br><br><p align="justify">Debido a que Mundo Maquinaria no tiene ninguna participaci�n durante todo el tiempo en que el art�culo se publica para la venta o arriendo, ni en la posterior negociaci�n y perfeccionamiento del contrato definitivo entre las partes, no ser� responsable por el efectivo cumplimiento de las obligaciones asumidas por los Usuarios en el perfeccionamiento de la operaci�n. El Usuario conoce y acepta que al realizar operaciones con otros Usuarios o terceros lo hace bajo su propio cuenta y riesgo. En ning�n caso Mundo Maquinaria ser� responsable por lucro cesante, o por cualquier otro da�o y/o perjuicio que haya podido sufrir el Usuario, debido a las operaciones realizadas o no realizadas por art�culos publicados a trav�s de Mundo Maquinaria.
				<br><br><p align="justify">Mundo Maquinaria NO ser� responsable por la realizaci�n de ofertas y/o operaciones con otros Usuarios basadas en la confianza depositada en el sistema o los Servicios brindados por Mundo Maquinaria.
				<br><br><p align="justify">En caso que uno o m�s Usuarios o alg�n tercero inicien cualquier tipo de reclamo o acciones legales contra otro u otros Usuarios, todos y cada uno de los Usuarios involucrados en dichos reclamos o acciones eximen de toda responsabilidad a Mundo Maquinaria y a todos sus socios, accionistas, directores, gerentes, ejecutivos, empleados, agentes, operarios, representantes y apoderados.
				<br><br><b>11. ALCANCE DE LOS SERVICIOS DE MUNDO MAQUINARIA.</b>
				<br><br><p align="justify">Este acuerdo no crea ning�n contrato de sociedad, de mandato, de franquicia, o relaci�n laboral entre Mundo Maquinaria y el Usuario. El Usuario reconoce y acepta que Mundo Maquinaria no es parte en ninguna operaci�n, ni tiene control alguno sobre la calidad, seguridad o legalidad de los art�culos anunciados, la veracidad o exactitud de los anuncios, la capacidad de los Usuarios para vender o comprar art�culos. Mundo Maquinaria no puede asegurar que un Usuario completar� una operaci�n ni podr� verificar la identidad o Datos Personales ingresados por los Usuarios. Mundo Maquinaria no garantiza la veracidad de la publicidad de terceros que aparezca en el Sitio y no ser� responsable por la correspondencia o contratos que el Usuario celebre con dichos terceros o con otros Usuarios.
				<br><br><b>12. FALLAS EN EL SISTEMA.</b>
				<br><br><p align="justify">Mundo Maquinaria no se responsabiliza por cualquier da�o, perjuicio o p�rdida al Usuario causados por fallas en el sistema, en el servidor o en Internet. Mundo Maquinaria tampoco ser� responsable por cualquier virus que pudiera infectar el equipo del Usuario como consecuencia del acceso, uso o examen de su sitio web o a ra�z de cualquier transferencia de datos, archivos, im�genes, textos, o audio contenidos en el mismo. Los Usuarios NO podr�n imputarle responsabilidad alguna ni exigir pago por perjuicios directos o indirectos ni lucro cesante, en virtud de perjuicios resultantes de dificultades t�cnicas o fallas en los sistemas o en Internet. Mundo Maquinaria no garantiza el acceso y uso continuado o ininterrumpido de su sitio. El sistema puede eventualmente no estar disponible debido a dificultades t�cnicas o fallas de Internet, o por cualquier otra circunstancia ajena a Mundo Maquinaria; en tales casos se procurar� restablecerlo con la mayor celeridad posible sin que por ello pueda imput�rsele alg�n tipo de responsabilidad. Mundo Maquinaria no ser� responsable por ning�n error u omisi�n contenidos en su Sitio.
				<br><br><b>13. TARIFAS COBROS POR EL SERVICIO. </b>
				<br><br><p align="justify">La inscripci�n en Mundo Maquinaria es gratuita. Al publicar bienes o servicios para la venta o arriendo, el Usuario deber� pagar un cargo de publicaci�n, cuyo costo es variable de acuerdo al plan que elija. El precio de dichos planes variar� conforme a la cantidad de informaci�n que �stos permitan cargar o publicar en el Sitio.
				<br><br><p align="justify">Todo anuncio ser� activado una vez confirmado el pago por parte de Mundo Maquinaria. El anuncio podr� ser eliminado del Sitio si han transcurrido m�s de cuarenta y ocho (48) horas desde su ingreso al sistema y no se ha recibido la confirmaci�n del pago.
				<br><br><p align="justify">Mundo Maquinaria se reserva el derecho de modificar, cambiar, agregar, o eliminar las tarifas vigentes, en cualquier momento, lo cual ser� notificado a los Usuarios. Sin embargo, Mundo Maquinaria podr� modificar temporalmente las tarifas, tanto en su forma como en su valor, por sus servicios en raz�n de promociones, haci�ndose efectivas estas modificaciones cuando se haga p�blica la promoci�n o se realice el anuncio.
				<br><br><b>14. PROMOCIONES Y AVISOS GRATIS.</b>
				<br><br><p align="justify">Los avisos publicados en el Sitio deben ser pagados por el Usuario. La tarifa de �stos ser� variable seg�n el plan seleccionado por el Usuario, sin perjuicio del derecho de Mundo Maquinaria a realizar una o m�s promociones con tarifas distintas por per�odos de tiempo determinados.
				<br><br><b>15. PROPIEDAD INTELECTUAL DEL CONTENIDO DEL SITIO.</b>
				<br><br><p align="justify">Todos los contenidos de las pantallas relativas a los servicios de Mundo Maquinaria como as� tambi�n los programas, bases de datos, redes, archivos que permiten al Usuario acceder y usar su Cuenta, son de propiedad de Mundo Maquinaria y est�n protegidas por las leyes y los tratados internacionales de derecho de autor, marcas, patentes, modelos y dise�os industriales.
				<br><br><p align="justify">El uso indebido y la reproducci�n total o parcial de dichos contenidos quedan prohibidos.
				<br><br><p align="justify">El Sitio puede contener enlaces a otros sitios web lo cual no indica que sean propiedad u operados por Mundo Maquinaria. En virtud que Mundo Maquinaria no tiene control sobre tales sitios, NO ser� responsable por los contenidos, materiales, acciones y/o servicios prestados por los mismos, ni por da�os o p�rdidas ocasionadas por la utilizaci�n de los mismos, sean causadas directa o indirectamente. La presencia de enlaces a otros sitios web no implica una sociedad, relaci�n, aprobaci�n, respaldo de Mundo Maquinaria a dichos sitios y sus contenidos.
				<br><br><b>16. INDEMNIDAD.</b>
				<br><br><p align="justify">El Usuario se obliga a indemnizar todos los perjuicios y mantener indemne a Mundo Maquinaria, sus filiales, empresas controladas y/o controlantes, directivos, administradores, representantes y empleados, y en general a cualquier persona, natural o jur�dica, relacionada con ella, por cualquier suma a que fuere condenada a pagar por causa de alg�n reclamo, demanda, querella u otra actuaci�n ante cualquier entidad judicial que se interponga o deduzca en su contra que tuviere como causa o se relacione, directa o indirectamente, con un incumplimiento o inobservancia de los presentes TCG y dem�s pol�ticas que se entienden incorporadas a ellos, o por la violaci�n de cualesquiera leyes o derechos de terceros.
				<br><br><b>17. PUBLICIDAD.</b>
				<br><br><p align="justify">Mundo Maquinaria pone el Sitio a disposici�n tanto de Usuarios como de otros terceros, para que �stos publiquen fotograf�as, im�genes o logotipos con el objeto de promocionar y publicitar sus marcas o productos propios mediante el pago de una contraprestaci�n en dinero.
				<br><br><p align="justify">Se deja expresa constancia que Mundo Maquinaria no tendr� injerencia alguna en la determinaci�n de los contenidos ni las im�genes que se publiquen en virtud de lo anterior, y tendr� siempre el derecho a eliminar, en cualquier momento, todos aquellos contenidos que no cumplan con lo dispuesto en estos TCG, en los est�ndares acordados y dem�s pol�ticas de Mundo Maquinaria, como tambi�n todo aquello que vaya en contra del orden p�blico, la moral y/o las buenas costumbres.
				<br><br><b>18. PAGOS</b>
				<br><br><p align="justify">Los pagos que el Cliente deba hacer a Mundo Maquinaria SpA en raz�n a los planes que contrate, deber�n efectuarse dentro del plazo de vencimientos que se indica en la respectiva factura que se emita mensualmente al efecto. Los pagos deber�n realizarse obligatoriamente mediante cheque nominativo y cruzado a favor de Mundo Maquinaria Spa; directamente en las entidades bancarias descritas en la factura o cualquier otra instituci�n que Mundo Maquinaria SpA informar� oportunamente; o bajo la modalidad de cargo en cuenta corriente o tarjeta de cr�dito seg�n el mandato y las alternativas que se presenten.
				<br><br><p align="justify">En caso de no pago �ntegro y oportuno de cualquiera de las obligaciones asumidas por el Cliente en raz�n a los contratos de que da cuenta el presente instrumento, Mundo Maquinaria SpA podr� suspender el servicio de publicaciones, avisos u otros, que el Cliente haya contratado.
				<br><br><b>19. GESTI�N DE COBRANZA</b>
				<br><br><p align="justify">De conformidad a lo previsto en la ley N�19.628, sobre Protecci�n de Datos Personales y en la ley N� 19.496, sobre Protecci�n de los Derechos de los Consumidores, el Cliente autoriza desde ya y expresamente a Mundo Maquinaria para informar y hacer publicar en registros o bancos de datos personales, la circunstancia de encontrarse impago de una o m�s de las obligaciones que ha asumido en raz�n a los servicios contratados mediante la suscripci�n del presente instrumento y que den cuenta la o las facturas respectivas.

				</h5>
			</div>
		</div>

	</div>
	</form>
</div>
</div>
<!-- #include file="ModalHeaderMenu.asp" -->
<div class="modal fade" id="myModal8" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<form name="formLogin" method="post" >
	<div class="modal-dialog">

		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Qui�nes Somos</h4>
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
						<li><a data-toggle="modal" data-target="#myModal8">Qui�nes somos</a></li>
						<li><a data-toggle="modal" data-target="#myModal5">T�rminos de uso</a></li>
					</ul>
					<ul class="copyright">
						<li>&copy; Todos los derechos reservados.</li><li>Dise�ado por: <a href="http://gofour.cl">Go Four</a></li>
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
			mostrarMensaje('Estimado Usuario, Cotizaci�n agregada exitosamente', 'success');
		} else if (mensaje == 2) {
			mostrarMensaje('Estimado Usuario, Cotizaci�n eliminada exitosamente', 'success')
		} else if (mensaje == 3) {
			mostrarMensaje('Mensaje enviado exitosamente', 'success');
		} else if (mensaje == 4) {
			mostrarMensaje('Sus cotizaciones fueron enviadas a nuestros distintos proveedores. Favor espere a que el/ellos lo contacten', 'info');
		} else if (mensaje == 5) {
			mostrarMensaje('Estimado Usuario, el RUT ingresado ya es parte de nuestros registros', 'error');
		} else if (mensaje == 6) {
			mostrarMensaje('Estimado Usuario, error al iniciar sesi�n. Intente nuevamente.', 'error');
		} else if (mensaje == 7) {
			mostrarMensaje('Se envi� un correo con sus datos al mail registrado.', 'info');
		} else if (mensaje == 8) {
			var texto = $.getURLParam("txt");
			mostrarMensaje(texto, 'error');
		} else if (mensaje == 9) {
			mostrarMensaje('Cotizaci�n agregada exitosamente', 'success');
		} else if (mensaje == 10) {
			mostrarMensaje('Mensaje enviado exitosamente', 'success');
		} else if (mensaje == 11) {
			mostrarMensaje('Cotizaci�n eliminada exitosamente','success');
		} else if (mensaje == 12) {
			mostrarMensaje('Sus cotizaciones fueron enviadas a nuestros distintos proveedores. Favor espere a que el/ellos lo contacten', 'info');
		} else if (mensaje == 13) {
			mostrarMensaje('Bienvenido a Mundo Maquinaria. Su pago se realiz� con �xito, se envi� un email con sus datos de ingreso registrado', 'info');
		} else if (mensaje == 14) {
			mostrarMensaje('Estimado Usuario, su RUT es incorrecto.', 'error');
		} else if (mensaje == 15) {
			mostrarMensaje('Estimado Usuario, su contrase�a es incorrecta.', 'error');
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
			CampoObligatorio('textfield2', 'Raz�n Social/Nombre','popUpRS');
		});

		$('#textfield3').blur(function(){
			var textoCorreo = $('#textfield3').val()
			var resultado = CampoObligatorio('textfield3', 'Correo','popUpCorreo');
			if (resultado == false) {
				var expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			if ( !expr.test(textoCorreo) ){
					mensajePopUp('La direcci�n de correo "' + textoCorreo + '" es incorrecta','popUpCorreo');
				}
			}
		});

		$('#textfield4').blur(function(){
			CampoObligatorio('textfield4', 'Nombre Contacto','popUpContacto');
		});

		$('#textfield5').blur(function(){
			var resultado = CampoObligatorio('textfield5', 'Tel�fono Contacto','popUpTContacto');
			if (!resultado) { //resultado == false, campo contiene datos.
				var telefono = $('#textfield5').val();
				if (telefono.length != 9) {
					mensajePopUp('Estimado Usuario, El Tel�fono debe contener 9 d�gitos','popUpTContacto');
				} else if (!/^([0-9])*$/.test(telefono)) {
					mensajePopUp('Estimado Usuario, El valor no es un n�mero', 'popUpTContacto');
				}
			}
		});
	});

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

	// function validacion(formulario, pagina)
	// {
	// 	if(formulario.user_rut.value=="" || formulario.passw.value=="" )
	// 	{
	// 		mostrarMensaje('Para Continuar debe Completar los datos de Ingreso','error');
	// 		return false;
	// 	}
	// 	irA(formulario, pagina);
	// }



</script>

<script>
	//Agregado Funciones para lo nuevo  16.10.2017
	$(function(){

		console.log("hola mundo")
		$("#tipo").on("change",function(e){
			
			console.log("hola mundo")

			if($(this).val()=="18"){
				$("#bt_cotizar").text("BUSCAR");
				$("#bt_cotizar").removeAttr("data-toggle");

				$("#familia").val("0");
				$("#familia").attr("disabled","disabled")
				$("#subcatagory").attr("disabled","disabled")
				$("#subcatagory").html("");
				$("#subcatagory").append($("<option>").text("CIUDAD"));
			}else{
				$("#bt_cotizar").text("COTIZAR");
				$("#familia").removeAttr("disabled")
				$("#subcatagory").removeAttr("disabled")
				$("#bt_cotizar").attr("data-toggle","modal");
			}
		});


		$("#bt_cotizar").on("click",function(e){
			if($("#tipo").val()=="18"){
			    location.href="http://www.google.cl";	
			}
		})
	})
</script>



	</body>
</html>
