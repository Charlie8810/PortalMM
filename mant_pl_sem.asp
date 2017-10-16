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
</head>
<script type="text/javascript">
function validarDatos(formulario, pagina){
	var Nombre 		= document.getElementById('Nombre').value;
	var Valor 		= document.getElementById('Valor').value;
	var Regiones 	= document.getElementById('Regiones').value;
	var Equipos		= document.getElementById('Equipos').value;
	
	if(Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)){
		mostrarMensaje('El campo Nombre no debe ir vacío', 'error');
		return false;
	}
	if(Valor == null || Valor.length == 0 || /^\s+$/.test(Valor)){
		mostrarMensaje('El Valor no debe ir vacío', 'error');
		return false;
	}
	if (!/^([0-9])*$/.test(Valor)){
      mostrarMensaje('El valor "' + Valor + '" no es un número', 'error');
	  return false;
	}
	if(Regiones == null || Regiones.length == 0 || /^\s+$/.test(Regiones)){
		mostrarMensaje('El campo Regiones no debe ir vacío', 'error');
		return false;
	}
	if (!/^([0-9])*$/.test(Regiones)){
      mostrarMensaje('El valor "' + Regiones + '" no es un número', 'error');
	  return false;
	}
	if(Equipos == null || Equipos.length == 0 || /^\s+$/.test(Equipos)){
		mostrarMensaje('El campo Equipos no debe estar en blanco', 'error');
		return false;
	}
	if (!/^([0-9])*$/.test(Equipos)){
      mostrarMensaje('El valor "' + Equipos + '" no es un número', 'error');
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
	<div id="messageDiv" class="col-md-12" style="display: none;">
		<button type="button" class="close" data-dismiss="modal" onclick="ocultarMessage()" aria-hidden="true">×</button>
		<br />
		<p>message</p>
	</div>
  <div id="breadcrumb"> <a href="index.asp" title="Go to Home" class="tip-bottom" style="color:#666666"><i class="icon-home"></i> Inicio</a></div>
  <h1>Mantenedor de Planes Semestrales</h1>
</div>
<%if request.QueryString("opc")= "sav" then 
	sql="exec MantenedorPlanes "
	sql=sql & " 2 ," 
	sql=sql & " " & request.form("idPlan") & ", "
	sql=sql & " 39,"
	sql=sql & " '" & request.form("nombre") & "' , "
	sql=sql & " " & request.form("valor") & " , "
	sql=sql & " '" & request.form("desc1") & "' , "
	sql=sql & " '" & request.form("desc2") & "' , "
	sql=sql & " '" & request.form("desc3") & "' , "
	sql=sql & " '" & request.form("desc4") & "' , "
	sql=sql & " " & request.form("regiones") & " , "
	sql=sql & " " & request.form("equipos") & " , "
	sql=sql & " " & request.form("estado") & "  "

	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Plan Modificado Exitosamente.', 'success');
		window.location="mant_pl_sem.asp?msg=1";
	</script>
	<%
end if
if request.QueryString("opc")= "sav2" then 
	sql="exec MantenedorPlanes "
	sql=sql & " 3 ," 
	sql=sql & " '', "
	sql=sql & " 39,"
	sql=sql & " '" & request.form("nombre") & "' , "
	sql=sql & " " & request.form("valor") & " , "
	sql=sql & " '" & request.form("desc1") & "' , "
	sql=sql & " '" & request.form("desc2") & "' , "
	sql=sql & " '" & request.form("desc3") & "' , "
	sql=sql & " '" & request.form("desc4") & "' , "
	sql=sql & " " & request.form("regiones") & " , "
	sql=sql & " " & request.form("equipos") & " , "
	sql=sql & " " & request.form("estado") & "  "

	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Plan Agregado Exitosamente.', 'success');
		window.location="mant_pl_sem.asp?msg=2";
	</script>
	<%
end if
if request.QueryString("opc")= "del" then 
	sql="exec MantenedorPlanes "
	sql=sql & " 4 ," 
	sql=sql & " " & request.form("idPlan") & ", "
	sql=sql & " 39,'',0,'','','','',0,0,0"
	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Plan Eliminado Exitosamente.', 'success');
		window.location="mant_pl_sem.asp?msg=3";
	</script>
	<%
end if
%>
<%if request.QueryString("opc")= "idmaq" then 
	
	var_chk_sel=request.form("Planes")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)
	Next 
	if i > 1 then
	%>
	<script type="text/javascript">
		//mostrarMensaje('Seleccione solo un plan.', 'error');
		window.location="mant_pl_men.asp?msg=4";
	</script>
	<%
	else
		if len(var_chk_sel) > 0 then
				Response.Redirect("mant_pl_sem.asp?opc=edit&id="& var_chk_sel)
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
          <h5>Mantenedor de Planes Semestrales</h5>
        </div>
        <div class="widget-content nopadding">
          <form name="form1_crit" action="#" method="post" class="form-horizontal">
              <div class="control-group">
				<label class="control-label">Planes :</label>
				<div class="controls">
					<%
					sql="exec MantenedorPlanes "
					sql=sql & " 1 , -1 , 39, '' , 0 ,'','','','',0, 0, 0"
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					%>
					<select name="vPlanes" class="span11" style="color:#F7931E" value="<%=vPlanes%>">
						<%
						response.write "<option value=-1>SELECCIONE PLANES</option>"
						if not rs.eof then
							do while not rs.eof
								if cdbl(rs("Id_Plan")) = cdbl(vPlanes) then
									response.write "<option selected value=" & rs("Id_Plan") & ">" & ucase(rs("Nombre")) & "</option>"
								else
									response.write "<option value=" & rs("Id_Plan") & ">" & ucase(rs("Nombre")) & "</option>"
								end if
								rs.movenext
							loop
						end if
						%>
					</select>
				</div>
            </div>
                       
            <div class="form-actions">
              <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'mant_pl_sem.asp?opc=sch');">Buscar</button>
			  <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'mant_pl_sem.asp?opc=new');">Nuevo</button>
            </div>
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
            <h5>Listado de Planes</h5>
          </div>
		  
		  <div class="widget-content nopadding">
		  <form name="form2_crit" action="#" method="post" class="form-horizontal">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
				  <th>Opcion</th>
                  <th>Nombre</th>
                  <th>Valor</th>
				  <th>Desc1</th>
				  <th>Desc2</th>
				  <th>Desc3</th>
				  <th>Desc4</th>
				  <th>Regiones</th>
				  <th>Equipos</th>
                  <th>Estado</th>
				  

                </tr>
              </thead>
              <tbody>
			  <%
				
					sql="exec MantenedorPlanes "
					sql=sql & " 1 ," 
					sql=sql & " " & request.form("vPlanes") & ", "
					sql=sql & " 39, '' , 0 ,'','','','',0, 0, 0"
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					if not rs.eof then
						do while not rs.eof
						
						vPlanes		 	= rs("Id_Plan")
						vNombre			= rs("Nombre")
						vValor			= rs("valor")
						vDesc1			= rs("descripcion")
						vDesc2			= rs("desc2")
						vDesc3			= rs("desc3")
						vDesc4			= rs("desc4")
						vRegiones		= rs("num_region")
						vEquipo			= rs("num_equipo")
						vEstado			= rs("estado")
						
						%>			
						
						<tr class="gradeX">
						  <td><input type="checkbox" name="Planes" id="Planes" style="display: block !important;" value=<%=vPlanes%>  /></td>
						  <th><%=vNombre%></th>
						  <th><%=formatnumber(vValor,0)%></th>
						  <th><%=vDesc1%></th>
						  <th><%=vDesc2%></th>
						  <th><%=vDesc3%></th>
						  <th>
						   <% if vDesc4 <> "NULL" then%>
						  <%=vDesc4%>
						  <%else%>
							--
						  <%end if%>
						  </th>
						  <th>
						  <% if vRegiones <> "-1" then%>
						  <%=vRegiones%>
						  <%else%>
							Todos
						  <%end if%>
						  </th>
						   <th><% if vEquipo <> "-1" then%>
						  <%=vEquipo%>
						  <%else%>
							Todos
						  <%end if%></th>
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
            <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'mant_pl_sem.asp?opc=idmaq');">Editar</button>
			<input name="bandera" type="hidden" id="bandera" value="1" />
		</div>
		
      </div>
    </div>
  </div>
  <%end if%>
  <%if request.QueryString("opc")="edit" then 
  
		sql="exec MantenedorPlanes "
		sql=sql & " 1 ," 
		sql=sql & " " & request.QueryString("id") & ", "
		sql=sql & " 39, '' , 0 ,'','','','',0, 0, 0"
		set rs = nothing
		Set rs = cn.Execute(sql)
		
		if not rs.eof then
			vPlanes		 	= rs("Id_Plan")
			vNombre			= rs("Nombre")
			vValor			= rs("valor")
			vDesc1			= rs("descripcion")
			vDesc2			= rs("desc2")
			vDesc3			= rs("desc3")
			vDesc4			= rs("desc4")
			vRegiones		= rs("num_region")
			vEquipo			= rs("num_equipo")
			vEstado			= rs("estado")

  %>
  
  
	<div class="container-fluid">
   <div class="row-fluid">
    <div class="span9">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Planes</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit" method="post" class="form-horizontal">
			<div>
			  <label class="control-label">Nombre :</label>
              <div class="controls">
                <input type="text" class="span11" name="Nombre" id="Nombre" value="<%=vNombre%>"/>
				<input type="hidden" name="idPlan" value="<%=vPlanes%>"/>
			  </div>
            </div>
            <div>
			  <label class="control-label">Valor :</label>
              <div class="controls">
                <input type="text" class="span11" name="Valor" id="Valor"value="<%=vValor%>"/>
			</div>
            </div>
			<div>
			  <label class="control-label">Desc1 :</label>
              <div class="controls">
                <input type="text" class="span11" name="Desc1" value="<%=vDesc1%>"/>
				</div>
			</div>
			<div>
			  <label class="control-label">Desc2 :</label>
              <div class="controls">
                <input type="text" class="span11" name="Desc2" value="<%=vDesc2%>"/>
			</div>
            </div>
			<div>
			  <label class="control-label">Desc3 :</label>
              <div class="controls">
                <input type="text" class="span11" name="Desc3" value="<%=vDesc3%>"/>
			</div>
            </div>
			<div>
			  <label class="control-label">Desc4 :</label>
              <div class="controls">
                <input type="text" class="span11" name="Desc4" value="<%=vDesc4%>"/>
			</div>
            </div>
			<div>
			  <label class="control-label">Regiones :</label>
              <div class="controls">
                <input type="text" class="span11" name="Regiones" id="Regiones" value="<%=vRegiones%>"/>
			</div>
            </div>
			<div>
			  <label class="control-label">Equipos :</label>
              <div class="controls">
                <input type="text" class="span11" name="Equipos" id="Equipos" value="<%=vEquipo%>"/>
			</div>
            </div>	
			<div class="control-group">
              <label class="control-label">Estado :</label>
              <div class="controls">
			    <select name="estado" class="span11" value="<%=vEstado%>">
					<option value="1">Activado</option>
					<option value="0">Desactivado</option>
				</select>
              </div>
			</div>
			<div class="form-actions">
				<button type="submit" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'mant_pl_sem.asp?opc=sav');">Guardar</button>
				<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form3_crit,'mant_pl_sem.asp?opc=del');">Eliminar</button>
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
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span9">
			  <div class="widget-box">
				<div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
				  <h5>Planes</h5>
				</div>
				<div class="widget-content nopadding">
				   <form name="form4_crit" method="post" class="form-horizontal">
					<div>
					  <label class="control-label">Nombre :</label>
					  <div class="controls">
						<input type="text" class="span11" name="Nombre" id="Nombre"/>
						
					  </div>
					</div>
					<div>
					  <label class="control-label">Valor :</label>
					  <div class="controls">
						<input type="text" class="span11" name="Valor" id="Valor"/>
					</div>
					</div>
					<div>
					  <label class="control-label">Desc1 :</label>
					  <div class="controls">
						<input type="text" class="span11" name="Desc1"/>
						</div>
					</div>
					<div>
					  <label class="control-label">Desc2 :</label>
					  <div class="controls">
						<input type="text" class="span11" name="Desc2"/>
					</div>
					</div>
					<div>
					  <label class="control-label">Desc3 :</label>
					  <div class="controls">
						<input type="text" class="span11" name="Desc3"/>
					</div>
					</div>
					<div>
					  <label class="control-label">Desc4 :</label>
					  <div class="controls">
						<input type="text" class="span11" name="Desc4"/>
					</div>
					</div>
					<div>
					  <label class="control-label">Regiones :</label>
					  <div class="controls">
						<input type="text" class="span11" name="Regiones" id="Regiones"/>
					</div>
					</div>
					<div>
					  <label class="control-label">Equipos :</label>
					  <div class="controls">
						<input type="text" class="span11" name="Equipos" id="Equipos"/>
					</div>
					</div>	
					<div class="control-group">
					  <label class="control-label">Estado :</label>
					  <div class="controls">
						<select name="estado" class="span11">
							<option value="1">Activado</option>
							<option value="0">Desactivado</option>
						</select>
					  </div>
					</div>
					<div class="form-actions">
						<button type="submit" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form4_crit,'mant_pl_sem.asp?opc=sav2');">Guardar</button>
					</div>
				  </form>
				</div>
			  </div>
			</div>
  <%
  end if%>
		</div>
	</div>
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
				mostrarMensaje('Plan Modificado Exitosamente.', 'success');
			} else if (mensaje == 2) {
				mostrarMensaje('Plan Agregado Exitosamente.', 'success');
			} else if (mensaje == 3) {
				mostrarMensaje('Plan Eliminado Exitosamente.', 'success');
			} else if (mensaje == 4) {
				mostrarMensaje('Seleccione solo un plan.', 'error');
			}
		}
	});
</script>
</body>
</html>
