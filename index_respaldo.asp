<!--#include file="con_app.asp"-->
<!DOCTYPE HTML>
<!--
	Alpha by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<!-- [Renato] : Se comenta llamada de hoja de estilo, ya que no existe. -->
		<!-- <link rel="stylesheet" type="text/css" href="estilo.css" /> --> 
		
		<link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
		<link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
		<link href="assets/css/style.css" rel="stylesheet" />
		<link rel="icon" type="image/png" href="./images/icon.ico" />
		<title>Mundo Maquinaria</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->

		<!-- Start of Smartsupp Live Chat script -->
		<script type="text/javascript">
		var _smartsupp = _smartsupp || {};
		_smartsupp.key = '325d9ce18c74a61710046c22436180a0f9d14ad5';
		window.smartsupp||(function(d) {
			var s,c,o=smartsupp=function(){ o._.push(arguments)};o._=[];
			s=d.getElementsByTagName('script')[0];c=d.createElement('script');
			c.type='text/javascript';c.charset='utf-8';c.async=true;
			c.src='//www.smartsuppchat.com/loader.js?';s.parentNode.insertBefore(c,s);
		})(document);
		</script>
	</head>
	<!-- 	Validaciones JavaScript	-->
	<script type="text/javascript">
function validar_envio(formulario, pagina){

	var Rut 				= document.getElementById('textfield').value;
	var Nombre 				= document.getElementById('textfield2').value;
	var Mail 				= document.getElementById('textfield3').value;
	var NombreContacto 		= document.getElementById('textfield4').value;
	var TelefonoContacto 	= document.getElementById('textfield5').value;

		// Patron para el correo
	var expr
	expr =/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/;
	
	if(Rut == null || Rut.length == 0 || /^\s+$/.test(Rut)){
			alert('ERROR: El campo Rut no debe ir vacío');
			return false;
		}
	if(Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)){
			alert('ERROR: El campo Nombre no debe ir vacío');
			return false;
		}
	if(Mail == null || Mail.length == 0 || /^\s+$/.test(Mail)){
			alert('ERROR: El campo Mail no debe ir vacío');
			return false;
		}
	if(NombreContacto == null || NombreContacto.length == 0 || /^\s+$/.test(NombreContacto)){
			alert('ERROR: El campo NombreContacto no debe ir vacío');
			return false;
		}
	if(TelefonoContacto == null || TelefonoContacto.length == 0 || /^\s+$/.test(TelefonoContacto)){
			alert('ERROR: El campo TelefonoContacto no debe ir vacío');
			return false;
		}
		irA(formulario, pagina);
	
}
</script>
<!--  Ejecuciones sobre botones  -->
<%
if request.QueryString("est") = "1" then
	
	sql="Exec Inserta_Cotizacion "
		sql=sql & request.Form("tipo") & ", "     	 'tipo 
		sql=sql & request.Form("equipo") & ", "      'equipo
		sql=sql & request.Form("familia") & ", " 	 'region
		sql=sql & request.Form("subcatagory") & ", " 'ciudad
		sql=sql & 0 & ", "							 'operador
		'if request.Form("operador") = "" then
		'	sql=sql & 0 & ", "
		'else	
		'	sql=sql & request.Form("operador") & ", "
		'end if
		sql=sql & 0 & ", "							 'combustible
		'if request.Form("combustible") = "" then
		'	sql=sql & 0 & ", "
		'else
		'	sql=sql & request.Form("combustible") & ", "
		'end if
		sql=sql & 0 & ", "							 'traslados
		'if request.Form("traslados") = "" then
		'	sql=sql & 0 & ", "
		'else
		'	sql=sql & request.Form("traslados") & ", "
		'end if
		sql=sql & " '" & request.Form("mensaje") & "', "
		sql=sql & " '" & request.Form("textfield") & "', "
		sql=sql & " '" & request.Form("textfield4") & "', "
		sql=sql & " '" & request.Form("textfield3") & "', "
		sql=sql & " '" & request.Form("textfield5") & "', "
		sql=sql & " '" & request.Form("textfield2") & "' "
		
		set Rs = nothing
		Set Rs = cn.Execute(sql)
	
	%>
		<script type="text/javascript">
			alert("Cotizacion agegada exitosamente.");
			window.location="index.asp?rut=<%=request.Form("textfield")%>";
		</script>
		<%
end if
%>
<%
	sql="exec ListarDatosUsuarioPorRut "
	sql=sql & " '" & request.QueryString("rut") & "' "

	set Rs = nothing
	Set Rs = cn.Execute(sql)
	if not rs.eof then

		vRut			= rs("rut")
		vNombre			= rs("nombre")
		vMail			= rs("mail")
		vTelefono		= rs("telefono")

	end if
%>
	<body class="landing">
		<div id="page-wrapper">

			<!-- Header -->
				<header id="header" class="alt">
					
					<h1><a href="index.html"><img src="./images/logo_chico.png" /></a></h1>
					<nav id="nav">
								
						<ul>
							<!-- [Renato] : Inicio -->
							<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve" viewBox="0 0 50 50" x="0px" y="0px" width="32px" height="32px" enable-background="new 0 0 50 50" class="svg-icon-user">
								<circle class="svg-icon-user-c" cx="25" cy="25" fill="none" r="24" stroke="#f7931e" stroke-linecap="round" stroke-miterlimit="10" stroke-width="2"></circle>
								<path class="svg-icon-user-p" d="M29.933,35.528c-0.146-1.612-0.09-2.737-0.09-4.21c0.73-0.383,2.038-2.825,2.259-4.888c0.574-0.047,1.479-0.607,1.744-2.818  c0.143-1.187-0.425-1.855-0.771-2.065c0.934-2.809,2.874-11.499-3.588-12.397c-0.665-1.168-2.368-1.759-4.581-1.759  c-8.854,0.163-9.922,6.686-7.981,14.156c-0.345,0.21-0.913,0.878-0.771,2.065c0.266,2.211,1.17,2.771,1.744,2.818  c0.22,2.062,1.58,4.505,2.312,4.888c0,1.473,0.055,2.598-0.091,4.21c-1.261,3.39-7.737,3.655-11.473,6.924  c3.906,3.933,10.236,6.746,16.916,6.746s14.532-5.274,15.839-6.713C37.688,39.186,31.197,38.93,29.933,35.528z" 
									fill="#f7931e">
								</path>
							</svg>
							<!-- [Renato] : Fin -->
							<li>
								<button class="button btn-entrar" style="background:#3B5998" data-toggle="modal" data-target="#myModal1">
								ENTRAR
							</button>
							<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<script type="text/javascript">
								function validacion(formulario, pagina)
								{
									if(formulario.textfield.value=="" || formulario.textfield2.value=="" )
									{
										alert("Para Continuar debe Completar los datos de Ingreso");
										return false;
									}
									
										irA(formulario, pagina);
									
								}
							</script>
								<form name="formLogin" method="post" >
								<div class="modal-dialog">
								
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">Inicio Sesión</h4>
										</div>
										<div class="modal-body">
											<div class="form-group">
											<label>Rut</label>
											<input class="form-control text-box-modal" type="text" name="user_rut" pattern="[0-9]|k"/>
										</div>
										<div class="form-group">
											<label>Contraseña</label>
											<input class="form-control text-box-modal" type="password" name="passw"/>
										</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-modal" onClick="javascript:validacion(document.forms.formLogin,'login2.asp?opc=in');">Ingresar</button>
										</div>
									</div>
									
								</div>
								</form>
							</div>
							</li>
							<li><a href="#" class="button" style="background:#F7931E">PUBLICA TU MAQUINA AQUÍ</a></li>
						</ul>
					</nav>
					<!-- [Renato] : Inicio -->
					<nav id="nav2" style="display: none;"></nav>
					<!-- [Renato] : Fin -->
				</header>

			<!-- Banner -->
				<section id="banner">
					<h2>La maquina que buscas está aquí</h2>
					<p>Maquinarias en arriendo, venta y servicio técnico.</p>
					
					<ul class="actions">
						<form name="formCotizacion" method="post" >
						<nav id="nav1"><!-- [Renato] : Se cambia "id" para copiar el contenido innerHtml y replicar en el header. -->
						<ul>
						
							<li>
								<div class="select-wrapper">
									<%
									sql ="exec Seleccionar_Datos_Comunes "
									sql = sql & "2 "
									Set rs=nothing
									Set rs = cn.Execute(sql)
									%>
									<select name="tipo" id="tipo" style="font-weight:bold; color:#3B5998" value="<%=vTipo%>">
										<%
										if not rs.eof then
											do while not rs.eof
												if cdbl(rs("Id_DatosComunes")) = cdbl(vDescrip) then
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
							</li>
							<li>
								<div class="select-wrapper">
									<%
									sql ="exec Seleccionar_Datos_Comunes "
									sql = sql & "1 "
									Set rs=nothing
									Set rs = cn.Execute(sql)
									%>
									<select name="equipo" id="equipo" style="font-weight:bold; color:#3B5998" value="<%=vEquipo%>">
										<%
										response.write "<option value=0>EQUIPO</option>"
										if not rs.eof then
											do while not rs.eof
												if cdbl(rs("Id_DatosComunes")) = cdbl(vDescrip) then
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
							</li>
							<li>
	<div class="select-wrapper">		
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

			<select size="1" id="familia" name="familia" onChange = "javascript:sublist(this.form, familia.value);" style="font-weight:bold; color:#3B5998; height: 3em;" value="<%=vRegion%>">

			<option selected value = "0">Region</option>
			<%familias_Sql = "SELECT Id_DatosComunes, Descripcion FROM Datos_Comunes WHERE Tipo = 3 and Nivel = 1 and Estado = 1"
			Set rs=nothing
			Set rs = cn.Execute(familias_Sql)
			do while not rs.eof
			%>
			<option value="<%=rs("Id_DatosComunes")%>"><%=rs("Descripcion")%></option>


			<%rs.movenext
			loop
			%>
		</select>
	</div>
	</li>
	<li>
	<div class="select-wrapper">
		<SELECT id="subcatagory" name="subcatagory" size="1" style="font-weight:bold; color:#3B5998; height: 3em; width: 8em;" value="<%=vCiudad%>">
			<Option selected value="0">Ciudad</option>
		</SELECT>
	</div>		
	</li>
							<li>
                                                                <div class="btn-header">
								<button type="button" class="button" style="background:#F7931E" data-toggle="modal" data-target="#myModal2">
									COTIZAR
								</button>
                                                                </div>
								<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
									
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">Cotizar</h4>
											</div>
											<div class="modal-body ">
												<div class="form-group">
													<label>RUT</label>
													<input class="form-control text-box-modal" type="text" style="color:#F7931E"id ="textfield" name="textfield" value="<%=vRut%>"/>
												</div>
												<div class="form-group">
													<label>RAZÓN SOCIAL / NOMBRE</label>
													<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="textfield2" name="textfield2" value="<%=vNombre%>"/>
												</div>
												<div class="form-group">
													<label>CORREO</label>
													<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="textfield3" name="textfield3" value="<%=vMail%>"/>
												</div>
												<div class="form-group">
													<label>NOMBRE CONTACTO</label>
													<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="textfield4" name="textfield4" value="<%=vNombre%>"/>
												</div>
												<div class="form-group">
													<label>TELÉFONO CONTACTO</label>
													<input class="form-control text-box-modal" type="text" style="color:#F7931E" id="textfield5" name="textfield5" value="<%=vTelefono%>"/>
												</div>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-modal" style="background:#F7931E" onClick="javascript:validar_envio(document.forms.formCotizacion,'index.asp?est=1');">Cotizar</button>
												
												
											</div>
									</div>
										
									</div>
								</div>
	<!-- POPUP-->			</li>

							<li>
								<div class="col-md-10 col-sm-3 col-xs-6">
								  <div class="form-group">
										<a data-toggle="modal" data-target="#myModal4" class="btn carrito" >
											<!-- <img src="./images	/carrito.jpg" style="CURSOR: hand"> -->
											<span class="glyphicon glyphicon-shopping-cart"></span>
										</a>
										<div class="modal fade" id="myModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
											<!--<form name="formContact3" method="post" >-->
											<div class="col-md-12">
											 <!--   Basic Table  -->
											<div class="panel panel-default">
												<div class="panel-heading">
													Listado de Solicitud de Cotizacion
												</div>
												<div class="panel-body">
													<div class="table-responsive">
														<table class="table">
															<thead>
																<tr>
																	<th>Opc</th>
																	<th>Tipo Cotiza</th>
																	<th>Equipo</th>
																	<th>Region</th>
																	<th>Ciudad</th>
																	<th>Rut</th>
																	<th>Nombre</th>
																	<th>Email</th>
																	<th>Telefono</th>
																</tr>
															</thead>
															<tbody>
															<%
														
															sql="exec ListarCotizacionPorUsuario "
															sql=sql & " '" & vRut & "' "                       
response.write(sql)
'response.end()															
															
															set rs = nothing
															Set rs = cn.Execute(sql)
														
															if not rs.eof then
																Do while not rs.eof
																
																vIdCotiza 		= rs("Id_Cotiza")
																vIdTipoCotiza 	= rs("Id_Tipo_Cotiza")
																vIdEquipo		= rs("Id_Equipo")
																vIdRegion		= rs("Id_Region")
																vIdCiudad		= rs("Id_Ciudad")
																vRut			= rs("rut")
																vNombre			= rs("nombre")
																vMail			= rs("mail")
																vTelefono		= rs("telefono")
																
																%>	
																<tr>
																	<td><input type="checkbox" name="Id_Cotiza" id="Id_Cotiza" style="color:#3B5998" value=<%=rs("Id_Cotiza")%>  /></td>
																	<%
																	  sql="exec BuscaNombreTipoDato "
																	  sql=sql & " " & rs("Id_Tipo_Cotiza") & " "
																	  set rs1 = nothing
																	  Set rs1 = cn.Execute(sql)
																	  %>
																	<td style="color:#F7931E"><%=rs1("Descripcion") 
																	%></td>
																	
																	<%
																	  sql="exec BuscaNombreTipoDato "
																	  sql=sql & " " & rs("Id_Equipo") & " "
																	  set rs1 = nothing
																	  Set rs1 = cn.Execute(sql)
																	  %>
																	<td style="color:#F7931E"><%=rs1("Descripcion")
																	%>
																	
																	<%
																	  sql="exec BuscaNombreTipoDato "
																	  sql=sql & " " & rs("Id_Region") & " "
																	  set rs1 = nothing
																	  Set rs1 = cn.Execute(sql)
																	  %>
																	<td style="color:#3B5998"><%=rs1("Descripcion") 
																	%></td>
																	
																	<%
																	  sql="exec BuscaNombreTipoDato "
																	  sql=sql & " " & rs("Id_Ciudad") & " "
																	  set rs1 = nothing
																	  Set rs1 = cn.Execute(sql)
																	  %>
																	<td style="color:#3B5998"><%=rs1("Descripcion") 
																	%></td>
																	<td style="color:#3B5998"><%=vRut%></td>
																	<td style="color:#3B5998"><%=vNombre%></td>
																	<td style="color:#3B5998"><%=vMail%></td>
																	<td style="color:#3B5998"><%=vTelefono%></td>
																</tr>
															<%
																rs.movenext
															
																loop
															end if
															%>
															
															</tbody>
														</table>
														<button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.formCotizacion,'index.asp?est=5&rut=<%=vRut%>');">Enviar a Cotizar</button>
														<button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.formCotizacion,'index.asp?est=4');">ELIMINAR</button>
														<button type="button" class="btn btn-success" onClick="javascript:irA(document.forms.formCotizacion,'index.asp?rut=<%=vRut%>#marco');">Agregar</button>
													</div>
												</div>
											</div>
											  <!-- End  Basic Table  -->
										</div>
										<!--</form>-->
										</div>
									</div>
								 </div>
							</li>
		</form>
						</ul>
					
					</nav>
				
					</ul>
					
				</section>

			<!-- Main -->
				<section id="main" class="container">

					<section class="box special features">
						<div class="13u 10u(narrower)">
							<section>
								 <div >
                    <div id="carousel-example" class="carousel slide slide-bdr" data-ride="carousel" >
                   
                    <div class="carousel-inner">
                        <div class="item active">

                            <img src="assets/img/4.jpg" alt="" />
                           
                        </div>
                        <div class="item">
                            <img src="assets/img/5.jpg" alt="" />
                          
                        </div>
                        <div class="item">
                            <img src="assets/img/7.jpg" alt="" />
                           
                        </div>
                    </div>
                    <!--INDICATORS-->
                     <ol class="carousel-indicators">
                        <li data-target="#carousel-example" data-slide-to="0" class="active"></li>
                        <li data-target="#carousel-example" data-slide-to="1"></li>
                        <li data-target="#carousel-example" data-slide-to="2"></li>
                    </ol>
                    <!--PREVIUS-NEXT BUTTONS-->
                     <a class="left carousel-control" href="#carousel-example" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left"></span>
  </a>
  <a class="right carousel-control" href="#carousel-example" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right"></span>
  </a>
                </div>
              </div>
							
							</section>
						</div>
						
						<div class="features-row" >
							<section style="border-style: solid; border-width: 1px;">
								<span class="icon major fa-cloud accent4"></span>
								<h3>Cuadro N°2</h3>
								<p>*</p>
							</section >
							<section style="border-style: solid; border-width: 1px;">
								<span class="icon major fa-lock accent5"></span>
								<h3>Cuadro N°3</h3>
								<p>*</p>
							</section>
						</div>
					</section>

					<div class="row">
						<div class="3u 3u(narrower)">

							<section class="box special">
								<span><img src="images/privacidad.jpg" alt="" /></span>
								<h4>Privacidad</h4>
								<ul class="actions">
									<button class="button fit small" style="background:#F7931E" data-toggle="modal" data-target="#myModal3">
								LEER
							</button>
							<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<form name="formLogin" method="post" >
								<div class="modal-dialog">
								
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">Privacidad</h4>
										</div>
										<div class="modal-body">
											<div class="form-group">
												<label>RUT</label>
												<input class="form-control" type="text" style="color:#F7931E" name="textfield"/>
											</div>
										</div>
									</div>
									
								</div>
								</form>
							</div>
								</ul>
							</section>

						</div>
						<div class="3u 3u(narrower)">

							<section class="box special">
								<span><img src="images/cont.png" alt="" /></span>
								<h4>Contacto</h4>
								<ul class="actions">
									<button class="button fit small" style="background:#F7931E" data-toggle="modal" data-target="#myModal4">
								ENVIAR
							</button>
							<div class="modal fade" id="myModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<form name="formLogin" method="post" >
								<div class="modal-dialog">
								
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">CONTACTO</h4>
										</div>
										<div class="modal-body">
											<div class="form-group">
												<label>RUT</label>
												<input class="form-control" type="text" style="color:#F7931E" name="textfield"/>
											</div>
											<div class="form-group">
												<label>RAZ�N SOCIAL / NOMBRE</label>
												<input class="form-control" type="text" style="color:#F7931E" name="textfield2"/>
											</div>
											<div class="form-group">
												<label>CORREO</label>
												<input class="form-control" type="text" style="color:#F7931E" name="textfield2"/>
											</div>
											<div class="form-group">
												<label>NOMBRE CONTACTO</label>
												<input class="form-control" type="text" style="color:#F7931E" name="textfield2"/>
											</div>
											<div class="form-group">
												<label>TEL�FONO CONTACTO</label>
												<input class="form-control" type="text" style="color:#F7931E" name="textfield2"/>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="button" style="background:#F7931E" onClick="javascript:validacion(document.forms.formLogin,'login2.asp?opc=in');">Ingresar</button>
										</div>
									</div>
									
								</div>
								</form>
							</div>
								</ul>
							</section>

						</div>
						<div class="3u 3u(narrower)">

							<section class="box special">
								<span><img src="images/termuso.jpg" alt="" /></span>
								<h4>Términos de Uso</h4>
								<ul class="actions">
									<button class="button fit small" style="background:#F7931E" data-toggle="modal" data-target="#myModal5">
								LEER
							</button>
							<div class="modal fade" id="myModal5" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<form name="formLogin" method="post" >
								<div class="modal-dialog">
								
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<!--<h4 class="modal-title" id="myModalLabel">LEER</h4>-->
										</div>
										<div class="modal-body">
											<div class="form-group">
												<label>RUT</label>
												<input class="form-control" type="text" style="color:#F7931E" name="textfield"/>
											</div>
										</div>
									</div>
									
								</div>
								</form>
							</div>
								</ul>
							</section>

						</div>
						<div class="3u 3u(narrower)">

							<section class="box special">
								<span><img src="images/quienessomos.png" alt="" /></span>
								<h4>Quiénes Somos</h4>
								<ul class="actions">
									<button class="button fit small" style="background:#F7931E" data-toggle="modal" data-target="#myModal5">
								LEER
							</button>
							<div class="modal fade" id="myModal5" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<form name="formLogin" method="post" >
								<div class="modal-dialog">
								
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<!--<h4 class="modal-title" id="myModalLabel">LEER</h4>-->
										</div>
										<div class="modal-body">
											<div class="form-group">
												<label>RUT</label>
												<input class="form-control" type="text" style="color:#F7931E" name="textfield"/>
											</div>
										</div>
									</div>
									
								</div>
								</form>
							</div>
								</ul>
							</section>

						</div>
					</div>

				</section>

			<!-- Footer -->
				<footer id="footer">
					<ul class="icons">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<li><a href="https://twitter.com/mundomaquinaria" class="icon fa-twitter" ><span class="label">Twitter</span></a></li>
						<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
						<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
						<section><img src="images/qr_img.png" style="float:right;">&nbsp;&nbsp;&nbsp;&nbsp;</section>
					</ul>
					<ul class="copyright">
						<li>&copy; Todos los derechos reservados.</li><li>Diseñado por: <a href="http://gofour.cl">Go Four</a></li>
					</ul>
					
				</footer>

		</div>

		<!-- Scripts -->
			<script src="assets/js/jquery-1.10.2.js"></script>
			<script src="assets/js/bootstrap.js"></script>
			<script src="assets/js/custom.js"></script>
			
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.dropotron.min.js"></script>
			<script src="assets/js/jquery.scrollgress.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>
			<script type="text/javascript" src="assets/js/funciones.js"></script>

	</body>
</html>