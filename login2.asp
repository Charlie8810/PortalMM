<!--#include file="con_app.asp"-->
<%


session("estado")               = ""
session("cod_usuario")          = ""
session("id_usuario")			= ""
session("nom_usuario")          = ""
session("correo")               = ""
session("cargo")				= ""

session("Perfil_Admin")         = ""
			
session("Identificador")        = ""
		
if request.QueryString("opc")="in" then
	Session.Timeout = 60
	
	iduser = request.Form("user_rut") 
	pass = request.Form("passw")
        iduser = Replace(iduser, ".", "")
        ''Response.Write("iduser: " + iduser + ", pass: " + pass)
	
  if(instr(iduser,"'")>0 or instr(iduser,"=")>0 or instr(iduser,",")>0) then
  	 response.Redirect("./index.asp?msg=14")
	 response.End 
	 
  elseif (instr(pass,"'")>0 or instr(pass,"=")>0 or instr(pass,",")>0) then
	response.Redirect("./index.asp?msg=15")
	 response.End 
  end if

	sql="Exec sp_get_usuario "
	sql=sql & "'" & iduser & "', "
	sql=sql & "'" & request.Form("passw") & "' "

	set rs2 = nothing
	Set rs2 = cn.Execute(sql)
    
	if not rs2.eof then
	    
	    session("rut")  = ucase(rs2("rut"))
		session("id_usuario")   = rs2("id_usuario")
		session("nombre")  = ucase(rs2("nombre"))
		session("mail") = ucase(rs2("mail"))
        session("Perfil_Administrador") = rs2("perfil_admin")

		session("estado")               = "ok"
		
        '**************************************************************************
        '*************************** Inicia Sesion ********************************
        sql="Exec Crear_Sesion" 
        set RsSession = nothing
        Set RsSession = cn.Execute(sql)
        session("Identificador") = RsSession("Identificador")

        sql="Exec Agregar_Sesion " & session("id_usuario") & ",'" & session("Identificador") & "'" 
        cn.Execute(sql)

        sql="Exec Traer_Sesion '" & session("Identificador") & "'"
	
        set RsSession = nothing
        Set RsSession = cn.Execute(sql)
        Sesion = RsSession("Sesion2")
        if len(Sesion) = 0 then
            response.Redirect("index.asp?msg=6")
            Response.End
        end if

        RsSession.close
        set RsSession = nothing
        '***************************  Fin Sesion   ********************************
        '**************************************************************************

		response.Redirect("mant.asp")
		
	else
	    
        
		response.Redirect("index.asp?msg=6")
		response.End 
	end if
	
else
            
	response.Redirect("index.asp")
	response.End 
end if
%>
