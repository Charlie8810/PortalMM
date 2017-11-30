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
<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="assets/css/mantenedores.css" />

<!-- Paginación GSC-->
<link rel="stylesheet" href="dataTable/jquery.dataTables.css">
<script src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="dataTable/jquery.dataTables.min.js"></script>
<script src="dataTable/table.js"></script>
<!-- Fin Paginación -->
</head>
<script type="text/javascript">
function validarDatos(formulario, pagina){
	var Nombre 			= document.getElementById('Nombre').value;
	
	if(Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)){
		mostrarMensaje('El campo Nombre no debe ir vacío', 'error');
		return false;
	}
	
		irA(formulario, pagina);
	
}
</script>

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
    if Estado_HTTP_REFERER = 0 then
        Response.Redirect("./index.asp")
        Response.End
    end if
else
    Response.Redirect("./index.asp")
    Response.End
end if
'************************** Fin HTTP_REFERER ******************************
%>
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
  <h1>Mantenedor de equipos</h1>
</div>
<%if request.QueryString("opc")= "sav" then 
	sql="exec MantenedorEquipos "
	sql=sql & " 2 , "
	sql=sql & " " & request.form("idEquipos") & ", "
	sql=sql & "'" & request.form("nombre") & "'," 
	sql=sql & " " & request.form("estado") & " "
	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Equipo Modificado Exitosamente.', 'success');
		window.location="mant_eq.asp?msg=1";
	</script>
	<%
end if
%>
<%if request.QueryString("opc")= "sav2" then 
	sql="exec MantenedorEquipos "
	sql=sql & " 5 ,'', "
	sql=sql & "'" & request.form("nombre") & "'," 
	sql=sql & " '' "
	
	set rs = nothing
	Set rs = cn.Execute(sql)
	if rs.eof then	
		
		sql="exec MantenedorEquipos "
		sql=sql & " 3 ,'', "
		sql=sql & "'" & request.form("nombre") & "'," 
		sql=sql & " " & request.form("estado") & " "
		
		set rs = nothing
		Set rs = cn.Execute(sql)
		%>
		<script type="text/javascript">
			//mostrarMensaje('Equipo Agregado Exitosamente.','success');
			window.location="mant_eq.asp?msg=2";
		</script>
		<%
	else
		%>
		<script type="text/javascript">
			//mostrarMensaje('Este equipo ya existe con este nombre.','error');
			window.location="mant_eq.asp?msg=3";
		</script>
		<%
	end if
end if
%>
<%if request.QueryString("opc")= "del" then 
	sql="exec MantenedorEquipos "
	sql=sql & " 4 , "
	sql=sql & " " & request.form("idEquipos") & ", "
	sql=sql & "'', ''" 
	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Equipo Eliminado Exitosamente.', 'success');
		window.location="mant_eq.asp?msg=4";
	</script>
<%
end if
%>
<%if request.QueryString("opc")= "idmaq" then 
	
	var_chk_sel=request.form("Equipo")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)
	Next 
	if i > 1 then
	%>
	<script type="text/javascript">
		//mostrarMensaje('Debe seleccionar solo un equipo.', 'success');
		window.location="mant_eq.asp?msg=5";
	</script>
<%	else
		if len(var_chk_sel) > 0 then
			Response.Redirect("mant_eq.asp?opc=edit&id="& var_chk_sel)
			Response.End
		end if
	end if
end if
%>
<div class="container-fluid">
  <hr>
  <div class="row-fluid">
    <div class="span12">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Mantenedor de equipos</h5>
        </div>
        <div class="widget-content nopadding">
          <form name="form1_crit" action="#" method="post" class="form-horizontal">
              <div class="control-group">
				<label class="control-label" style=position:absolute;>Equipos :</label>
				<div class="controls">
					<%
					sql="exec MantenedorEquipos "
					sql=sql & " 1 , -1 , '' , 0"
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					%>
					<select name="vEquipos" class="span11" style="color:#F7931E" value="<%=vEquipos%>">
						<%
						response.write "<option value=-1>SELECCIONE EQUIPO</option>"
						if not rs.eof then
							do while not rs.eof
								if cdbl(rs("Id_DatosComunes")) = cdbl(vEquipos) then
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
			</div>
			<div class="control-group">

            <div class="form-actions">
              <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'mant_eq.asp?opc=sch');">Buscar</button>
			  <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'mant_eq.asp?opc=new');">Nuevo</button>
            </div>
			<br>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<%if request.QueryString("opc")="sch" then %>
   <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon border-blue"><i class="icon-th"></i></span>
            <h5>Listado de Equipos</h5>
          </div>
		  
		  <div class="widget-content nopadding">
		  <form name="form2_crit" action="#" method="post" class="form-horizontal">
            <table id="tabla" class="table table-bordered table-striped with-check">
              <thead>
                <tr>
				  <th>Opcion</th>
                  <th>Nombre</th>
                  <th>Estado</th>
				  

                </tr>
              </thead>
              <tbody>
			  <%
				
					sql="exec MantenedorEquipos "
					sql=sql & " 1 , "
					sql=sql & " " & request.form("vEquipos") & ", "
					sql=sql & " '' , "
					sql=sql & " 0 "
			
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					if not rs.eof then
						do while not rs.eof
						
						vEquipos	 	= rs("Id_DatosComunes")
						vNombre			= rs("Descripcion")
						vEstado			= rs("estado")
						
						%>			
						
						<tr class="gradeX">
						  <td><input type="checkbox" name="Equipo" id="Equipo" style="display: block !important;" value=<%=vEquipos%> /></td>
						  <th><%=vNombre%></th>
						  <th>
						  <% if vEstado = 1 then
						  %>
						  Activado
						  <%else%>
						  Desactivado
						  <%end if%></th>
						</tr>
						<%
						response.write(vSeleccion)
						%>
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
            <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'mant_eq.asp?opc=idmaq');">Editar</button>
			<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'mant_eq.asp?opc=new');">Nuevo</button>
			<input name="bandera" type="hidden" id="bandera" value="1" />
		</div>
		
      </div>
    </div>
  </div>
  <%end if%>
  <%if request.QueryString("opc")="edit" then 
  
		sql="exec MantenedorEquipos "
		sql=sql & " 1 , "
		sql=sql & " " & request.QueryString("id") & ", "
		sql=sql & " '' , "
		sql=sql & " 0 "
		set rs = nothing
		Set rs = cn.Execute(sql)
		if not rs.eof then
		
		vEquipos	 	= rs("Id_DatosComunes")
		vNombre			= rs("Descripcion")
		vEstado			= rs("estado")

  %>
  
  
	<div class="container-fluid">
   <div class="row-fluid">
    <div class="span9">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Equipos</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit" method="post" class="form-horizontal">
            <div class="control-group">

			  <label class="control-label" style=position:absolute;>Nombre :</label>
              <div class="controls">
                <input type="text" class="span11" name="Nombre" id="Nombre" value="<%=vNombre%>"/>
				<input type="hidden" name="idEquipos" value="<%=vEquipos%>"/>
			  </div><br><br>




              <label class="control-label" style=position:absolute;>Estado :</label>
              <div class="controls">
			    <select name="estado" class="span11" value="<%=vEstado%>">
					<option value="1">Activado</option>
					<option value="0">Desactivado</option>
				</select>
              </div>
			  <br>
			</div>
        <div class="control-group">
		<br>
  		<div class="form-actions">
				<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'mant_eq.asp?opc=sav');">Guardar</button>
				<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form3_crit,'mant_eq.asp?opc=del');">Eliminar</button>
           </div>
		   <br>
          </form>
        </div>
      </div>
      
    </div>
	<%
	end if
	%>
  </div>
  
</div>
  <%end if%>
  <%if request.QueryString("opc")="new" then%>
	<div class="container-fluid">
   <div class="row-fluid">
    <div class="span9">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Equipos</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit" method="post" class="form-horizontal">
            <div class="control-group">

			  <label class="control-label" style=position:absolute;>Nombre :</label>
              <div class="controls">
                <input type="text" class="span11" name="Nombre" id="Nombre"/>
			</div><br><br>





              <label class="control-label" style=position:absolute;>Estado :</label>
              <div class="controls">
			    <select name="estado" class="span11">
					<option value="1">Activado</option>
					<option value="0">Desactivado</option>
				</select>
              </div>
			  <br>
			</div>
			<div class="control-group">
			<br>
			<div class="form-actions">
				<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'mant_eq.asp?opc=sav2');">Guardar</button>
           </div>
		   <br>
          </form>
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
	$('.textarea_editor').wysihtml5();
</script>
<script type="text/javascript">
	$(document).ready(function(){
		var mensaje = $.getURLParam("msg");
		if (mensaje != null) {
			if (mensaje == 1) {
				mostrarMensaje('Equipo Modificado Exitosamente.', 'success');
			} else if (mensaje == 2) {
				mostrarMensaje('Equipo Agregado Exitosamente.', 'success');
			} else if (mensaje == 3) {
				mostrarMensaje('Este equipo ya existe con este nombre.', 'error');
			} else if (mensaje == 4) {
				mostrarMensaje('Equipo Eliminado Exitosamente.', 'success');
			} else if (mensaje == 5) {
				mostrarMensaje('Debe seleccionar solo un equipo.', 'success');
			}
		}
	});
</script>
</body>
</html>
