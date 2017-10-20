<!--#include file="con_app.asp"-->

<html>
<head>
<link rel="icon" type="image/png" href="./images/icon.ico" />
<title>Mundo Maquinaria</title>
<meta charset="UTF-8" />
<link href="assets/css/footable.core.css" rel="stylesheet">
<link href="assets/css/bootstrap-select.min.css" rel="stylesheet" />

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="assets/css/uniform.css" />
<link rel="stylesheet" href="assets/css/select2.css" />
<link rel="stylesheet" href="assets/css/matrix-style.css" />
<link rel="stylesheet" href="assets/css/matrix-media.css" />
<link rel="stylesheet" href="assets/css/mantenedores.css" />

<link rel="stylesheet" href="assets/css/pages.css" type="text/css" />

<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>

<link href="assets/css/pages.css" rel="stylesheet" type="text/css" />

<script src="assets/js/modernizr.min.js"></script>
</head>
<script language = "JavaScript">
			<%
			productos_Sql = "SELECT Id_DatosComunes, Descripcion, Nivel_Superior FROM Datos_Comunes WHERE Tipo=4 and Nivel = 1 and Estado = 1 "
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
<script language = "JavaScript">
<%
productos_Sql = "SELECT Id_DatosComunes, Descripcion, Nivel_Superior FROM Datos_Comunes WHERE Tipo=4 and Nivel = 1 and Estado = 1 "
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
<script type="text/javascript">
function validarCambio(formulario, pagina){

	var cmb_Equipo 			= document.getElementById('equipo').selectedIndex;
	var cmb_Region 			= document.getElementById('familia').selectedIndex;


	if(cmb_Equipo == null || cmb_Equipo == 0){
			mostrarMensaje('Debe seleccionar un Equipo', 'error');
			return false;
		}
	if(cmb_Region == null || cmb_Region == 0){
			mostrarMensaje('Debe seleccionar una Región','error');
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
	<div id="messageDiv" class="col-md-12" style="display: none;">
		<button type="button" class="close" data-dismiss="modal" onclick="ocultarMessage()" aria-hidden="true">×</button>
		<br />
		<p>message</p>
	</div>
  <div id="breadcrumb"> <a href="index.asp" title="Go to Home" class="tip-bottom" style="color:#666666"><i class="icon-home"></i> Inicio</a></div>
  <h1>Mantenedor de Clientes - Publica tus Ventas</h1>
</div>
<%if request.QueryString("opc")= "sav" then
	sql="exec MantenedorEquiposClientes "
	sql=sql & " 2 ,"
	sql=sql & " " & session("id_usuario") & ", "
	sql=sql & " " & request.form("id") & ", "
	sql=sql & " '" & request.form("tipo") & "' ,"
	sql=sql & " '" & request.form("equipo") & "' ,"
	sql=sql & " '" & request.form("familia") & "' ,"
	sql=sql & " '' ,"
	sql=sql & " '0' ,"
	sql=sql & " '0' ,"
	sql=sql & " '0' "

	set rs = nothing
	Set rs = cn.Execute(sql)

	if not rs.eof then
	%>
	<script type="text/javascript">
		//mostrarMensaje('Su Plan no permite realizar esta operación, favor revisar su plan con el Administrador.', 'error');
		window.location="pub_adminventa.asp?msg=1";
	</script>
	<%
		response.write(rs("mensaje"))
	else
	%>
	<script type="text/javascript">
		//mostrarMensaje('Equipo Modificado Exitosamente', 'success');
		window.location="pub_adminventa.asp?msg=2";
	</script>
	<%
	end if
end if
if request.QueryString("opc")= "sav2" then
	
	
	
	sql="exec MantenedorEquiposClientes "
	sql=sql & " 3 ,"
	sql=sql & " " & session("id_usuario") & ", "
	sql=sql & " '" & request.form("id") & "', "
	sql=sql & " '" & request.form("tipo") & "' ,"
	sql=sql & " '" & request.form("equipo") & "' ,"
	sql=sql & " '" & request.form("familia") & "' ,"
	sql=sql & " '" & request.form("subcatagory") & "' ,"
	sql=sql & " '" & request.form("operador") & "' ,"
	sql=sql & " '" & request.form("combustible") & "' ,"
	sql=sql & " '" & request.form("traslado") & "' "

	set rs = nothing
	Set rs = cn.Execute(sql)

	if not rs.eof then
		vMensaje = rs("Mensaje")
		if vMensaje = "1" then
		%>
		<script type="text/javascript">
			window.location="pub_adminventa.asp?msg=3";
		</script>
		<%
		elseif vMensaje = "2" then
		%>
		<script type="text/javascript">
			window.location="pub_adminventa.asp?msg=6";
		</script>
		<%
		elseif vMensaje = "3" then
		%>
		<script type="text/javascript">
			window.location="pub_adminventa.asp?msg=1";
		</script>
		<%
		elseif vMensaje = "4" then
		%>
		<script type="text/javascript">
			window.location="pub_adminventa.asp?msg=1";
		</script>
		<%
		end if
	end if
end if
if request.QueryString("opc")= "del" then
	sql="exec MantenedorEquiposClientes "
	sql=sql & " 4 ,"
	sql=sql & " " & session("id_usuario") & ", "
	sql=sql & " '" & request.queryString("id_detalle") & "', "
	sql=sql & " '" & request.form("tipo") & "' ,"
	sql=sql & " '" & request.form("equipo") & "' ,"
	sql=sql & " '" & request.form("familia") & "' ,"
	sql=sql & " '" & request.form("subcatagory") & "' ,"
	sql=sql & " '" & request.form("operador") & "' ,"
	sql=sql & " '" & request.form("combustible") & "' ,"
	sql=sql & " '" & request.form("traslado") & "' "

	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje("Equipo Eliminado Exitosamente.");
		window.location="pub_adminventa.asp?msg=4";
	</script>
	<%
end if
%>
<%if request.QueryString("opc")= "idmaq" then

	var_chk_sel=request.form("vIdCliPlan")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)
	Next

	if i > 1 then
	%>
	<script type="text/javascript">
		//mostrarMensaje('Debe seleccionar solo un equipo.','error');
		window.location="pub_adminventa.asp?msg=5";
	</script>
<%	else
		if len(var_chk_sel) > 0 then
				Response.Redirect("pub_adminventa.asp?opc=edit&id="& var_chk_sel)
				Response.End
		end if
	end if
end if
if request.QueryString("opc")= "idmaq2" then

	var_chk_sel=request.form("vIdCliPlan")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)
	Next

	sql ="exec EliminaEquipos "
	sql=sql & " '" & var_chk_sel & "' "	

	Set rs=nothing
	Set rs = cn.Execute(sql)
	
	%>
	<script type="text/javascript">
		//mostrarMensaje('Los Equipos se eliminaron existosamente', 'error');
		window.location="pub_adminventa.asp?msg=4";
	</script>
<%	
end if
if request.QueryString("opc")= "idmaq3" then 
	
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
		setTimeout(window.location="pub_adminventa.asp";, 3000);
	</script>
<%	else
		if len(var_chk_sel) > 0 then
				Response.Redirect("pub_adminventa.asp?opc=edit2&id="& var_chk_sel)
				Response.End
		end if	
	end if
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
              <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'pub_adminventa.asp?opc=sch');">Buscar</button>
			  <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'pub_adminventa.asp?opc=new');">Nuevo</button>
			  <button type="submit" class="btn btn-success" onClick="irAFuera(document.forms.form1_crit,'pub_adminventa.asp?opc=sch&exp=xls','_blank')">Exportar</button>
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
            <button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'pub_adminventa.asp?opc=idmaq3');">Editar</button>
			<!--<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'demo_tabla.asp?opc=new');">Nuevo</button>-->
			<input name="bandera" type="hidden" id="bandera" value="1" />
		</div>
      </div>
    </div>
  </div>
  <%end if%>
  <%if request.QueryString("opc")="edit2" then %>
  <div class="widget-content nopadding">
		  <form name="form2_crit" action="#" method="post" class="form-horizontal">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
				  <th>Opcion</th>
                  <th>Marca</th>
                  <th>Modelo</th>
				  <th>Equipo</th>
                  <th>Region</th>
                  
                </tr>
              </thead>
              <tbody>
			  <%

			sql="exec spMantenedorVentaAdminUsuario_Listar "
			sql=sql & " " & request.QueryString("id") & " "

					set rs = nothing
					Set rs = cn.Execute(sql)

					if not rs.eof then
						do while not rs.eof

						vIdCliPlan	= rs("id_venta")

						vDescTipo	= rs("Marca")
                        vDescModelo	= rs("Modelo")
						vDescEquipo	= rs("Equipo")
						vDescRegion	= rs("Region")
						

						%>

						<tr class="gradeX">
						  <td><input type="checkbox" name="vIdCliPlan" id="vIdCliPlan" style="display: block !important;" value=<%=vIdCliPlan%>  /></td>
						  <th><%=vDescTipo%></th>
                          <th><%=vDescModelo%></th>
						  <th><%=vDescEquipo%></th>
						  <th><%=vDescRegion%></th>
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
            <button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'pub_adminventa.asp?opc=idmaq3');">Editar</button>
			<input name="bandera" type="hidden" id="bandera" value="1" />
			<button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'pub_adminventa.asp?opc=new&idCP=<%=vCliPlan%>');">Nuevo</button>
			<button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'pub_adminventa.asp?opc=idmaq2');">Eliminar</button>
		</div>
  <%end if%>
<%
else	
%>
<div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon border-blue"><i class="icon-th"></i></span>
            <h5>Listado de Equipos</h5>
          </div>
<div class="widget-content nopadding">
          <form name="form1_crit" action="#" method="post" class="form-horizontal">
              <div class="control-group">
				<label class="control-label">Categoria :</label>
				<div class="controls">
					<%
					sql ="exec Seleccionar_Datos_Comunes "
					sql = sql & "2 "
					Set rs=nothing
					Set rs = cn.Execute(sql)
					%>
					<select name="Categoria" id="Categoria" class="span11" style="color:#F7931E" value="<%=vCategoria%>">
					<%
						response.write "<option value=-1>SELECCIONE CATEGORIA</option>"
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
				</div>
				<label class="control-label">Equipo :</label>
				<div class="controls">
					<%
					sql ="exec Seleccionar_Datos_Comunes "
					sql = sql & "1 "
					Set rs=nothing
					Set rs = cn.Execute(sql)
					%>
					<select name="Equipo" id="Equipo" class="span11" style="color:#F7931E" value="<%=vEquipo%>">
					<%
						response.write "<option value=-1>SELECCIONE EQUIPO</option>"
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
				</div>
           
				<label class="control-label">Región :</label>
				<div class="controls">
					<%
					sql ="exec Seleccionar_Datos_Comunes "
					sql = sql & "3 "
					Set rs=nothing
					Set rs = cn.Execute(sql)
					%>
					<select name="vRegion" id="vRegion" class="span11" style="color:#F7931E" value="<%=vRegion%>">
					<%
						response.write "<option value=-1>SELECCIONE REGIÓN</option>"
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
				</div>
                </div>       
            <div class="form-actions">
              <button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'pub_adminventa.asp?opc=sch');">Buscar</button>
			  <button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'pub_adminventa.asp?opc=new');">Nuevo</button>
			  <!--<button type="submit" class="btn btn-success" onClick="irAFuera(document.forms.form1_crit,'pub_adminventa.asp?opc=sch&exp=xls','_blank')">Exportar</button>-->
            </div>
          </form>
        </div>
	<%if request.QueryString("opc")="sch" then %>	
		  <div class="widget-content nopadding">
		  <form name="form2_crit" action="#" method="post" class="form-horizontal">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
				  <th>Opcion</th>
                  <th>Categoría</th>
                  <th>Equipo</th>
				  <th>Región</th>
                  
                </tr>
              </thead>
              <tbody>
			  <%

			sql="exec ListaEquiposCliente "
			sql=sql & " " & request.form("Categoria") & ", "
			sql=sql & " " & request.form("Equipo") & ", "
			sql=sql & " " & request.form("vRegion") & ", "
			sql=sql & " " & session("id_usuario") & " "

					set rs = nothing
					Set rs = cn.Execute(sql)

					if not rs.eof then
						do while not rs.eof

						vIdCliPlan	= rs("IdDetalleClientePlan")
						vCliPlan 	= rs("id_cliente_plan")

						vDescTipo	= rs("categoria")
						vDescEquipo	= rs("nombreEquipo")
						vDescRegion	= rs("region")
						

						%>

						<tr class="gradeX">
						  <td><input type="checkbox" name="vIdCliPlan" id="vIdCliPlan" style="display: block !important;" value=<%=vIdCliPlan%>  /></td>
						  <th><%=vDescTipo%></th>
						  <th><%=vDescEquipo%></th>
						  <th><%=vDescRegion%></th>
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
            <button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'pub_adminventa.asp?opc=idmaq');">Editar</button>
			<input name="bandera" type="hidden" id="bandera" value="1" />
			<button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'pub_adminventa.asp?opc=new&idCP=<%=vCliPlan%>');">Nuevo</button>
			<button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'pub_adminventa.asp?opc=idmaq2');">Eliminar</button>
		</div>
		<%end if%>
      </div>
    </div>
  </div>
  <%if request.QueryString("opc")="edit" then

		sql="exec MantenedorEquiposClientes "
		sql=sql & " 1 , 0 , "
		sql=sql & " " & request.QueryString("id") & ", "
		sql=sql & " '' , '' , '' , '' , '' , '' , '' "

		set rs = nothing
		Set rs = cn.Execute(sql)
		if not rs.eof then

		vIdCliPlan	= rs("IdDetalleClientePlan")
		vCliPlan 	= rs("id_cliente_plan")
		vTipo		= rs("tipo_cotiza")
		vDescTipo	= rs("desc_tipo")
		vEquipo		= rs("equipo")
		vDescEquipo	= rs("desc_equipo")
		vRegion 	= rs("region")
		vDescRegion	= rs("desc_region")
		vCiudad		= rs("ciudad")
		vDescCiudad	= rs("desc_ciudad")
		vOperador	= rs("operador")
		vCombustible 	= rs("combustible")
		vTraslado	= rs("traslado")

  %>

  <div class="widget-box">
	 <div class="widget-content nopadding">
		  <form name="form4_crit" action="#" method="post" class="form-horizontal">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
				 <th>Categoría</th>
                  <th>Equipo</th>
				  <th>Región</th>
                  
                </tr>
              </thead>
              <tbody>
				<tr class="gradeX">
						  <th>
						  <input name="id" type="hidden" id="id" value="<%=vIdCliPlan%>" />
						  <%
							sql ="exec TipoPlanPadreporUsuario "
							sql=sql & "'" & session("id_usuario") & "' "
							
							
							Set rs=nothing
							Set rs = cn.Execute(sql)
							if not rs.eof then
								vIdTipoPlan		= rs("id_Tipo_Plan_Padre")
							end if
							if vIdTipoPlan = 2362 then
							%>
							<select name="tipo" id="tipo" style="font-weight:bold; color:#3B5998; cursor: pointer;" >
								<option value="17">ARRIENDO</option>
							</select>
							<%elseif vIdTipoPlan = 2363 then%>
							<select name="tipo" id="tipo" style="font-weight:bold; color:#3B5998; cursor: pointer;" >
								<option value="41">SERVICIO TÉCNICO</option>
							</select>
							<%elseif vIdTipoPlan = 2364 then%>
							<select name="tipo" id="tipo" style="font-weight:bold; color:#3B5998; cursor: pointer;" >
								<option value="17">ARRIENDO</option>
								<option value="41">SERVICIO TÉCNICO</option>
							</select>
							<%end if%>
						  </th>
						  <th>
						  <%
							sql ="exec Seleccionar_Datos_Comunes "
							sql = sql & "1 "
							Set rs=nothing
							Set rs = cn.Execute(sql)
							%>
							<select name="equipo" id="equipo" style="font-weight:bold; color:#3B5998; cursor: pointer;" value="<%=vEquipo%>">
								<%
								response.write "<option value=0>EQUIPO</option>"
								if not rs.eof then
									do while not rs.eof
										if cdbl(rs("Id_DatosComunes")) = cdbl(vEquipo) then
											response.write "<option selected value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
										else
											response.write "<option value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
										end if
										rs.movenext
									loop
								end if
								%>
							</select>
						  </th>
						  <th>
							<!--<select name="region" id="region" style="font-weight:bold; color:#3B5998; cursor: pointer;" value="<%=vRegion%>">-->
							<select id="familia" name="familia" onChange = "javascript:sublist(this.form, familia.value);" style="font-weight:bold; color:#3B5998; cursor: pointer;" value="<%=vRegion%>">
								<option selected value = "0">REGION</option>
								<%familias_Sql = "SELECT Id_DatosComunes, Descripcion FROM Datos_Comunes WHERE Tipo = 3 and Nivel = 1 and Estado = 1"
								Set rs=nothing
								Set rs = cn.Execute(familias_Sql)
								do while not rs.eof
									if cdbl(rs("Id_DatosComunes")) = cdbl(vRegion) then
										response.write "<option value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
									else
										response.write "<option value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"
									end if
								rs.movenext
								loop
								%>
							</select>
						  </th>
						</tr>
						<%

					end if%>
              </tbody>
            </table>

			</form>
          </div>
	</div>
	<div class="form-actions">
       <button type="button" class="btn btn-success" onClick="javascript:validarCambio(document.forms.form4_crit,'pub_adminventa.asp?opc=sav');">Guardar</button>
       <button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form4_crit,'pub_adminventa.asp?opc=del&id_detalle=<%=request.QueryString("id")%>');">Eliminar</button>
	</div>
  <%end if%>
  <%if request.QueryString("opc")="new" then %>
  <div class="widget-box">
	 <div class="widget-content nopadding">
		  <form name="form5_crit" action="#" method="post" class="form-horizontal">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
				 <th>Tipo Cotización</th>
                  <th>Equipo</th>
				  <th>Región</th>
                 
                </tr>
              </thead>
              <tbody>
				<tr class="gradeX">
						  <th>
						  <input name="id" type="hidden" id="id" value="" />
						  <%
							sql ="exec TipoPlanPadreporUsuario "
							sql=sql & "'" & session("id_usuario") & "' "
							
							
							Set rs=nothing
							Set rs = cn.Execute(sql)
							if not rs.eof then
								vIdTipoPlan		= rs("id_Tipo_Plan_Padre")
							end if
							if vIdTipoPlan = 2362 then
							%>
							<select name="tipo" id="tipo" style="font-weight:bold; color:#3B5998; cursor: pointer;" >
								<option value="17">ARRIENDO</option>
							</select>
							<%elseif vIdTipoPlan = 2363 then%>
							<select name="tipo" id="tipo" style="font-weight:bold; color:#3B5998; cursor: pointer;" >
								<option value="41">SERVICIO TÉCNICO</option>
							</select>
							<%elseif vIdTipoPlan = 2364 then%>
							<select name="tipo" id="tipo" style="font-weight:bold; color:#3B5998; cursor: pointer;" >
								<option value="17">ARRIENDO</option>
								<option value="41">SERVICIO TÉCNICO</option>
							</select>
							<%end if%>
						  </th>
						  <th>
						  <%
							sql ="exec Seleccionar_Datos_Comunes "
							sql = sql & "1 "
							Set rs=nothing
							Set rs = cn.Execute(sql)
							%>
							<select name="equipo" id="equipo" style="font-weight:bold; color:#3B5998; cursor: pointer;" value="">
								<%
								response.write "<option value=0>EQUIPO</option>"
								if not rs.eof then
									do while not rs.eof

											response.write "<option value=" & rs("Id_DatosComunes") & ">" & ucase(rs("Descripcion")) & "</option>"

										rs.movenext
									loop
								end if
								%>
							</select>
						  </th>
						  <th>
							<!--<select name="region" id="region" style="font-weight:bold; color:#3B5998; cursor: pointer;" value="<%=vRegion%>">-->
							<select id="familia" name="familia" onChange = "javascript:sublist(this.form, familia.value);" style="font-weight:bold; color:#3B5998; cursor: pointer;" value="<%=vRegion%>">
								<option selected value = "0">REGION</option>
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
						  </th>
						</tr>

              </tbody>
            </table>

			</form>
          </div>
	</div>
	<div class="form-actions">
       <button type="button" class="btn btn-success" onClick="javascript:validarCambio(document.forms.form5_crit,'pub_adminventa.asp?opc=sav2&Id=<%=request.QueryString("idCP")%>');">Guardar</button>
	</div>
*Si el equipo que usted desea ingresar no figura en la lista, favor contactarse con contacto@mundomaquinarias.cl solicitando su ingreso.
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
				mostrarMensaje('Su Plan no permite realizar esta operación, favor revisar su plan con el Administrador.', 'error');
			} else if (mensaje == 2) {
				mostrarMensaje('Equipo Modificado Exitosamente', 'success');
			} else if (mensaje == 3) {
				mostrarMensaje('Equipo Agregado Exitosamente.', 'success');
			} else if (mensaje == 4) {
				mostrarMensaje('Equipo Eliminado Exitosamente.', 'success');
			} else if (mensaje == 5) {
				mostrarMensaje('Debe seleccionar solo un equipo.', 'error');
			} else if (mensaje == 6) {
				mostrarMensaje('El Equipo que intenta agregar, ya se encuentra creado para la region seleccionada.', 'error');	
			}
		}
	});
</script>
</body>
</html>
