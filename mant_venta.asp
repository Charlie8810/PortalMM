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
<link href="assets/css/footable.core.css" rel="stylesheet">
<link href="assets/css/bootstrap-select.min.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="assets/css/mantenedores.css" />
<script src="assets/js/jquery.min.js"></script> 
<script src="assets/js/jquery.ui.custom.js"></script>
<script src="assets/js/bootstrap.min.js"></script> 
<script src="assets/js/jquery.uniform.js"></script> 
<script src="assets/js/select2.min.js"></script>  
<script src="assets/js/jquery.dataTables.min.js"></script>
<script src="assets/js/matrix.js"></script> 
<script src="assets/js/matrix.tables.js"></script>
<script type="text/javascript" src="assets/js/funciones.js"></script>
</head>
<script type="text/javascript">
function validarDatos(formulario, pagina){
    var Equipo 			= document.getElementById('Equipo').value;
    var Marca           = document.getElementById('Marca').value;
    var Modelo           = document.getElementById('Modelo').value;
    var Anio           = document.getElementById('Anio').value;
    var Precio           = document.getElementById('Precio').value;




    if(Equipo == null || Equipo == 0 || /^\s+$/.test(Equipo)){
        mostrarMensaje('El campo Equipo no debe ir vacío', 'error');
		return false;
    }

    if(Marca == null || Marca.length == 0 || /^\s+$/.test(Marca)){
        mostrarMensaje('El campo Marca no debe ir vacío', 'error');
        return false;
    }
    if(Modelo == null || Modelo.length == 0 || /^\s+$/.test(Modelo)){
        mostrarMensaje('El campo Modelo no debe ir vacío', 'error');
        return false;
    }
	
    if(Anio == null || Anio.length == 0 || /^\s+$/.test(Anio)){
        mostrarMensaje('El Año no debe estar en blanco', 'error');
        return false;
    }
    if (!/^([0-9])*$/.test(Anio)){
        mostrarMensaje('El valor Año no es un número', 'error');
        return false;
    }
    if(Precio == null || Precio.length == 0 || /^\s+$/.test(Precio)){
        mostrarMensaje('El Precio no debe estar en blanco', 'error');
        return false;
    }

    irA(formulario, pagina);
    var fileInput = document.getElementById('foto1');
    var filePath = fileInput.value;
    var allowedExtensions = /(.jpg|.jpeg|.png|.gif)$/i;
    if(!allowedExtensions.exec(filePath)){
        alert('Las extensiones de archivo permitidas son: .jpeg/.jpg/.png/.gif ');
        fileInput.value = '';
        return false;
    }
	
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
''************************** Fin HTTP_REFERER ******************************
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
  <h1>Mantenedor de Clientes - Publica tu Venta</h1>
</div>
<%if request.QueryString("opc")= "sav" then 
	sql="exec spMantenedorVenta_Guardar "
	sql=sql &  request.form("idVta") & " , " &_
            "" & request.form("vEquipos") & ", " &_
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

    chkIdImg = request.Form("idImg")
    arrIdImg = Split(chkIdImg, ",")
    
    For i=LBound(arrIdImg) to UBound(arrIdImg)
	    
        sql="exec spMantenedorVenta_EliminarImagen "
	    sql=sql &  arrIdImg(i) & "  "

        set rs = nothing
	    Set rs = cn.Execute(sql)

    Next
    if session ("Perfil_Administrador") = 1 then
    if request.QueryString("end") = "1" then
	%>

	<script type="text/javascript">
		//mostrarMensaje('Equipo Modificado Exitosamente.', 'success');
	    window.location = "pub_adminventa.asp?msg=1";
	    window.history.go(-2);
        //window.location = "mant_venta.asp?opc=addImg&vta=<%= request.form("idVta")%>";
	</script>
	<% else %>
    <script type="text/javascript">
		//mostrarMensaje('Equipo Modificado Exitosamente.', 'success');
        //window.location = "mant_venta.asp?msg=1";
        window.location = "mant_venta.asp?opc=addImg&vta=<%= request.form("idVta")%>";
	</script>
    <%
    end if
        else
           if request.QueryString("end") = "1" then
	%>

	<script type="text/javascript">
	    window.location = "mant_venta.asp?msg=1";
	    window.history.go(-2);
	</script>
	<% else %>
    <script type="text/javascript">
        window.location = "mant_venta.asp?opc=addImg&vta=<%= request.form("idVta")%>";
	</script>
    <%
    end if
        end if
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
		    window.location="mant_venta.asp?opc=addImg&vta=<%= rs("IdVenta")%>";
		  
		</script>
		<%
	
end if
%>
<%if request.QueryString("opc")= "del" then 
	sql="exec spMantenedorVenta_Eliminar "
	sql=sql & " " & request.form("idVta") & " "
	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		window.location="mant_venta.asp?msg=4";
	</script>
<%
end if
%>
<%if request.QueryString("opc")= "idvta" then 
	
	var_chk_sel=request.form("venta")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)
	Next 
	if i > 1 then
	%>
	<script type="text/javascript">
		window.location="mant_venta.asp?msg=5";
	</script>
<%	else
		if len(var_chk_sel) > 0 then
			Response.Redirect("mant_venta.asp?opc=edit&id="& var_chk_sel)
			Response.End
		end if
	end if
end if

if request.QueryString("opc")= "eli" then 
	
	var_chk_sel=request.form("venta")
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
			  <br>
				<label class="control-label" style=position:absolute;>Equipos :</label>
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
				<br>
            </div>
            <br>
			</div>
			<div class="control-group">
			<br>           
            <div class="form-actions">
              <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'mant_venta.asp?opc=sch');">Buscar</button>
			  <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form1_crit,'mant_venta.asp?opc=new');">Nuevo</button>
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
					sql=sql & " " & request.form("vEquipos") & ", " & session("id_usuario") & " "
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					if not rs.eof then
						do while not rs.eof
						
						%>			
						
						<tr class="gradeX">
						  <td><input type="checkbox" name="venta" id="venta" style="display: block !important;" value=<%=rs("id_venta")%> /></td>
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
            <button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'mant_venta.asp?opc=idvta');">Editar</button>
			<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'mant_venta.asp?opc=eli');">Eliminar</button>
			<!--<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form2_crit,'mant_venta.asp?opc=new');">Nuevo</button>-->
			<input name="bandera" type="hidden" id="bandera" value="1" />
		</div>
		
      </div>
    </div>
  </div>
  <%end if%>
  <%if request.QueryString("opc")="edit" then 
  	
        sql ="exec DetalleVentaMaquinaria "
        sql = sql & request.QueryString("id")
	
        set rs = nothing
        Set rs = cn.Execute(sql)
        if not rs.eof then
		vPrecio = rs("vent_equipo_precio")

  %>
  
  
	<div class="container-fluid">
   <div class="row-fluid">
    <div class="span9">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Equipos</h5>
        </div>
        <div class="widget-content nopadding">

            <script>
                $(document).ready(function(){
                 
                <% dim est 
                est =1
                if rs("vent_estado")<> True then
                    est = 0
                end if
             
                 %>
                    $("#Equipo").val("<%= rs("Id_DatosComunes") %>");
                    $("#Marca").val("<%= rs("vent_equipo_marca") %>");
                    $("#Modelo").val("<%= rs("vent_equipo_modelo") %>");
                    $("#Anio").val("<%= rs("vent_anio") %>");
                    //$("#Precio").val("<%=FormatNumber(rs("vent_equipo_precio"),0) %>");
                    $("#familia").val("<%= rs("id_region") %>");
                    $("#familia").trigger("change");
                    $("#subcatagory").val("<%= rs("id_ciudad") %>");
                    $("#Descripcion").val("<%= rs("vent_decripcion") %>");
                    $("#estado").val("<%= est %>");
                    $("#idVta").val("<%= rs("id_venta") %>");
              
                });
            </script>
           <form name="form3_crit" method="post" class="form-horizontal">
               <div class="control-group">
				<label class="control-label" style=position:absolute;>Equipo :</label>
				<div class="controls">
					<%
					sql="exec MantenedorEquipos "
					sql=sql & " 1 , -1 , '' , 0"
					set rs = nothing
					Set rs = cn.Execute(sql)
					
					%>
					<select name="vEquipos" class="span11" id="Equipo" style="color:#F7931E">
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
				<br>
            </div>
			<br>
               <div>
                <label class="control-label" style=position:absolute;>Marca :</label>
                <div class="controls">
                    <input type="text" class="span11" name="Marca" id="Marca"  />
                </div>
				<br>
            </div>
			<br>
            <div>
                <label class="control-label" style=position:absolute;>Modelo :</label>
                <div class="controls">
                    <input type="text" class="span11" name="Modelo" id="Modelo" />
                </div>
				<br>
            </div>
			<br>
            <div>
                <label class="control-label" style=position:absolute;>Año :</label>
                <div class="controls">
                    <input type="text" class="span11" name="Anio" id="Anio" />
                </div>
				<br>
            </div>
			<br>
            <div>
                <label class="control-label" style=position:absolute;>Precio :</label>
                <div class="controls">
                    <input type="text" class="span11" name="Precio"  value="<%="$" & FormatNumber((vPrecio),0)%>" onKeyUp="puntitos(this,this.value.charAt(this.value.length-1))"/>
                </div>
				<br>
            </div>
			<br>
            <div>
                                    <label class="control-label" style=position:absolute;>Región :</label>
                                    <div class="controls">
                                        <select size="1" id="familia" class="span11" name="familia" onChange="javascript:sublist(this.form, familia.value);" style="color: #3B5998; cursor: pointer;" value="<%=Ucase(vRegion)%>">
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
									<br>
                                </div>
								<br>
                                <div>
                                    <label class="control-label" style=position:absolute;>Ciudad :</label>
                                    
                                    <div class="controls">
                                        <select id="subcatagory" name="subcatagory" class="span11" style="color: #3B5998; cursor: pointer;">
                                            <option selected value="0">Ciudad</option>
                                        </select>
                                    </div>
									<br>
                                 </div>   
                                 <br>   

                <div>
                    <label class="control-label" style=position:absolute;>Descripción :</label>
                    <div class="controls">
                        <textarea rows="4" cols="50" class="span11" name="Descripcion" id="Descripcion">
                            </textarea>
                    </div>
					<br>
                </div>
				<br><br><br>

            <div class="control-group">
              <label class="control-label" style=position:absolute;>Estado :</label>
              <div class="controls">
			    <select name="estado" id="estado" class="span11">
					<option value="1">Activado</option>
					<option value="0">Desactivado</option>
				</select>
              </div>
			  <br>
			</div>
			
               <input type="hidden" name="idVta" id="idVta" value="" />

               <%
                        sql ="exec spMantenedorVenta_ListarImagenes "
						sql = sql & request.QueryString("id")    
                   
                        Set rs=nothing
					    Set rs = cn.Execute(sql)
               %>
               <table class="table-bordered" style="width:100%;">
                   <caption></caption>
                   <tr>
                       <td style="text-align:center;">seleccionar imagen a eliminar</td>
                       <td style="text-align:center;">Imagen</td>
                   </tr>

                   <% do while not rs.eof %>

                   <tr>
                       <th><input type="checkbox" name="idImg" id="idImg" value="<%= rs("id_imagen") %>" /></th>
                       <th>
                           <img src="<%= rs("url_img_chica") %>" style="width:250px;" alt="iam" />
                       </th>
                   </tr>

                   <% rs.movenext 
                      loop  %>
               </table>

			<div class="form-actions" align="center">
			<br>
				<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'mant_venta.asp?opc=sav');">Agregar Imagenes</button>
                <button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'mant_venta.asp?opc=sav&end=1&vId=<%=request.QueryString("id")%>');">Guardar y Finalizar</button>
                <button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'mant_venta.asp?opc=sav&end=1&vId=<%=request.QueryString("id")%>');">Eliminar</button>
				<!--<button type="submit" class="btn btn-success" onClick="javascript:irA(document.forms.form3_crit,'mant_venta.asp?opc=del');">Eliminar</button>-->
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
                    <input type="text" class="span11" name="Precio" id="Precio" onKeyUp="puntitos(this,this.value.charAt(this.value.length-1),0)"/>
                </div>
            </div>
            <div>
                                    <label class="control-label">Región :</label>
                                    <div class="controls">
                                        <select size="1" id="familia" class="span11" name="familia" onChange="javascript:sublist(this.form, familia.value);" style="color: #3B5998; cursor: pointer;" value="<%=Ucase(vRegion)%>">
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
				<button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form3_crit,'mant_venta.asp?opc=sav2');">Guardar y Agregar imagenes</button>
           </div>
          </form>
        </div>
      </div>
      
    </div>
  </div>
  
</div>
  <%end if%>

    <% if request.QueryString("opc")="sav_img" then 


        Function ResizeImage(FileName, OutFormat, Width, Height)  
            Dim Chs, chConstants  
            'Create an OWC chart object  
            Set Chs = CreateObject("OWC10.ChartSpace")  
    
            Set chConstants = Chs.Constants  
    
            'Set background of the chart  
            Chs.Interior.SetTextured FileName, chConstants.chStretchPlot, , chConstants.chAllFaces  
            Chs.border.color = -3  
  
            'Do something with border  
            'Chs.border.color = &H0000FF  
            'Chs.border.Weight = 3  
  
            'export the picture to a file  
            'Chs.ExportPicture OutFileName, OutFormat, Width, Height  
    
            'or return it as a binary data for BinaryWrite  
            ResizeImage = Chs.GetPicture(OutFormat, Width, Height)  
        End Function  




                ForWriting = 2
                adLongVarChar = 201
                lngNumberUploaded = 0

                'Get binary data from form 
                noBytes = Request.TotalBytes 
                binData = Request.BinaryRead (noBytes)
                'convery the binary data to a string
                Set RST = CreateObject("ADODB.Recordset")
                LenBinary = LenB(binData)

                if LenBinary > 0 Then
                RST.Fields.Append "myBinary", adLongVarChar, LenBinary
                RST.Open
                RST.AddNew
                RST("myBinary").AppendChunk BinData
                RST.Update
                strDataWhole = RST("myBinary")
                End if
                'Creates a raw data file for with all da
                ' ta sent. Uncomment for debuging. 
                'Set fso = CreateObject("Scripting.FileSystemObject")
                'Set f = fso.OpenTextFile(server.mappath(".") & "\raw.txt", ForWriting, True)
                'f.Write strDataWhole
                'set f = nothing
                'set fso = nothing
                'get the boundry indicator
                strBoundry = Request.ServerVariables ("HTTP_CONTENT_TYPE")
                lngBoundryPos = instr(1,strBoundry,"boundary=") + 8 
                strBoundry = "--" & right(strBoundry,len(strBoundry)-lngBoundryPos)
                'Get first file boundry positions.
                lngCurrentBegin = instr(1,strDataWhole,strBoundry)
                lngCurrentEnd = instr(lngCurrentBegin + 1,strDataWhole,strBoundry) - 1
                Do While lngCurrentEnd > 0
                'Get the data between current boundry an
                ' d remove it from the whole.
                strData = mid(strDataWhole,lngCurrentBegin, lngCurrentEnd - lngCurrentBegin)
                strDataWhole = replace(strDataWhole,strData,"")

                'Get the full path of the current file.
                lngBeginFileName = instr(1,strdata,"filename=") + 10
                lngEndFileName = instr(lngBeginFileName,strData,chr(34)) 
                'Make sure they selected at least one fi
                ' le. 
                if lngBeginFileName = lngEndFileName and lngNumberUploaded = 0 Then

                Response.Write "<H2> Ha ocurrido el siguiente error.</H2>"
                Response.Write "Debes elegir un archivo para subir"
                Response.Write "<BR><BR>Pulsa el botón volver, realiza la corrección."
                Response.Write "<BR><BR><INPUT type='button' onclick='history.go(-1)' value='<< Volver' id='button'1 name='button'1>"
                Response.End 
                End if

                if LenBinary > 5000000 Then

                    Response.Write "<H2> Ha ocurrido el siguiente error.</H2>"
                    Response.Write "El peso (mb) de la imagen debe ser inferior a 5 Mb " & (LenBinary)
                    Response.Write "<BR><BR>Pulsa el botón volver, realiza la corrección."
                    Response.Write "<BR><BR><INPUT type='button' onclick='history.go(-1)' value='<< Volver' id='button'1 name='button'1>"
                    Response.End 'guille123, angel123
                End if

                'There could be one or more empty file b
                ' oxes. 
                if lngBeginFileName <> lngEndFileName Then
                strFilename = mid(strData,lngBeginFileName,lngEndFileName - lngBeginFileName)
                'Creates a raw data file with data betwe
                ' en current boundrys. Uncomment for debug
                ' ing. 
                'Set fso = CreateObject("Scripting.FileSystemObject")
                'Set f = fso.OpenTextFile(server.mappath(".") & "\raw_" & lngNumberUploaded & ".txt", ForWriting, True)
                'f.Write strData
                'set f = nothing
                'set fso = nothing

                'Loose the path information and keep jus
                ' t the file name. 
                tmpLng = instr(1,strFilename,"\")
                Do While tmpLng > 0
                PrevPos = tmpLng
                tmpLng = instr(PrevPos + 1,strFilename,"\")
                Loop

                FileName = right(strFilename,len(strFileName) - PrevPos)

                'Get the begining position of the file d
                ' ata sent.
                'if the file type is registered with the
                ' browser then there will be a Content-Typ
                ' e
                lngCT = instr(1,strData,"Content-Type:")

                if lngCT > 0 Then
                lngBeginPos = instr(lngCT,strData,chr(13) & chr(10)) + 4
                Else
                lngBeginPos = lngEndFileName
                End if
                'Get the ending position of the file dat
                ' a sent.
                lngEndPos = len(strData) 

                'Calculate the file size. 
                lngDataLenth = lngEndPos - lngBeginPos
                'Get the file data 
                strFileData = mid(strData,lngBeginPos,lngDataLenth)
                'Create the file. 
                Set fso = CreateObject("Scripting.FileSystemObject")
                dim url_imagen, url_directorio, url_web
                url_imagen = Server.MapPath(".") & "\upload\ventas\" & request.QueryString("vta") & "\" & FileName
                url_directorio = Server.MapPath(".") & "\upload\ventas\" & request.QueryString("vta") & "\"
                url_web = "upload/ventas/" & request.QueryString("vta") & "/" & FileName

                if fso.FolderExists(url_directorio)=false then
                    'response.Write("NoExiste:Folder:[" & url_directorio & "]")
                    f=fso.CreateFolder(url_directorio)
                    set f=nothing
                end if   

                Set f = fso.OpenTextFile( url_imagen , ForWriting, True)
                f.Write strFileData
                Set f = nothing
                Set fso = nothing

                lngNumberUploaded = lngNumberUploaded + 1

                'guarda bd

                sql="exec spMantenedorVenta_GuardarImagen "
                sql=sql & request.QueryString("vta") & " ,"
                sql=sql & " '" & url_web & "', "
                sql=sql & " '" & url_web & "' "
                

                'response.Write(sql)
                set rs = nothing
                Set rs = cn.Execute(sql)

                End if

                'Get then next boundry postitions if any
                ' .
                lngCurrentBegin = instr(1,strDataWhole,strBoundry)
                lngCurrentEnd = instr(lngCurrentBegin + 1,strDataWhole,strBoundry) - 1
                loop

        
if session ("Perfil_Administrador") = 1 then

        if request.QueryString("end")="1" then
            %>
                <script>
                    window.location = "pub_adminventa.asp?msg=1"
                </script>
            <%
        else %>
                <script>
                    window.location = "mant_venta.asp?opc=addImg&vta=<%= request.QueryString("vta") %>"
                </script>
        <% end if
            else
   if request.QueryString("end")="1" then
            %>

                <form name="from_redirect" action="#" method="post" style="display:none;"> 
                    <select name="vEquipos">
						<option value="-1" selected="selected">SELECCIONE EQUIPO</option>
                    </select>
                </form>
    
                <script>
                    javascript:irA(document.forms.from_redirect,'mant_venta.asp?opc=sch');
                </script>
            <%
        else %>
                <script>
                    window.location = "mant_venta.asp?opc=addImg&vta=<%= request.QueryString("vta") %>"
                </script>
        <% end if
            end if






             end if %>
    <%if request.QueryString("opc")="addImg" then%>


    <script>
	function ShowImagePreview( files )
	{
		if( !( window.File && window.FileReader && window.FileList && window.Blob ) )
		{
		  alert('The File APIs are not fully supported in this browser.');
		  return false;
		}

		if( typeof FileReader === "undefined" )
		{
			alert( "Filereader undefined!" );
			return false;
		}

		var file = files[0];

		if( !( /image/i ).test( file.type ) )
		{
			alert( "File is not an image." );
			return false;
		}
        
		reader = new FileReader();
		reader.onload = function(event) 
				{ var img = new Image; 
				  img.onload = UpdatePreviewCanvas; 
				  img.src = event.target.result;  }
		reader.readAsDataURL( file );
	}

	function UpdatePreviewCanvas()
	{
        var img = this;

        console.log(img)
		var canvas = document.getElementById( "previewcanvas" );
        console.log(canvas);


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


	<div class="container-fluid">
   <div class="row-fluid">
    <div class="span9">
      <div class="widget-box">
        <div class="widget-title"> <span class="icon border-blue"> <i class="icon-align-justify"></i> </span>
          <h5>Equipos en Venta</h5>
        </div>
        <div class="widget-content nopadding">
           <form name="form3_crit" method="post" class="form-horizontal" enctype="multipart/form-data">
              

           <div>
                <label class="control-label">Imagenes :</label>
                <div class="controls">
                    <div>
                        <canvas id="previewcanvas"></canvas>
                        <input type="file" name="file1" onChange="return ShowImagePreview( this.files );" />
                    </div>

                   
                </div>
            </div>


			<div class="form-actions">
				<button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form3_crit,'mant_venta.asp?opc=sav_img&vta=<%=  request.QueryString("vta") %>');">Guardar y Agragar Otra</button>
                <button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form3_crit,'mant_venta.asp?opc=sav_img&end=1&vta=<%=  request.QueryString("vta") %>');">Guardar y Finalizar</button>
                <button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.form3_crit,'mant_venta.asp?opc=sav_img&end=1&vta=<%=  request.QueryString("vta") %>');">Eliminar</button>
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

<script type="text/javascript">
	$(document).ready(function(){
		var mensaje = $.getURLParam("msg");
		if (mensaje != null) {
			if (mensaje == 1) {
				mostrarMensaje('Venta Modificado Exitosamente.', 'success');
			} else if (mensaje == 2) {
				mostrarMensaje('Venta Agregado Exitosamente.', 'success');
			} else if (mensaje == 3) {
				mostrarMensaje('Este equipo ya existe con este nombre.', 'error');
			} else if (mensaje == 4) {
				mostrarMensaje('Equipo Eliminado Exitosamente.', 'success');
			} else if (mensaje == 5) {
				mostrarMensaje('Debe seleccionar solo un equipo.', 'success');
			}
		}
	});
	
function puntitos(donde,caracter,campo)
{
var decimales = true
dec = campo
pat = /[\*,\+,\(,\),\?,\\,\$,\[,\],\^]/
valor = donde.value
largo = valor.length
crtr = true
if(isNaN(caracter) || pat.test(caracter) == true)
	{
	if (pat.test(caracter)==true) 
		{caracter = "\\" + caracter}
	carcter = new RegExp(caracter,"g")
	valor = valor.replace(carcter,"")
	donde.value = valor
	crtr = false
	}
else
	{
	var nums = new Array()
	cont = 0
	for(m=0;m<largo;m++)
		{
		if(valor.charAt(m) == "." || valor.charAt(m) == " " || valor.charAt(m) == ",")
			{continue;}
		else{
			nums[cont] = valor.charAt(m)
			cont++
			}
		
		}
	}

if(decimales == true) {
	ctdd = eval(1 + dec);
	nmrs = 1
	}
else {
	ctdd = 1; nmrs = 3
	}
var cad1="",cad2="",cad3="",tres=0
if(largo > nmrs && crtr == true)
	{
	for (k=nums.length-ctdd;k>=0;k--){
		cad1 = nums[k]
		cad2 = cad1 + cad2
		tres++
		if((tres%3) == 0){
			if(k!=0){
				cad2 = "." + cad2
				}
			}
		}
		
	for (dd = dec; dd > 0; dd--)	
	{cad3 += nums[nums.length-dd] }
	//if(decimales == true)
	//{cad2 += "," + cad3}
	 donde.value = cad2
	}
donde.focus()
}	
</script>
	
</script>
</body>
</html>
