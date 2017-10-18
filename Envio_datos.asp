<!--#include file="con_app.asp"-->
<%
Const cdoSendUsingPort = 2
iServer = "smtp.gmail.com"
	correo = request.form("textcorreo")

    sql = "Exec sp_get_usuario_clave"
	sql = sql & "'" & correo & "'"

	Set Rs = nothing
    Set Rs = cn.Execute ( sql )
	
	Mensajexxx = ""
    if not rs.eof then
        id_usuario      = Rs("id_usuario")
		nombre			= Rs("nombre")
		rut         	= Rs("rut")
		mail        	= Rs("mail")
		password        = Rs("pass")
	    
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
			MailObject.Subject = "Mundo Maquinaria - Recuperacion de datos de ingreso"
			Cuerpo = "<br><br><h3 style=color:#3B5998>Estimado(a) Cliente " & nombre & " de Mundo Maquinaria, <br>&nbsp;&nbsp;&nbsp;&nbsp;</h3><h3 style=color:#3B5998>Se ha enviado un mail con los siguientes datos:</h3>"
			Cuerpo = Cuerpo & " <br><br><h4 style=color:#F7931E><strong> User: " & rut & "</strong><br>"
			Cuerpo = Cuerpo & "<strong> Pass: " & password & "</strong></h4><br>"
			Cuerpo = Cuerpo & "<br>"
			Cuerpo = Cuerpo & "<h3 style=color:#3B5998>Atentamente,<br>"
			Cuerpo = Cuerpo & "Equipo Mundo Maquinaria</h3>"
			Cuerpo = Cuerpo & "<br><br><img src= http://www.mundomaquinaria.cl/marchablanca/images/logo2.png>"
			
			MailObject.HTMLBody = Cuerpo
			MailObject.Send
			Set MailObject = Nothing
			Set cdoConfig = Nothing
		
		%>
		<script type="text/javascript">
			window.location="index.asp?msg=16";
		</script>
		<%
    else 
        
        Mensajexxx = "El correo no corresponde a ningún cliente."
        
    End if
    
    Rs.Close
    Set Rs = Nothing
    
    %>
		<script type="text/javascript">
			alert("<%=Mensajexxx%>");
			window.location="index.asp";
		</script>
		<%
	
%>
