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
    Response.Redirect("./index.asp?msg=4")
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
  <div id="breadcrumb"> <a href="index.asp" title="Go to Home" class="tip-bottom" style="color:#666666"><i class="icon-home"></i> Inicio</a></div>
  <h1>Mantenedor de Clientes - Actualiza tus datos</h1>
</div>
<%if request.QueryString("opc")= "sav" then 
	sql="exec MantenedorPublicidad "
	if request.form("estado") = 1 then
		sql=sql & " 2,"
	else		
		sql=sql & " 6,"
	end if
	sql=sql & " " & request.form("idPublicidad") & ", "
	sql=sql & " '" & request.form("archivo") & "', "
	sql=sql & " " & request.form("estado") & " , "
	sql=sql & " 1 , "
	sql=sql & "'" & request.form("nombre") & "'," 
	sql=sql & " 1231 "

	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		alert("Publicidad Modificada Exitosamente.");
		window.location="demo_tabla.asp";
	</script>
	<%
end if
if request.QueryString("opc")= "sav2" then 
	sql="exec MantenedorPublicidad "
	sql=sql & " 3,"
	sql=sql & " -1, "
	sql=sql & " '" & request.form("archivo") & "', "
	sql=sql & " " & request.form("estado") & " , "
	sql=sql & " 1 , "
	sql=sql & "'" & request.form("nombre") & "',"
	sql=sql & " 1231 "	

	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		alert("Publicidad Modificada Exitosamente.");
		window.location="demo_tabla.asp";
	</script>
	<%
end if
%>
<%if request.QueryString("opc")= "idmaq" then 
	
	var_chk_sel=request.form("Publicidad")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)

	Next 
	if len(var_chk_sel) > 0 then
            Response.Redirect("demo_tabla.asp?opc=edit&id="& var_chk_sel)
            Response.End
    end if			
end if
%>
<div class="container-fluid">
  <hr>
  <div class="row-fluid">
       <div class="widget-content nopadding">
          <form name="form1_crit" action="#" method="post" class="form-horizontal">
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
			  <label class="control-label">Nombre :</label>
              <div class="controls">
                <input type="text" class="span11" name="Nombre" value="<%=vNombre%>"/>
			  </div>
            </div>
             <div>
			  <label class="control-label">Rut :</label>
              <div class="controls">
                <input type="text" class="span11" name="Rut" value="<%=vRut%>"/>-<input type="text" class="span1" name="dv" value="<%=vDv%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Direccion :</label>
              <div class="controls">
                <input type="text" class="span11" name="Direccion" value="<%=vDireccion%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Rubro :</label>
              <div class="controls">
                <input type="text" class="span11" name="Rubro" value="<%=vRubro%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Nombre Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="NomContacto" value="<%=vNomContacto%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Mail Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="MailContacto" value="<%=vMailContacto%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Telefono Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="TelefonoContacto" value="<%=vTelefonoContacto%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Cargo Contacto :</label>
              <div class="controls">
                <input type="text" class="span11" name="CargoContacto" value="<%=vCargoContacto%>"/>
			  </div>
            </div>
			<div>
			  <label class="control-label">Mail Cotizacion :</label>
              <div class="controls">
                <input type="text" class="span11" name="MailCotizacion" value="<%=vMailCotizacion%>"/>
			  </div>
            </div>
			<div class="form-actions">
				<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form3_crit,'demo_tabla.asp?opc=sav');">Guardar</button>
			</div>
          </form>
        </div>
      </div>
      
    </div>
  </div>
  
</div>
                       
           
          </form>
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
                  <th>Fecha Carga</th>
				  <th>Fecha Eliminacion</th>
                  <th>Estado</th>
				  

                </tr>
              </thead>
              <tbody>
			  <%
				
					sql="exec MantenedorPublicidad "
					sql=sql & " 1 , "
					sql=sql & " " & request.form("vPublicidad") & ", "
					sql=sql & " '' , "
					sql=sql & " 0 , "
					sql=sql & " 0 , '', 1231 "                 
		
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					if not rs.eof then
						do while not rs.eof
						
						vPublicidad 	= rs("Id_Publicidad")
						vNombre			= rs("Nombre")
						vFecCarga		= rs("Fec_Carga")
						vFecEliminacion = rs("Fec_Eliminacion")
						vEstado			= rs("estado_publicidad")
						
						%>			
						
						<tr class="gradeX">
						  <td><input type="checkbox" name="Publicidad" id="Publicidad" style="display: block !important;" value=<%=vPublicidad%>  /></td>
						  <th><%=vNombre%></th>
						  <th><%=vFecCarga%></th>
						  <th><%=vFecEliminacion%></th>
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
            <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'demo_tabla.asp?opc=idmaq');">Editar</button>
			<!--<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'demo_tabla.asp?opc=new');">Nuevo</button>-->
			<input name="bandera" type="hidden" id="bandera" value="1" />
		</div>
		
      </div>
    </div>
  </div>
  <%end if%>
  <%if request.QueryString("opc")="edit" then 
  
		sql="exec MantenedorPublicidad "
		sql=sql & " 1 , "
		if request.queryString("tip")= "new" then
			sql=sql & " 0 , "
		else
			sql=sql & " " & request.QueryString("id") & ", "
		end if			
		sql=sql & " '' , "
		sql=sql & " 0 , "
		sql=sql & " 0 , '', 1231 "                 

		set rs = nothing
		Set rs = cn.Execute(sql)
		if not rs.eof then
		
		vPublicidad 	= rs("Id_Publicidad")
		vNombre			= rs("Nombre")
		vFecCarga		= rs("Fec_Carga")
		vFecEliminacion = rs("Fec_Eliminacion")
		vEstado			= rs("estado_publicidad")

  %>
  
  
	<div class="container-fluid">
   <div class="row-fluid">
    <div class="span9">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Publicidad</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit" method="post" class="form-horizontal">
			<div>
			  <label class="control-label">Nombre :</label>
              <div class="controls">
                <input type="text" class="span11" name="Nombre" value="<%=vNombre%>"/>
				<input type="hidden" name="idPublicidad" value="<%=vPublicidad%>"/>
			  </div>
            </div>
             <div class="control-group">
              <label class="control-label">Subir Imagenes :</label>
              <div class="controls">
                <input type="file" name ="archivo"/>
              </div>
            </div>
			<div class="control-group">
              <label class="control-label">Estado :</label>
              <div class="controls">
			    <select name="estado" class="texto2" value="<%=vEstado%>">
					<option value="1">Activado</option>
					<option value="0">Desactivado</option>
				</select>
              </div>
			</div>
			<div class="form-actions">
				<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form3_crit,'demo_tabla.asp?opc=sav');">Guardar</button>
			</div>
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
  <%if request.QueryString("opc")="new" then %>
  <div class="span9">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Publicidad</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit" method="post" class="form-horizontal">
			<div>
			  <label class="control-label">Nombre :</label>
              <div class="controls">
                <input type="text" class="span11" name="Nombre"/>
				
			  </div>
            </div>
             <div class="control-group">
              <label class="control-label">Subir Imagenes :</label>
              <div class="controls">
                <input type="file" name ="archivo"/>
              </div>
            </div>
			<div class="control-group">
              <label class="control-label">Estado :</label>
              <div class="controls">
			    <select name="estado" class="texto2">
					<option value="1">Activado</option>
					<option value="0">Desactivado</option>
				</select>
              </div>
			</div>
			<div class="form-actions">
				<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form3_crit,'demo_tabla.asp?opc=sav2');">Guardar</button>
			</div>
          </form>
        </div>
      </div>
      
    </div>
  
  <%
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
</body>
</html>
