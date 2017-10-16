<!--#include file="con_app.asp"-->
<%
    valor = Request("rut")
   
    consulta = "select RazonSocial from [BaseUsuario_R] where Rut ='"&valor&"'"

	Set tablabase=nothing
	Set tablabase = cn.Execute(consulta)
	if tablabase.eof then
		response.write ""
	else
		response.Write tablabase("RazonSocial")
	 end if

%>
 