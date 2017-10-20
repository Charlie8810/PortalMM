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
    var Equipo 			= document.getElementById('Equipo').value;
    var Marca           = document.getElementById('Marca').value;



    if(Equipo == null || Equipo == 0 || /^\s+$/.test(Equipo)){
        mostrarMensaje('El campo Equipo no debe ir vacío', 'error');
		return false;
    }

    if(Marca == null || Marca.length == 0 || /^\s+$/.test(Marca)){
        mostrarMensaje('El campo Marca no debe ir vacío', 'error');
        return false;
    }
	
    /*

    if(Marca == null || Marca.length == 0 || /^\s+$/.test(Marca)){
		mostrarMensaje('El campo Marca no debe ir vacío', 'error');
		return false;
	}


    */

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
    Response.Redirect("./index.asp?msg=3")
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
  <h1>Mantenedor de Clientes - Publica tu Venta</h1>
</div>
<%if request.QueryString("opc")= "sav" then 
	sql="exec MantenedorVenta "
	sql=sql & " 2 , "
	sql=sql & " " & request.form("idEquipos") & ", "
	sql=sql & "'" & request.form("nombre") & "'," 
	sql=sql & " " & request.form("estado") & " "
	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Equipo Modificado Exitosamente.', 'success');
		window.location="mant_venta.asp?msg=1";
	</script>
	<%
end if
%>
<%if request.QueryString("opc")= "sav2" then 
	sql="exec spMantenedorVenta_Guardar "
	sql=sql & "0, " &_
            "" & request.form("Equipo") & ", " &_
            "'" & request.form("Marca") & "' , " &_
            "'" & request.form("Modelo") & "' , " &_    
	        "" & request.form("Precio") & " , " &_    
	        "'" & request.form("Anio") & "' , " &_    
            "" & request.form("familia") & " , " &_        
            "" & request.form("subcatagory") & " , " &_      
            "'" & request.form("Descripcion") & "', " &_
            "'" & request.form("estado") & "', " &_
            "" & session("id_usuario") & " " 
	set rs = nothing
	Set rs = cn.Execute(sql)
	
		%>
		<script type="text/javascript">
			//mostrarMensaje('Equipo Agregado Exitosamente.','success');
			window.location="mant_venta.asp?msg=2";
		</script>
		<%
	
end if
%>
<%if request.QueryString("opc")= "del" then 
	sql="exec spMantenedorVenta_Eliminar "
	sql=sql & " " & request.form("idVenta") & " "
	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Equipo Eliminado Exitosamente.', 'success');
		window.location="mant_venta.asp?msg=4";
	</script>
<%
end if
%>
<%if request.QueryString("opc")= "idvta" then 
	
	var_chk_sel=request.form("idVenta")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)
	Next 
	if i > 1 then
	%>
	<script type="text/javascript">
		//mostrarMensaje('Debe seleccionar solo un equipo.', 'success');
		window.location="mant_venta.asp?msg=5";
	</script>
<%	else
		if len(var_chk_sel) > 0 then
			Response.Redirect("mant_venta.asp?opc=edit&id="& var_chk_sel)
			Response.End
		end if
	end if
end if
%>

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
<div class="container-fluid">
  <hr>
  <div class="row-fluid">
    <div class="span12">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Mantenedor de Ventas</h5>
        </div>
        <div class="widget-content nopadding">
          <form name="form1_crit" action="#" method="post" class="form-horizontal">
              <div class="control-group">
				<label class="control-label">Equipos :</label>
				<div class="controls">
					<%
					sql="exec MantenedorEquipos "
					sql=sql & " 1 , -1 , '' , 0"
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					%>
					<select name="vEquipos" class="span11" style="color:#F7931E">
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
                       
            <div class="form-actions">
              <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'mant_venta.asp?opc=sch');">Buscar</button>
			  <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'mant_venta.asp?opc=new');">Nuevo</button>
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
            <h5>Listado de Maquinas Venta</h5>
          </div>
		  
		  <div class="widget-content nopadding">
		  <form name="form2_crit" action="#" method="post" class="form-horizontal">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
				  <th>Opcion</th>
                  <th>Marca</th>
                  <th>Modelo</th>
                  <th>Año</th>
                  <th>Estado</th>
				  

                </tr>
              </thead>
              <tbody>
			  <%
				
					sql="exec spMantenedorVenta_Listar "
					sql=sql & " " & request.form("vEquipos") & " "
					
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					if not rs.eof then
						do while not rs.eof
						
						%>			
						
						<tr class="gradeX">
						  <td><input type="checkbox" name="Equipo" id="cEquipo" style="display: block !important;" value=<%=rs("id_venta")%> /></td>
						  <th><%=rs("vent_equipo_marca")%></th>
                          <th><%=rs("vent_equipo_modelo")%></th>
                            <th><%=rs("vent_anio")%></th>
						  <th>
						  <% if rs("vent_estado") then
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
            <% ' <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'mant_venta.asp?opc=idmaq');">Editar</button> %>
			<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'mant_venta.asp?opc=new');">Nuevo</button>
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
				<label class="control-label">Equipo :</label>
				<div class="controls">
					<%
					sql="exec MantenedorEquipos "
					sql=sql & " 1 , -1 , '' , 0"
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					%>
					<select name="vEquipos" class="span11" style="color:#F7931E">
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


			<div>
			  <label class="control-label">Nombre :</label>
              <div class="controls">
                <input type="text" class="span11" name="Nombre" id="Nombre" value="<%=vNombre%>"/>
				<input type="hidden" name="idEquipos" value="<%=vEquipos%>"/>
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
				<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'mant_eq.asp?opc=sav');">Guardar</button>
				<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form3_crit,'mant_eq.asp?opc=del');">Eliminar</button>
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
  <%if request.QueryString("opc")="new" then%>
	<div class="container-fluid">
   <div class="row-fluid">
    <div class="span9">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Equipos en Venta</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit" method="post" class="form-horizontal">

               <div class="control-group">
				<label class="control-label">Equipo :</label>
				<div class="controls">
					<%
					sql="exec MantenedorEquipos "
					sql=sql & " 1 , -1 , '' , 0"
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					%>
					<select name="Equipo" id="Equipo" class="span11" style="color:#F7931E">
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


			<div>
                <label class="control-label">Marca :</label>
                <div class="controls">
                    <input type="text" class="span11" name="Marca" id="Marca"  />
                </div>
            </div>
            <div>
                <label class="control-label">Modelo :</label>
                <div class="controls">
                    <input type="text" class="span11" name="Modelo" id="Modelo" />
                </div>
            </div>
            <div>
                <label class="control-label">Año :</label>
                <div class="controls">
                    <input type="text" class="span11" name="Anio" id="Anio" />
                </div>
            </div>
            <div>
                <label class="control-label">Precio :</label>
                <div class="controls">
                    <input type="text" class="span11" name="Precio" id="Precio" />
                </div>
            </div>
            <div>
                                    <label class="control-label">Región :</label>
                                    <div class="controls">
                                        <select size="1" id="familia" class="span11" name="familia" onchange="javascript:sublist(this.form, familia.value);" style="color: #3B5998; cursor: pointer;" value="<%=Ucase(vRegion)%>">
                                            <option selected value="0">Región</option>
                                            <%
                                                familias_Sql = "SELECT Id_DatosComunes, Descripcion FROM Datos_Comunes WHERE Tipo = 3 and Nivel = 1 and Estado = 1"
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

                                </div>
                                <div>
                                    <label class="control-label">Ciudad :</label>
                                    
                                    <div class="controls">
                                        <select id="subcatagory" name="subcatagory" class="span11" style="color: #3B5998; cursor: pointer;">
                                            <option selected value="0">Ciudad</option>
                                        </select>
                                    </div>
                                 </div>   
                                    

                <div>
                    <label class="control-label">Descripción :</label>
                    <div class="controls">
                        <textarea rows="4" cols="50" class="span11" name="Descripcion" id="Descripcion">
                            </textarea>
                    </div>
                </div>

               <div>
                <label class="control-label">Imagenes :</label>
                <div class="controls">
                    <input type="file" name="file1" />
                    <input type="file" name="file2" />
                    <input type="file" name="file3" />
                    <input type="file" name="file4" />
                    <input type="file" name="file5" />
                </div>
            </div>


            <div class="control-group">
              <label class="control-label">Estado :</label>
              <div class="controls">
			    <select name="estado" id="estado" class="span11">
					<option value="1">Activado</option>
					<option value="0">Desactivado</option>
				</select>
              </div>
			</div>
			<div class="form-actions">
				<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'mant_venta.asp?opc=sav2');">Guardar</button>
           </div>
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
