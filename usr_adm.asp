<!--#include file="con_app.asp"-->

<html>
<head>
<link rel="icon" type="image/png" href="./images/icon.ico" />
<title>Mundo Maquinaria</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="assets/css/uniform.css" />
<link rel="stylesheet" href="assets/css/select2.css" />
<link rel="stylesheet" href="assets/css/matrix-style.css" />
<link rel="stylesheet" href="assets/css/matrix-media.css" />
<link rel="stylesheet" href="assets/css/mantenedores.css" />
<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
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
    Response.Redirect("./index.asp")
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
	var TelefonoContacto = document.getElementById('TelefonoContacto').value;
	var CargoContacto 	= document.getElementById('CargoContacto').value;
	var MailCotizacion	= document.getElementById('MailCotizacion').value;

	if(Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)){
		mostrarMensaje('El campo Nombre no debe ser vacío', 'error');
		return false;
	}
	if(Rut == null || Rut.length == 0 || /^\s+$/.test(Rut)){
		mostrarMensaje('El Rut no debe ser vacío', 'error');
		return false;
	}
	if(DV == null || DV.length == 0 || /^\s+$/.test(DV)){
		mostrarMensaje('El DV no debe ser vacío', 'error');
		return false;
	}
	if(Direccion == null || Direccion.length == 0 || /^\s+$/.test(Direccion)){
		mostrarMensaje('La Direccion no debe ser vacío', 'error');
		return false;
	}
	if(Rubro == null || Rubro.length == 0 || /^\s+$/.test(Rubro)){
		mostrarMensaje('El Rubro no debe ser vacío', 'error');
		return false;
	}
	if(NomContacto == null || NomContacto.length == 0 || /^\s+$/.test(NomContacto)){
		mostrarMensaje('El Nombre de contacto no debe ser vacío', 'error');
		return false;
	}
	if(MailContacto == null || MailContacto.length == 0 || /^\s+$/.test(MailContacto)){
		mostrarMensaje('El Mail de Contacto no debe ser vacío', 'error');
		return false;
	}
	expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if ( !expr.test(MailContacto) ){
        mostrarMensaje('La dirección de correo "' + MailContacto + '" es incorrecta', 'error');
		return false;
		}
	if(TelefonoContacto == null || TelefonoContacto.length == 0 || /^\s+$/.test(TelefonoContacto)){
		mostrarMensaje('El Teléfono de Contacto no ser vacío', 'error');
		return false;
	}
	if (!/^([0-9])*$/.test(TelefonoContacto)){
      mostrarMensaje('El valor "' + TelefonoContacto + '" no es un número', 'error');
	  return false;
	}
	/*	var expresionRegular1=/^([0-9]+){9}$/;
	if (!expresionRegular1.test(TelefonoContacto.value)) {
		mostrarMensaje('Escribe un mínimo de 9 dígitos como teléfono','error');
		return (false)
	}*/
	if(CargoContacto == null || CargoContacto.length == 0 || /^\s+$/.test(CargoContacto)){
		mostrarMensaje('El Cargo de Contacto no debe ser vacío', 'error');
		return false;
	}
	if(MailCotizacion == null || MailCotizacion.length == 0 || /^\s+$/.test(MailCotizacion)){
		mostrarMensaje('El Mail de Cotización no debe ser vacío', 'error');
		return false;
	}
    if ( !expr.test(MailCotizacion) ){
        mostrarMensaje('La dirección de correo "' + MailCotizacion + '" es incorrecta', 'error');
		return false;
		}

	irA(formulario, pagina);

}
</script>

<body>

<!--Header-part-->
<div id="header">
</div>
<!--#include file="./menu.asp"-->
<div id="content">
<div id="content-header">
  <div id="messageDiv" class="col-md-12" style="display: none;">
		<button type="button" class="close" data-dismiss="modal" onClick="ocultarMessage()" aria-hidden="true">×</button>
		<br />
		<p>message</p>
	</div>
  <div id="breadcrumb"> <a href="index.asp" title="Go to Home" class="tip-bottom" style="color:#666666"><i class="icon-home"></i> Inicio</a></div>
  <h1>Mantenedor de Usuarios Administradores</h1>
</div>
<%if request.QueryString("opc")= "sav" then

	sql="exec MantenedorUsuarios "
  sql=sql & " 2 , "
  sql=sql & " " & request.QueryString("vIdUsuario") & ", "
  sql=sql & " '" & request.form("rut") & "', "
  sql=sql & " '" & request.form("nombre") & "', "
  sql=sql & " '" & request.form("mail") & "', "
  sql=sql & " '', '',"
  sql=sql & " '" & request.form("direccion") & "', "
  sql=sql & " '" & request.form("vEstado") & "', "
  sql=sql & " ''"
	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Datos Modificados Exitosamente', 'success');
		window.location="usr_adm.asp?msg=1";
	</script>
	<%
end if
if request.QueryString("opc")= "new2" then

	  sql="exec MantenedorUsuarios "
	  sql=sql & " 3 , "
	  sql=sql & " '', "
	  sql=sql & " '" & request.form("rut2") & "' ,"
	  sql=sql & " '" & request.form("nombre") & "' ,"
	  sql=sql & " '" & request.form("mail") & "' ,"
	  sql=sql & " '" & session("id_usuario") & "' ,"
	  sql=sql & " '" & request.form("pass2") & "' ,"
	  sql=sql & " '' ,"
	  sql=sql & " '" & request.form("vEstado") & "' ,"
	  sql=sql & " 1"

	  set rs = nothing
	  Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Usuario Agregado Exitosamente', 'success');
		window.location="usr_adm.asp?msg=2";
	</script>
	<%
end if


if request.QueryString("opc")= "del" then

	sql="exec MantenedorUsuarios "
  sql=sql & " 4 , "
  sql=sql & " " & request.QueryString("vIdUsuario") & ", "
  sql=sql & " '', '', '', '', '', '', '', ''"

	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Usuario Eliminado Exitosamente', 'success');
		window.location="usr_adm.asp?msg=3";
	</script>
	<%
end if

if request.QueryString("opc")= "idmaq" then

	var_chk_sel=request.form("Cliente")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)

	Next
	if len(var_chk_sel) > 0 then
            Response.Redirect("usr_adm.asp?opc=edit&id="& var_chk_sel)
            Response.End
    end if
end if

%>
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon border-blue"><i class="icon-th"></i></span>
            <h5>Listado de Usuarios</h5>
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

					sql="exec MantenedorUsuarios "
					sql=sql & " 1 , -1 , '' , '', '', '', '', '', -1, -1"

					set rs = nothing
					Set rs = cn.Execute(sql)


					if not rs.eof then
						do while not rs.eof

						vCliUsr			= rs("id_usuario")
						vNombre			= rs("nombre")
						vRut			= rs("rut")
						vMail			= rs("mail")
						vEstado			= rs("estado")
						vDesEstado		= rs("desc_estado")

						%>

						<tr class="gradeX">
						  <td><input type="checkbox" name="Cliente" id="Cliente" style="display: block !important;" value=<%=vCliUsr%>  /></td>
						  <th><%=vNombre%></th>
						  <th><%=vRut%></th>
						  <th><%=vMail%></th>
						  <th><%=vDesEstado%></th>
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
            <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'usr_adm.asp?opc=idmaq');">Editar</button>
			<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'usr_adm.asp?opc=new');">Nuevo</button>
			<input name="bandera" type="hidden" id="bandera" value="1" />
		</div>

      </div>
    </div>
  </div>
  <%if request.QueryString("opc")="edit" then

  sql="exec MantenedorUsuarios "
  sql=sql & " 1 , "
  sql=sql & " " & request.QueryString("id") & ", "
  sql=sql & " '' , '', '', '', '', '', -1, -1"

  set rs = nothing
Set rs = cn.Execute(sql)

if not rs.eof then
	vIdUsuario  = rs("id_usuario")
	vNombre		= rs("nombre")
	vRut  		= rs("rut")
	vMail  		= rs("mail")
	vDireccion	= rs("direccion")
	vFecCrea	= rs("feccrea")
	vEstado		= rs("estado")
	vDesc_estado = rs("desc_estado")
%>
<div class="container-fluid">
  <hr>
  <div class="row-fluid">
       <div class="widget-content nopadding">
             <div class="container-fluid">
   <div class="row-fluid">
    <div class="span9">
      <div class="widget-box" id="boxDatos">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Actualiza sus datos</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit" method="post" class="form-horizontal">
			<div class="control-group" >

			  	<label class="control-label" style=position:absolute;>Nombre :</label>
              	<div class="controls">
					<input type="text" class="span11" name="Nombre" id="Nombre" value="<%=vNombre%>"/>
					<input type="hidden" class="span11" name="IdCliente" value="<%=vIdUsuario%>"/>
			 	</div><br><br>
            



                <label class="control-label" style=position:absolute;>Rut :</label>
                <div class="controls">
                	<input type="text" class="span11" name="Rut" id="Rut" value="<%=vRut%>"/>
			  	</div><br><br>
            	



			    <label class="control-label" style=position:absolute;>Direccion :</label>
              	<div class="controls">
                	<input type="text" class="span11" name="Direccion" id="Direccion" value="<%=vDireccion%>"/>
			    </div><br><br>
            	



			    <label class="control-label" style=position:absolute;>Mail :</label>
              	<div class="controls">
                	<input type="text" class="span11" name="Mail" id="Mail" value="<%=vMail%>"/>
			  	</div><br><br>
            



			    <label class="control-label" style=position:absolute;>Estado Cliente :</label>

			  	<div class="controls">
					<%
					sql ="exec Seleccionar_Datos_Comunes "
					sql = sql & "5 "
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
				</div><br><br>

            </div>
			
			<div class="control-group" >
			<br>
			<div class="form-actions">
				<button type="button" id="btnGuardarE" class="btn btn-success" onClick="guardarUsuario('Rut', document.forms.form3_crit,'usr_adm.asp?opc=sav&vIdUsuario=<%=vIdUsuario%>')">Guardar</button>
				<button type="button" id="btnEliminarE" class="btn btn-success" onClick="irA(document.forms.form3_crit,'usr_adm.asp?opc=del&vIdUsuario=<%=vIdUsuario%>')">Eliminar</button>
			</div><br>
          </form>
        </div>
      </div>

    </div>
  </div>

</div>
        </div>
    </div>

</div>

<%end if%>
<%end if%>
<%if request.QueryString("opc")="new" then %>
<div class="container-fluid">
  <hr>
  <div class="row-fluid">
       <div class="widget-content nopadding">
             <div class="container-fluid">
   <div class="row-fluid">
    <div class="span9">
      <div class="widget-box" id="boxDatos">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Usuarios</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit" method="post" class="form-horizontal">
			<div class="control-group" >

			  	<label class="control-label" style=position:absolute;>Nombre :</label>
              	<div class="controls">
					<input type="text" class="span11" name="Nombre" id="Nombre"/>
					<input type="hidden" class="span11" name="IdCliente"/>
			  	</div><br><br>
            



                <label class="control-label" style=position:absolute;>Rut :</label>
              	<div class="controls">
                	<input type="text" class="span11" name="Rut2" id="Rut2"/>
			  	</div><br><br>
            
			    <label class="control-label" style=position:absolute;>Contraseña :</label>










              	<div class="controls">
                	<input type="password" class="span11" name="pass2" id="pass2"/>
			 	</div><br><br>











			  	<label class="control-label" style=position:absolute;>Repetir Contraseña :</label>
              	<div class="controls">
                	<input type="password" class="span11" name="pass2" id="pass2"/>
			  	</div><br><br>
            
			  	<label class="control-label" style=position:absolute;>Mail :</label>
              	<div class="controls">
                	<input type="text" class="span11" name="Mail" id="Mail"/>
			  	</div><br><br>
            
			  	<label class="control-label" style=position:absolute;>Estado Usuario :</label>
	         	<div class="controls">
					<%
					sql ="exec Seleccionar_Datos_Comunes "
					sql = sql & "5 "
					Set rs=nothing
					Set rs = cn.Execute(sql)
					%>
						<select name="vEstado" id="vEstado" class="span11" style="color:#F7931E">

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
				</div><br><br>

            </div>
			
			<div class="control-group" >
			<br>
			<div class="form-actions">
				<button type="button" id="btnGuardarC" class="btn btn-success" onClick="irA(document.forms.form3_crit,'usr_adm.asp?opc=new2')">Guardar</button>
			</div><br>
          </form>
        </div>
      </div>

    </div>
  </div>

</div>
        </div>
    </div>

</div>

  <%end if%>

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
</script>
<script type="text/javascript">
	$(document).ready(function(){
		var mensaje = $.getURLParam("msg");
		if (mensaje != null) {
			if (mensaje == 1) {
				mostrarMensaje('Datos Modificados Exitosamente', 'success');
			} else if (mensaje == 2) {
				mostrarMensaje('Usuario Agregado Exitosamente', 'success');
			} else if (mensaje == 3) {
				mostrarMensaje('Usuario Eliminado Exitosamente', 'success');
			}
		}
	});
  //var tipParam = $.getURLParam("opc");
  //if (tipParam != null) {
  //  goToByScroll("boxDatos");
  //}
  function guardarUsuario(rut, formulario, pagina) {
    if (checkRut(document.getElementById(rut))) {
      irA(formulario, pagina);
    }
    /*else {
	     goToByScroll('messageDiv');
    }*/
  }
</script>
</body>
</html>
