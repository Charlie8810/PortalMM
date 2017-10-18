<!--#include file="con_app.asp"-->

<html>
<head>
<%
Const cdoSendUsingPort = 2
iServer = "smtp.gmail.com"
		Response.CodePage = 65001
		Response.CharSet = "utf-8"
%>
<link rel="icon" type="image/png" href="./images/icon.ico" />
<title>Mundo Maquinaria</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="assets/css/uniform.css" />
<link rel="stylesheet" href="assets/css/select2.css" />
<link rel="stylesheet" href="assets/css/matrix-style.css" />
<link rel="stylesheet" href="assets/css/matrix-media.css" />
<link rel="stylesheet" href="assets/css/mantenedores.css" />
<!-- <link href="font-awesome/css/font-awesome.css" rel="stylesheet" /> -->
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
<script type="text/javascript">
function validarDatos(formulario, pagina){
	var Nombre 			= document.getElementById('Nombre').value;
	var Rut 			= document.getElementById('Rut').value;
	var DV 				= document.getElementById('dv').value;
	var Direccion		= document.getElementById('Direccion').value;
	var Rubro 			= document.getElementById('Rubro').value;
	var NomContacto		= document.getElementById('NomContacto').value;
	var MailContacto	= document.getElementById('MailContacto').value;
	var MailContacto2	= document.getElementById('MailContacto2').value;
	var TelefonoContacto = document.getElementById('TelefonoContacto').value;
	var CargoContacto 	= document.getElementById('CargoContacto').value;
	var MailCotizacion	= document.getElementById('MailCotizacion').value;
	var MailCotizacion2	= document.getElementById('MailCotizacion2').value;

	if(Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)){
		//alert('ERROR: El campo Nombre no debe ir vacío');
		mostrarMensaje('El campo Nombre no debe ir vacío', 'error');
		return false;
	}
	if(Rut == null || Rut.length == 0 || /^\s+$/.test(Rut)){
		//alert('ERROR: El Rut no debe ir vacío');
		mostrarMensaje('El Rut no debe ir vacío', 'error');
		return false;
	}
	if(DV == null || DV.length == 0 || /^\s+$/.test(DV)){
		//alert('ERROR: El DV no debe ir vacío');
		mostrarMensaje('El DV no debe ir vacío', 'error');
		return false;
	}
	if(Direccion == null || Direccion.length == 0 || /^\s+$/.test(Direccion)){
		//alert('ERROR: La Direccion no debe estar en blanco');
		mostrarMensaje('La Direccion no debe estar en blanco', 'error');
		return false;
	}
	if(Rubro == null || Rubro.length == 0 || /^\s+$/.test(Rubro)){
		//alert('ERROR: El Rubro no debe estar en blanco');
		mostrarMensaje('El Rubro no debe estar en blanco', 'error');
		return false;
	}
	if(NomContacto == null || NomContacto.length == 0 || /^\s+$/.test(NomContacto)){
		//alert('ERROR: El Nombre de contacto no debe estar en blanco');
		mostrarMensaje('El Nombre de contacto no debe estar en blanco', 'error');
		return false;
	}
	if(MailContacto == null || MailContacto.length == 0 || /^\s+$/.test(MailContacto)){
		//alert('ERROR: El Mail de Contacto no debe estar en blanco');
		mostrarMensaje('El Mail de Contacto no debe estar en blanco', 'error');
		return false;
	}
	expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if ( !expr.test(MailContacto) ){
       // alert("Error: La dirección de correo " + MailContacto + " es incorrecta.");
	   mostrarMensaje('La dirección de correo ' + MailContacto + ' es incorrecta.', 'error');
		return false;
		}
	if(MailContacto != MailContacto2 ){
		mostrarMensaje('Las direcciones de correo ' + MailContacto + ' y ' + MailContacto2 + ' no son iguales.', 'error');
		document.form1_crit.Pass1.focus()
		return false;
	}
	
	if(TelefonoContacto == null || TelefonoContacto.length == 0 || /^\s+$/.test(TelefonoContacto)){
		//alert('ERROR: El Telefono de Contacto no debe estar en blanco');
		mostrarMensaje('El Telefono de Contacto no debe estar en blanco', 'error');
		return false;
	}
	if (!/^([0-9])*$/.test(TelefonoContacto)){
      //alert("El valor " + TelefonoContacto + " no es un número");
	  mostrarMensaje('El valor ' + TelefonoContacto + ' no es un número', 'error');
	  return false;
	}
	/*	var expresionRegular1=/^([0-9]+){9}$/;
	if (!expresionRegular1.test(TelefonoContacto.value)) {
		alert("Escribe un mínimo de 9 digitos como teléfono");
		return (false);
	}*/
	if(CargoContacto == null || CargoContacto.length == 0 || /^\s+$/.test(CargoContacto)){
		//alert('ERROR: El Cargo de Contacto no debe estar en blanco');
		mostrarMensaje('El Cargo de Contacto no debe estar en blanco', 'error');
		return false;
	}
	if(MailCotizacion == null || MailCotizacion.length == 0 || /^\s+$/.test(MailCotizacion)){
		//alert('ERROR: El Mail de Cotizacion no debe estar en blanco');
		mostrarMensaje('El Mail de Cotizacion no debe estar en blanco', 'error');
		return false;
	}
    if ( !expr.test(MailCotizacion) ){
		mostrarMensaje('La dirección de correo ' + MailCotizacion + ' es incorrecta.', 'error');
		return false;
		}
	if(MailCotizacion != MailCotizacion2 ){
		mostrarMensaje('Las direcciones de correo ' + MailCotizacion + ' y ' + MailCotizacion2 + ' no son iguales.', 'error');
		document.form1_crit.Pass1.focus()
		return false;
	}
		
	irA(formulario, pagina);
	
}
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
<body>
  <div id="messageDiv" class="" style="display: none;">
    <button type="button" class="close" data-dismiss="modal" onclick="ocultarMessage()" aria-hidden="true">×</button>
    <br />
    <p>message</p>
  </div>

<!--Header-part-->
<div id="header">
</div>
<!--#include file="./menu.asp"-->
<div id="content">
<div id="content-header">
  <div id="breadcrumb"> <a href="index.asp" title="Go to Home" class="tip-bottom" style="color:#666666"><i class="icon-home"></i> Inicio</a></div>
  <h1>Mantenedor de Clientes - Actualiza tus datos</h1>
</div>
<%if request.QueryString("opc")= "sav" then 
	
	sql="exec ActualizaCliente "
	sql=sql & " " & request.form("Idcliente") & ","
	sql=sql & "'" & request.form("nombre") & "', "
	sql=sql & "" & request.form("rut") & ", "
	sql=sql & "'" & request.form("dv") & "', "
	sql=sql & " " & request.form("vEstado") & ", " 
	sql=sql & "'" & request.form("direccion") & "', "
	sql=sql & "'" & request.form("rubro") & "'," 
	sql=sql & "'" & request.form("NomContacto") & "'," 
	sql=sql & "'" & request.form("mailcontacto") & "'," 
	sql=sql & "" & request.form("telefonocontacto") & "," 
	sql=sql & "'" & request.form("cargocontacto") & "'," 
	sql=sql & "'" & request.form("mailcotizacion") & "'," 
	sql=sql & "'" & request.form("familia") & "'," 
	sql=sql & "'" & request.form("subcatagory") & "'" 

	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//alert("Datos Modificados Exitosamente.");
		//window.location="act_dat.asp";
		window.location="act_dat.asp?msg=1";
	</script>
	<%
end if

if request.QueryString("opc")= "sav2" then 
	
	sql="exec ActualizaCliente_PASS "
	sql=sql & " " & request.QueryString("vIdUsuario") & ""

	set rs = nothing
	Set rs = cn.Execute(sql)
	
	vNombreCli  =  rs("nombreEmpresa")
	vMailCli	=  rs("mailcotizacion")
	vPassCli	=  rs("pass")
	vRutCli		=  rs("rut")
	
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
			MailObject.To	= vMailCli
			MailObject.Subject = "Envio de Datos de Acceso"
			Cuerpo = "<br><br>Estimado(a) Cliente " & vNombreCli & " de Mundo Maquinaria, <br>&nbsp;&nbsp;&nbsp;&nbsp;A sido activado por el administrador "
			Cuerpo = Cuerpo & "con los siguientes datos: <br><br> Nombre Usuario: " & vRutCli & "<br>Password: " & vPassCli & "<br> "
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
		//alert("Cliente Activado Exitosamente.");
		//window.location="act_dat.asp";
		window.location="act_dat.asp?msg=2";
	</script>
	<%
end if

if request.QueryString("opc")= "idmaq" then 
	
	var_chk_sel=request.form("Cliente")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)

	Next 
	if i > 1 then
	%>
	<script type="text/javascript">
		//alert("Debe seleccionar solo un cliente.");
		mostrarMensaje('Debe seleccionar solo un cliente.', 'error');
		//window.location="act_dat.asp";
		setTimeout(window.location="act_dat.asp";, 3000);
	</script>
<%	else
		if len(var_chk_sel) > 0 then
				Response.Redirect("act_dat.asp?opc=edit&id="& var_chk_sel)
				Response.End
		end if	
	end if
end if 

if request.QueryString("opc")= "eli" then 
	
	var_chk_sel=request.form("Cliente")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)

	Next 
	sql ="exec Elimina_Cliente "
	sql=sql & " '" & var_chk_sel & "' "	

	Set rs=nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		window.location="act_dat.asp?msg=3";
	</script>
<%	
end if

if session ("Perfil_Administrador") = 1 then
%>
<div class="widget-content nopadding">
          <form name="form1_crit" action="#" method="post" class="form-horizontal">
              <div class="control-group">
				<label class="control-label">Nombre Cliente :</label>
				<div class="controls">
					<input class="span11" type="text" name="nombre_cli" />
				</div>
				<label class="control-label">Rut Cliente :</label>
				<div class="controls">
					<input class="span11" type="text" name="rut_cli" />
				</div>
           
				<label class="control-label">Estado Cliente :</label>
				<div class="controls">
					<%
					sql ="exec Seleccionar_Datos_Comunes "
					sql = sql & "11 "
					Set rs=nothing
					Set rs = cn.Execute(sql)
					%>
					<select name="vEstado" id="vEstado" class="span11" style="color:#F7931E" value="<%=vEstado%>">
					<%
						response.write "<option value=-1>SELECCIONE ESTADO</option>"
						if not rs.eof then
							do while not rs.eof
								if cdbl(rs("Id_DatosComunes")) = cdbl(vEstado) then
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
            <div class="form-actions">
              <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'act_dat.asp?opc=sch');">Buscar</button>
			  <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'act_dat.asp?opc=new');">Nuevo</button>
			  <button type="submit" class="btn btn-success" onClick="irAFuera(document.forms.form1_crit,'act_dat.asp?opc=sch&exp=xls','_blank')">Exportar</button>
            </div>
          </form>
        </div>
	<%if request.QueryString("opc")="sch" then %>
   <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon border-blue"><i class="icon-th"></i></span>
            <h5>Listado de Clientes</h5>
          </div>
		  
		  <div class="widget-content nopadding">
		  <form name="form2_crit" action="#" method="post" class="form-horizontal">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
				  <th>Opcion</th>
                  <th>Nombre</th>
                  <th>Rut</th>
                  <th>Mail</th>
				  <th>Estado</th>
				  

                </tr>
              </thead>
              <tbody>
			  <%
				
					sql="exec ListarCliente "
					
					if request.form("rut_cli") <> "" then
						sql=sql & " " & request.form("rut_cli") & ", "
					else
						sql=sql & " -1 , "
					end if	
					sql=sql & " '" & request.form("nombre_cli") & "', "
					sql=sql & " " & request.form("vEstado") & " "       
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					if not rs.eof then
						do while not rs.eof
						
						vCliente	 	= rs("idCliente")
						vCliUsr			= rs("id_usuario")
						vNombre			= rs("nombreEmpresa")
						vRut			= rs("rutEmpresa")
						vDv				= rs("rutDvEmpresa")
						vMail			= rs("mailcotizacion")
						vEstado			= rs("vigencia")
						vDescEstado		= rs("desc_estado")
						vRegion			= rs("region")
						vCiudad			= rs("ciudad")
						%>			
						
						<tr class="gradeX">
						  <td><input type="checkbox" name="Cliente" id="Cliente" style="display: block !important;" value=<%=vCliUsr%>  /></td>
						  <th><%=vNombre%></th>
						  <th><%=vRut%>-<%=vDv%></th>
						  <th><%=vMail%></th>
						  <th><%=vDescEstado%></th>
						</tr>
						
						<%
						rs.movenext
						loop
					end if%>
              </tbody>
            </table>
			
			</form>
          </div>
        </div>
		<div class="form-actions">
            <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'act_dat.asp?opc=idmaq');">Editar</button>
			<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'act_dat.asp?opc=eli');">Eliminar</button>
			<input name="bandera" type="hidden" id="bandera" value="1" />
		</div>
      </div>
    </div>
  </div>
  <%end if%>
  <%if request.QueryString("opc")="edit" then 
  
  sql="exec ListarCiente_Id "
  sql=sql & " " & request.QueryString("id") & " "
   
set rs = nothing
Set rs = cn.Execute(sql)

if not rs.eof then
	vIdCliente	= rs("Idcliente")
	vIdUsuario  = rs("id_usuario")
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
	vEstado			= rs("vigencia")
	vRegion			= rs("region")
	vCiudad			= rs("ciudad")  
%>
<div class="container-fluid">
  <hr>
  <div class="row-fluid">
       <div class="widget-content nopadding">
             <div class="container-fluid">
   <div class="row-fluid">
    <div class="span9">
      
	  <div class="widget-box">
		<div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Actualiza tus datos</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit" method="post" class="form-horizontal">
			<div>
			  <label class="control-label">Razón Social :</label>
              <div class="controls">
                <input type="text" class="span11" name="Nombre" id="Nombre" value="<%=vNombre%>"/>
				<input type="hidden" class="span11" name="IdCliente" value="<%=vIdCliente%>"/>
				*Favor ingresar información FIDEDIGNA
			  </div>
            </div>
             <div>
			  <label class="control-label">Rut :</label>
              <div class="controls">
                <input type="text" class="span11" name="Rut" id="Rut" value="<%=vRut%>"/>-<input type="text" class="span1" name="dv" id="dv" value="<%=vDv%>" />
			  </div>
            </div>
			<div>
			  <label class="control-label">Dirección de Facturación :</label>
              <div class="controls">
                <input type="text" class="span11" name="Direccion" id="Direccion" value="<%=vDireccion%>"/>*Favor ingresar información FIDEDIGNA
			  </div>
            </div>
			<div>
			<label class="control-label">Región :</label>
			<%if vRegion = "" then%>
			<div class="controls">
				<select size="1" id="familia" class="span11" name="familia" onChange = "javascript:sublist(this.form, familia.value);" style="color:#3B5998; cursor: pointer;" value="<%=Ucase(vRegion)%>">
					<option selected value = "0">Región</option>
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
			<%else%>
				<div class="controls">
				<%
				sql ="exec Seleccionar_Datos_Comunes "
				sql = sql & "3 "
				Set rs=nothing
				Set rs = cn.Execute(sql)
				%>
				<select name="familia" id="familia" class="span11" style="color:#3B5998; cursor: pointer;" value="<%=vRegion%>">
					<%
					response.write "<option value=0>Región</option>"
					if not rs.eof then
						do while not rs.eof
							if rs("Id_DatosComunes") = vRegion then
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
			<%end if%>
			</div>
			<div>
			<label class="control-label">Ciudad :</label>
			<%if vCiudad = "" then%>
			<div class="controls">
				<SELECT id="subcatagory" name="subcatagory" class="span11" style="color:#3B5998; cursor: pointer;" value="<%=Ucase(vCiudad)%>">
					<Option selected value="0">Ciudad</option>
				</SELECT>
			</div>
			<%else%>
				<div class="controls">
				<%
				sql ="exec Seleccionar_Datos_Comunes "
				sql = sql & "4 "
				Set rs=nothing
				Set rs = cn.Execute(sql)
				%>
				<select name="subcatagory" id="subcatagory" class="span11" style="color:#3B5998; cursor: pointer;" value="<%=vCiudad%>">
					<%
					response.write "<option value=0>Región</option>"
					if not rs.eof then
						do while not rs.eof
							if cdbl(rs("Id_DatosComunes")) = cdbl(vCiudad) then
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
			<%end if%>
			</div>			
			<div>
			  <label class="control-label">Giro :</label>
              <div class="controls">
                <input type="text" class="span11" name="Rubro" id="Rubro" value="<%=vRubro%>"/>*Favor ingresar información FIDEDIGNA
			  </div>
            </div>
			<div>
			  <label class="control-label">Nombre Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="NomContacto" id="NomContacto" value="<%=vNomContacto%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Mail Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="MailContacto" id="MailContacto" value="<%=vMailContacto%>"/>
			  </div>
			  <label class="control-label">Reingresar Mail Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="MailContacto2" id="MailContacto2" value="<%=vMailContacto%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Telefono Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="TelefonoContacto" id="TelefonoContacto" value="<%=vTelefonoContacto%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Cargo Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="CargoContacto" id="CargoContacto" value="<%=vCargoContacto%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Mail Cotizacion :</label>
              <div class="controls">
                <input type="text" class="span11" name="MailCotizacion" id="MailCotizacion" value="<%=vMailCotizacion%>"/>
			  </div>
			  <label class="control-label">Reingresar Mail Cotizacion :</label>
              <div class="controls">
                <input type="text" class="span11" name="MailCotizacion2" id="MailCotizacion2" value="<%=vMailCotizacion%>"/>
			  </div>
            </div>			
			<div>
			  <label class="control-label">Estado Cliente :</label>
              
			  <div class="controls">
					<%
					sql ="exec Seleccionar_Datos_Comunes "
					sql = sql & "11 "

					Set rs=nothing
					Set rs = cn.Execute(sql)
					%>
						<select name="vEstado" id="vEstado" class="span11" style="color:#F7931E" value="<%=vEstado%>">
					
						<%
						response.write "<option value=0>SELECCIONE ESTADO</option>"
						if not rs.eof then
							do while not rs.eof
								if cdbl(rs("Id_DatosComunes")) = cdbl(vEstado) then
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
			<div class="form-actions">

			<!-- <%if session ("Perfil_Administrador") = 1 then%>
				<%if vEstado = 1344 then%>
					<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'act_dat.asp?opc=sav2&vIdUsuario=<%=vIdUsuario%>');">Guardar</button>
				<%else%>
					<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'act_dat.asp?opc=sav&vIdUsuario=<%=vIdUsuario%>');">Guardar</button>
				<%end if%>
			<%else%>
					<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'act_dat.asp?opc=sav');">Guardar</button>		
			<%end if%> -->
			<button type="button" class="btn btn-success"  data-toggle="modal" data-target="#modalDatosFidedignos">Guardar</button>		
			</div>
			
			<div class="modal fade" id="modalDatosFidedignos" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header" style="background: #3b5998; color: #CCC;">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Datos Fidedignos</h4>
						</div>
						<div class="modal-body align-left">
							<span>Favor afirmar que los datos ingresados son fidedignos</span>
						</div>
						<div class="modal-footer">
							<%if session ("Perfil_Administrador") = 1 then%>
							<%if vEstado = 1344 then%>
								<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'act_dat.asp?opc=sav2&vIdUsuario=<%=vIdUsuario%>');">Aceptar</button>
							<%else%>
								<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'act_dat.asp?opc=sav&vIdUsuario=<%=vIdUsuario%>');">Aceptar</button>
			<%end if%>
							<%else%>
								<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'act_dat.asp?opc=sav');">Aceptar</button>		
							<%end if%>
						</div>
					</div>
				</div>
			</div>
          </form>
		</div>
		*Datos ingresados deben corresponder a la realidad. Queda bajo su responsabilidad el correcto ingreso de la información debido a que estos serán utilizados para la facturación del servicio. El cliente debe mantener estos datos siempre actualizados.
      </div>

    </div>
  </div>
  
</div>
        </div>
    </div>

</div>

  <%end if%>
  <%end if%>
<%
else		
sql="exec ListarCiente_Id "
sql=sql & " " & session("id_usuario") & " "
response.write(sql)
set rs = nothing
Set rs = cn.Execute(sql)

if not rs.eof then
	vIdCliente	= rs("Idcliente")
	vIdUsuario	= rs("id_usuario")
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
	vEstado			= rs("vigencia")
	vRegion			= rs("region")
	vCiudad			= rs("ciudad")
	
response.write(vRegion)
response.write(sql)	
%>
<div class="container-fluid">
  <hr>
  <div class="row-fluid">
       <div class="widget-content nopadding">
             <div class="container-fluid">
   <div class="row-fluid">
    <div class="span9">

	 <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Actualiza tus datos</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit2" method="post" class="form-horizontal">
			<div>
			  <label class="control-label">Razón Social :</label>
              <div class="controls">
                <input type="text" class="span11" name="Nombre" id="Nombre" value="<%=vNombre%>"/>
				<input type="hidden" class="span11" name="IdCliente" value="<%=vIdCliente%>"/>*Favor ingresar información FIDEDIGNA
			  </div>
            </div>
             <div>
			  <label class="control-label">Rut :</label>
              <div class="controls">
                <input type="text" class="span11" name="Rut" id="Rut" value="<%=vRut%>" readonly />-<input type="text" class="span1" name="dv" id="dv" value="<%=vDv%>" readonly />
			  </div>
            </div>
			<div>
			  <label class="control-label">Dirección de Facturación :</label>
              <div class="controls">
                <input type="text" class="span11" name="Direccion" id="Direccion" value="<%=vDireccion%>"/>*Favor ingresar información FIDEDIGNA
			  </div>
            </div>
			<label class="control-label">Región :</label>
			<div class="controls">
			<%if vRegion = 0 or vRegion = "NULL" then%>
				<select size="1" id="familia" class="span11" name="familia" onChange = "javascript:sublist(this.form, familia.value);" style="color:#3B5998; height: 3em; cursor: pointer;" value="<%=Ucase(vRegion)%>">
					<option selected value = "0">Región</option>
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
			<%else%>
				<%
				sql ="exec Seleccionar_Datos_Comunes "
				sql = sql & "3 "
				Set rs=nothing
				Set rs = cn.Execute(sql)
				%>
				<select size="1" id="familia" class="span11" name="familia" onChange = "javascript:sublist(this.form, familia.value);" style="color:#3B5998; height: 3em; cursor: pointer;" value="<%=Ucase(vRegion)%>">
					<%
					if not rs.eof then
						do while not rs.eof
							if cdbl(rs("Id_DatosComunes")) = cdbl(vRegion) then
								response.write "<option selected value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
							else
								response.write "<option value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
							end if
							rs.movenext
						loop
					end if
					%>
				</select>
			<%end if%>
			</div>
			<label class="control-label">Ciudad :</label>
			<div class="controls">
			<%if vCiudad = 0 or vCiudad = "NULL" then%>
				<SELECT id="subcatagory" name="subcatagory" class="span11" style="color:#3B5998; height: 3em; cursor: pointer;" value="<%=Ucase(vCiudad)%>">
					<Option selected value="0">Ciudad</option>
				</SELECT>
			<%else%>
				<%
				sql ="exec Seleccionar_Datos_Comunes "
				sql = sql & "4 "
				Set rs=nothing
				Set rs = cn.Execute(sql)
				%>
				<SELECT id="subcatagory" name="subcatagory" class="span11" style="color:#3B5998; height: 3em; cursor: pointer;" value="<%=Ucase(vCiudad)%>">
					<%
					if not rs.eof then
						do while not rs.eof
							if cdbl(rs("Id_DatosComunes")) = cdbl(vCiudad) then
								response.write "<option selected value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
							else
								response.write "<option value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
							end if
							rs.movenext
						loop
					end if
					%>
				</select>
			<%end if%>
			</div>
			
			<div>
			  <label class="control-label">Giro :</label>
              <div class="controls">
                <input type="text" class="span11" name="Rubro" id="Rubro" value="<%=vRubro%>"/>*Favor ingresar información FIDEDIGNA
			  </div>
            </div>
			<div>
			  <label class="control-label">Nombre Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="NomContacto" id="NomContacto" value="<%=vNomContacto%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Mail Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="MailContacto" id="MailContacto" value="<%=vMailContacto%>"/>
			  </div>
			   <label class="control-label">Reingresar Mail Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="MailContacto2" id="MailContacto2" value="<%=vMailContacto%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Telefono Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="TelefonoContacto" id="TelefonoContacto" value="<%=vTelefonoContacto%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Cargo Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="CargoContacto" id="CargoContacto" value="<%=vCargoContacto%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Mail Cotizacion :</label>
              <div class="controls">
                <input type="text" class="span11" name="MailCotizacion" id="MailCotizacion" value="<%=vMailCotizacion%>"/>
			  </div>
			  <label class="control-label">Reingresar Mail Cotizacion :</label>
              <div class="controls">
                <input type="text" class="span11" name="MailCotizacion2" id="MailCotizacion2" value="<%=vMailCotizacion%>"/>
			  </div>
            </div>			
			<div>
			  <label class="control-label">Estado Cliente :</label>
              
			  <div class="controls">
					<%
					sql ="exec Seleccionar_Datos_Comunes "
					sql = sql & "11 "
					Set rs=nothing
					Set rs = cn.Execute(sql)
					%>
					<% if session ("Perfil_Administrador") = 1 then
					%>
						<select name="vEstado" id="vEstado" class="texto2" style="color:#F7931E" value="<%=vEstado%>">
					
						<%
						response.write "<option value=0>SELECCIONE ESTADO</option>"
						if not rs.eof then
							do while not rs.eof
								if cdbl(rs("Id_DatosComunes")) = cdbl(vEstado) then
									response.write "<option selected value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
								else
									response.write "<option value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
								end if
								rs.movenext
							loop
						end if
						%>
					</select>
				<%else
				%>
						<select name="vEstado" id="vEstado" class="texto2" style="color:#F7931E" value="<%=vEstado%>" readonly>
						<%if cdbl(rs("Id_DatosComunes")) = cdbl(vEstado) then
									response.write "<option selected value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
						end if%>
						</select>
					<%end if%>
				</div>
            </div>
			<div class="form-actions">
				<!-- <button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit2,'act_dat.asp?opc=sav');">Guardar</button> -->
				<button type="button" class="btn btn-success" data-toggle="modal" data-target="#modalDatosFidedignos2">Guardar</button>
			</div>
			<div class="modal fade" id="modalDatosFidedignos2" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header" style="background: #3b5998; color: #CCC;">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Datos Fidedignos</h4>
						</div>
						<div class="modal-body align-left">
							<span>Favor afirmar que los datos ingresados son fidedignos</span>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit2,'act_dat.asp?opc=sav');">Aceptar</button>
						</div>
					</div>
				</div>
			</div>
          </form>
        </div>
		*Datos ingresados deben corresponder a la realidad. Queda bajo su responsabilidad el correcto ingreso de la información debido a que estos serán utilizados para la facturación del servicio. El cliente debe mantener estos datos siempre actualizados.
      </div>
    </div>
  </div>
  
</div>
        </div>
    </div>

</div>
<%
end if
end if
%>
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


<script type="text/javascript">
  $(document).ready(function(){
		var mensaje = $.getURLParam("msg");
		if (mensaje != null) {
			if (mensaje == 1) {
				mostrarMensaje('Datos Modificados Exitosamente.', 'success');
			} else if (mensaje == 2) {
				mostrarMensaje('Cliente Activado Exitosamente.', 'success');
			} else if (mensaje == 3) {
				mostrarMensaje('Cliente Eliminado Exitosamente.', 'success');
			}
		}
	});
</script>
<style>
	#dv {
		width: 21px !important;
	}
</style>
</body>
</html>
