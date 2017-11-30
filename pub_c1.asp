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
  <h1>Mantenedor de Publicidad Cuadro 1</h1>
</div>
<%if request.QueryString("opc")= "sav" then 
	sql="exec MantenedorPublicidad "
	if request.form("estado") = 1 then
		sql=sql & " 2,"
	else		
		sql=sql & " 6,"
	end if
	sql=sql & " " & request.queryString("id") & ", "
	sql=sql & " '" & request.form("foto1") & "', "
	sql=sql & " '" & request.form("Estado") & "' , "
	sql=sql & " 1 , "
	sql=sql & "'" & request.form("nombre") & "'," 
	sql=sql & " 1232," 
	sql=sql & "'" & request.form("periodicidad") & "',"
	sql=sql & "'" & request.form("url") & "'"
	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//alert("Publicidad Modificada Exitosamente.");
		window.location="pub_c1.asp?msg=1";
	</script>
	<%
end if
if request.QueryString("opc")= "sav2" then 
	sql="exec MantenedorPublicidad "
	sql=sql & " 3,"
	sql=sql & " -1, "
	sql=sql & " '" & request.form("foto1") & "', "
	sql=sql & " " & request.form("Estado") & " , "
	sql=sql & " 1 , "
	sql=sql & "'" & request.form("nombre") & "',"
	sql=sql & " 1232," 
	sql=sql & "'" & request.form("periodicidad") & "',"
	sql=sql & "'" & request.form("url") & "'"

	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//alert("Publicidad Modificada Exitosamente.");
		window.location="pub_c1.asp?msg=1";
	</script>
	<%
end if
%>
<%if request.QueryString("opc")= "idmaq" then 
	
	var_chk_sel=request.form("Publicidad")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)
	Next

	sql ="exec EliminaPublicidad "
	sql=sql & " '" & var_chk_sel & "' "	

	Set rs=nothing
	Set rs = cn.Execute(sql)
	
	%>
	<script type="text/javascript">
		//mostrarMensaje('Los Equipos se eliminaron existosamente', 'error');
		window.location="pub_c1.asp?msg=4";
	</script>
<%	end if
if request.QueryString("opc")= "idmaq2" then 
	
	var_chk_sel=request.form("Publicidad")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)

	Next 
	if i > 1 then
	%>
	<script type="text/javascript">
		mostrarMensaje('Debe seleccionar solo una publicidad.', 'error');
	</script>
<%	else
		if len(var_chk_sel) > 0 then
			Response.Redirect("pub_c1.asp?opc=edit&id="& var_chk_sel)
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
          <h5>Mantenedor de Publicidad Principal</h5>
        </div>
        <div class="widget-content nopadding">
          <form name="form1_crit" action="#" method="post" class="form-horizontal">
              <div class="control-group">
				<label class="control-label" style=position:absolute;>Publicidad :</label>
				<div class="controls">
					<%
					sql="exec MantenedorPublicidad "
					sql=sql & " 1 , -1 , '' , 0 , 0, '', 1232,'',''"
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					%>
					<select name="vPublicidad" class="span11" style="color:#F7931E" value="<%=vPublicidad%>">
						<%
						response.write "<option value=-1>SELECCIONE PUBLICIDAD</option>"
						if not rs.eof then
							do while not rs.eof
								if cdbl(rs("Id_Publicidad")) = cdbl(vPublicidad) then
									response.write "<option selected value=" & rs("Id_Publicidad") & ">" & ucase(rs("Nombre")) & "</option>"
								else
									response.write "<option value=" & rs("Id_Publicidad") & ">" & ucase(rs("Nombre")) & "</option>"
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
              <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'pub_c1.asp?opc=sch');">Buscar</button>
			  <!--<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'pub_c1.asp?opc=new');">Nuevo</button>-->
			  <!--<label class="control-label">--><a href="upload/upload.asp" class="btn btn-success" target="_blank" onClick="window.open(this.href, this.target, 'width=600,height=400'); return false;">Nuevo</a><!--</label>-->
            </div>
          </form>
        </div>
		<br>
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
            <h5>Listado de Publicidad</h5>
          </div>
		  
		  <div class="widget-content nopadding">
		  <form name="form2_crit" action="#" method="post" class="form-horizontal">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
				  <th>Opcion</th>
                  <th>Nombre</th>
                  <th>Imagen</th>
                  <th>Fecha Carga</th>
				  <th>Fecha Eliminacion</th>
				  <th>Periodicidad</th>
				  <th>Url</th>
				  <th>Estado</th>
				  

                </tr>
              </thead>
              <tbody>
			  <%
				
					sql="exec MantenedorPublicidad "
					sql=sql & " 9 , "
					sql=sql & " " & request.form("vPublicidad") & ", "
					sql=sql & " '' , "
					sql=sql & " 0 , "
					sql=sql & " 0 , '', 1232,'' ,''"                 

					set rs = nothing
					Set rs = cn.Execute(sql)
					
					if not rs.eof then
						do while not rs.eof
						
						vPublicidad 	= rs("Id_Publicidad")
						vNombre			= rs("Nombre")
						vRuta			= rs("Ruta")
						vFecCarga		= rs("Fec_Carga")
						vFecEliminacion = rs("Fec_Eliminacion")
						vEstado			= rs("estado_publicidad")
						vPeriodicidad	= rs("periodicidad")
						vUrl	        = rs("url")
						
						%>			
						
						<tr class="gradeX">
						  <td><input type="checkbox" name="Publicidad" id="Publicidad" style="display: block !important;" value=<%=vPublicidad%>  /></td>
						  <th><%=vNombre%></th>
						  <th><img src="<%=vRuta%>" width="100" height="100"></th>
						  <th><%=vFecCarga%></th>
						  <th><%=vFecEliminacion%></th>
						  <th><% if vPeriodicidad = 2360 then%> VIERNES - DOMINGO
						  <% else%> 
							LUNES - JUEVES
						  <% end if%>
						  </th>
						  <th><%=vUrl%></th>
						  <th>
						  <% if vEstado = 1 then
						  %>
						  Activado
						  <%else%>
						  Desactivado
						  <%end if%></th>
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
            <button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'pub_c1.asp?opc=idmaq2');">Editar</button>
            <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'pub_c1.asp?opc=idmaq');">Eliminar</button>
			<!--<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'pub_c1.asp?opc=new');">Nuevo</button>-->
			<input name="bandera" type="hidden" id="bandera" value="1" />
		</div>
		
      </div>
    </div>
  </div>
  <%end if%>
  
  <%if request.QueryString("opc")="edit" then %> 
 <%
	sql="exec MantenedorPublicidad "
	sql=sql & " 1 , "
	sql=sql & " " & request.QueryString("id") & ", "
	sql=sql & " '' , "
	sql=sql & " 0 , "
	sql=sql & " 0 , '', 1232,'','' "                 
'response.write(sql)
'response.end()
	set rs = nothing
	Set rs = cn.Execute(sql)
	vIdPublicidad	= rs("id_publicidad")
	vEstado			= rs("estado_publicidad")
	vNombre			= rs("nombre")
	vPeriodicidad	= rs("periodicidad")
	vUrl			= rs("url")
	
	if not rs.eof then
 %>
  <div class="span9">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Publicidad</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit" method="post" class="form-horizontal">
			<label class="control-label" style=position:absolute;>Estado Publicidad :</label>
				<div class="controls">
					<select name="Estado" id="Estado" class="span11" style="color:#F7931E" value="<%=vEstado%>">
						<option value="1">Activado</option>
						<option value="0">Desactivado</option>
						
					</select>
				</div>
				<br><br>
				<label class="control-label" style=position:absolute;>Nombre Publicidad :</label>
				<div class="controls">
					<input class="span11" type="text" name="nombre" value="<%=vNombre%>" />
				</div>
				<br><br>
			<div class="control-group">
              <label class="control-label" style=position:absolute;>Periodicidad :</label>
              <div class="controls">
			  <%
					sql ="exec Seleccionar_Datos_Comunes "
					sql = sql & "13 "
					Set rs=nothing
					Set rs = cn.Execute(sql)
					%>
					<select name="periodicidad" id="periodicidad" class="span11" style="color:#F7931E" value="<%=vPeriodicidad%>">
					<%
						if not rs.eof then
							do while not rs.eof
								if cdbl(rs("Id_DatosComunes")) = cdbl(vPeriodicidad) then
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
			  <br>
			</div>
			<br><br>
				<label class="control-label" style=position:absolute;>URL :</label>
				<div class="controls">
					<input class="span11" type="text" name="url" value="<%=vUrl%>" />
				</div>
			<br>
			
			<div class="form-actions">
			<br>
				<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form3_crit,'pub_c1.asp?opc=sav&id=<%=vIdPublicidad%>');">Guardar</button>
			</div>
			<br>
          </form>
        </div>
      </div>
      
    </div>
  <%
  end if
  end if%>
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
				mostrarMensaje('Publicidad Modificada Exitosamente.', 'success');
			}
			else if (mensaje == 4) {
				mostrarMensaje('Publicidad Eliminada Exitosamente.', 'success');
			}
		}
	});
</script>
<script>
	function ShowImagePreview( files )
	{
		if (ValidarImagen(files, 957, 400)) {
			if( !( window.File && window.FileReader && window.FileList && window.Blob ) )
			{
			  mostrarMensaje('The File APIs are not fully supported in this browser.', 'error');
			  return false;
			}

			if( typeof FileReader === "undefined" )
			{
				mostrarMensaje('Filereader undefined!', 'error');
				return false;
			}

			var file = files[0];

			if( !( /image/i ).test( file.type ) )
			{
				mostrarMensaje('File is not an image.', 'error');
				return false;
			}

			reader = new FileReader();
			reader.onload = function(event)
					{ var img = new Image;
					  img.onload = UpdatePreviewCanvas;
					  img.src = event.target.result;  }
			reader.readAsDataURL( file );
		}
	}

	function UpdatePreviewCanvas()
	{
		var img = this;
		var canvas = document.getElementById( 'previewcanvas' );

		if( typeof canvas === "undefined"
			|| typeof canvas.getContext === "undefined" )
			return;

		var context = canvas.getContext( '2d' );

		var world = new Object();
		world.width = canvas.offsetWidth;
		world.height = canvas.offsetHeight;

		canvas.width = world.width;
		canvas.height = world.height;

		if( typeof img === "undefined" )
			return;

		var WidthDif = img.width - world.width;
		var HeightDif = img.height - world.height;

		var Scale = 0.0;
		if( WidthDif > HeightDif )
		{
			Scale = world.width / img.width;
		}
		else
		{
			Scale = world.height / img.height;
		}
		if( Scale > 1 )
			Scale = 1;

		var UseWidth = Math.floor( img.width * Scale );
		var UseHeight = Math.floor( img.height * Scale );

		var x = Math.floor( ( world.width - UseWidth ) / 2 );
		var y = Math.floor( ( world.height - UseHeight ) / 2 );

		context.drawImage( img, x, y, UseWidth, UseHeight );
	}
</script>
<script type="text/javascript">
	function validarCambio(formulario, pagina){
		var Nombre 		= document.getElementById('Nombre').value;
		
		if(Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)){
			//alert('ERROR: El campo Nombre no debe ir vacío');
			mostrarMensaje('El campo Nombre no debe ir vacío', 'error');
			return false;
		}
		
		var fileInput = document.getElementById('foto1');
		var filePath = fileInput.value;
		var allowedExtensions = /(.jpg|.jpeg|.png|.gif)$/i;
		if(!allowedExtensions.exec(filePath)){
			//alert('Las extensiones de archivo permitidas son: .jpeg/.jpg/.png/.gif ');
			mostrarMensaje('Las extensiones de archivo permitidas son: .jpeg/.jpg/.png/.gif ', 'error');
			fileInput.value = '';
			return false;
		}
		
		irA(formulario, pagina);
		
	}
	</script>
</body>
</html>
