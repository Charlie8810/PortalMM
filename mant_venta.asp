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
    function validarDatos(formulario, pagina) {
        var Nombre = document.getElementById('Nombre').value;

        if (Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)) {
            mostrarMensaje('El campo Nombre no debe ir vacío', 'error');
            return false;
        }

        irA(formulario, pagina);

    }
</script>
<script type="text/javascript">
    function validarDatos(formulario, pagina){
        var Marca 			= document.getElementById('Marca').value;
        var Modelo 			= document.getElementById('Modelo').value;
        var Anio 	        = document.getElementById('Anio').value;
        var Precio	        = document.getElementById('Precio').value;
        var Descripcion	    = document.getElementById('Descripcion').value;

        if(Marca == null || Marca.length == 0 || /^\s+$/.test(Marca)){
            mostrarMensaje('El campo Marca no debe ir vacío', 'error');
            return false;
        }
      
        if(Modelo == null || Modelo.length == 0 || /^\s+$/.test(Modelo)){
            mostrarMensaje('La Modelo no debe estar en blanco', 'error');
            return false;
        }
        if(Anio == null || Anio.length == 0 || /^\s+$/.test(Anio)){
            //alert('ERROR: El Rubro no debe estar en blanco');
            mostrarMensaje('El Año no debe estar en blanco', 'error');
            return false;
        }
        if(Precio == null || Precio.length == 0 || /^\s+$/.test(Precio)){
            mostrarMensaje('El Precio de contacto no debe estar en blanco', 'error');
            return false;
        }
        if(Descripcion == null || Descripcion.length == 0 || /^\s+$/.test(Descripcion)){
            mostrarMensaje('El Descripción de contacto no debe estar en blanco', 'error');
            return false;
        }    
        irA(formulario, pagina);
	
    }
</script>
<script language="JavaScript">
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
                <button type="button" class="close" data-dismiss="modal" onclick="ocultarMessage()" aria-hidden="true">×</button>
                <br />
                <p>message</p>
            </div>
            <div id="breadcrumb"><a href="index.asp" title="Go to Home" class="tip-bottom" style="color: #666666"><i class="icon-home"></i>Inicio</a></div>
            <h1>Mantenedor de Ventas</h1>
        </div>
   
        <div class="container-fluid">
            <hr>
            <div class="row-fluid">
                <div class="span12">
                    <div class="widget-box">
                        <div class="widget-title">
                            <span class="icon border-blue"><i class="icon-align-justify"></i></span>
                            <h5>Mantenedor de Ventas</h5>
                        </div>
                        <div class="widget-content nopadding">
                            <form name="form3_crit" method="post" class="form-horizontal" enctype="multipart/form-data">
                                <div>
                                    <label class="control-label">Equipo :</label>
                                    <div class="controls">
                                        <%
							sql ="exec Seleccionar_Datos_Comunes "
							sql = sql & "1 "
							Set rs=nothing
							Set rs = cn.Execute(sql)
                                        %>
                                        <select name="equipo" id="equipo" style="font-weight: bold; color: #3B5998; cursor: pointer;" value="">
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
                                    </div>
                                </div>
                                <div>
                                    <label class="control-label">Marca :</label>
                                    <div class="controls">
                                        <input type="text" class="span11" name="Marca" id="Marca" value="<%=vMarca%>" />
                                    </div>
                                </div>
                                <div>
                                    <label class="control-label">Modelo :</label>
                                    <div class="controls">
                                        <input type="text" class="span11" name="Modelo" id="Modelo" value="<%=vModelo%>" />
                                    </div>
                                </div>
                                <div>
                                    <label class="control-label">Año :</label>
                                    <div class="controls">
                                        <input type="text" class="span11" name="Anio" id="Anio" value="<%=vAnio%>" />
                                    </div>
                                </div>
                                <div>
                                    <label class="control-label">Precio :</label>
                                    <div class="controls">
                                        <input type="text" class="span11" name="Precio" id="Precio" value="<%=vPrecio%>" />
                                    </div>
                                </div>
                                <div>
                                    <label class="control-label">Región :</label>
                                    <%if vRegion = "" then%>
                                    <div class="controls">
                                        <select size="1" id="familia" class="span11" name="familia" onchange="javascript:sublist(this.form, familia.value);" style="color: #3B5998; cursor: pointer;" value="<%=Ucase(vRegion)%>">
                                            <option selected value="0">Región</option>
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
                                        <select name="familia" id="Select1" class="span11" style="color: #3B5998; cursor: pointer;" value="<%=vRegion%>">
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
                                        <select id="subcatagory" name="subcatagory" class="span11" style="color: #3B5998; cursor: pointer;" value="<%=Ucase(vCiudad)%>">
                                            <option selected value="0">Ciudad</option>
                                        </select>
                                    </div>
                                    <%else%>
                                    <div class="controls">
                                        <%
				sql ="exec Seleccionar_Datos_Comunes "
				sql = sql & "4 "
				Set rs=nothing
				Set rs = cn.Execute(sql)
                                        %>
                                        <select name="subcatagory" id="Select2" class="span11" style="color: #3B5998; cursor: pointer;" value="<%=vCiudad%>">
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
                                    <label class="control-label">Descripción :</label>
                                    <div class="controls">
                                        <textarea rows="4" cols="50" class="span11" name="Descripcion" id="Descripcion" value="<%=vDescripcion%>">
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
                                <div class="form-actions">
                                    <div class="form-actions">
                                        <button type="button" class="btn btn-success" onclick="javascript:validarDatos(document.forms.form3_crit,'mant_eq.asp?opc=sav');">Guardar</button>
                                        <button type="submit" class="btn btn-success" onclick="javascript:irA(document.forms.form3_crit,'mant_eq.asp?opc=del');">Eliminar</button>
                                    </div>

                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    </div>

    <!--Footer-part-->
    <div class="row-fluid">
        <div id="footer" class="span12">2017 &copy; Desarrollado por Go4 <a href="http://www.gofour.cl">Gofour.cl</a> </div>
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
        $(document).ready(function () {
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
