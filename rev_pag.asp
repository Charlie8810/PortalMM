<!--#include file="con_app.asp"-->
<%
Response.CodePage = 65001
Response.CharSet = "utf-8"
%>
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
<link rel="stylesheet" href="assets/css/style.css" />
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
		mostrarMensaje('El campo Nombre no debe ir vacío', 'error');
		return false;
	}
	if(Rut == null || Rut.length == 0 || /^\s+$/.test(Rut)){
		mostrarMensaje('El Rut no debe ir vacío', 'error');
		return false;
	}
	if(DV == null || DV.length == 0 || /^\s+$/.test(DV)){
		mostrarMensaje('El DV no debe ir vacío', 'error');
		return false;
	}
	if(Direccion == null || Direccion.length == 0 || /^\s+$/.test(Direccion)){
		mostrarMensaje('La Dirección no debe estar en blanco', 'error');
		return false;
	}
	if(Rubro == null || Rubro.length == 0 || /^\s+$/.test(Rubro)){
		mostrarMensaje('El Rubro no debe estar en blanco', 'error');
		return false;
	}
	if(NomContacto == null || NomContacto.length == 0 || /^\s+$/.test(NomContacto)){
		mostrarMensaje('El Nombre de contacto no debe estar en blanco', 'error');
		return false;
	}
	if(MailContacto == null || MailContacto.length == 0 || /^\s+$/.test(MailContacto)){
		mostrarMensaje('El Mail de Contacto no debe estar en blanco', 'error');
		return false;
	}
	expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if ( !expr.test(MailContacto) ){
        mostrarMensaje('La dirección de correo "' + MailContacto + '" es incorrecta.', 'error');
		return false;
		}
	if(TelefonoContacto == null || TelefonoContacto.length == 0 || /^\s+$/.test(TelefonoContacto)){
		mostrarMensaje('El Teléfono de Contacto no debe estar en blanco', 'error');
		return false;
	}
	if (!/^([0-9])*$/.test(TelefonoContacto)){
      mostrarMensaje('El valor "' + TelefonoContacto + '" no es un número', 'error');
	  return false;
	}
	/*	var expresionRegular1=/^([0-9]+){9}$/;
	if (!expresionRegular1.test(TelefonoContacto.value)) {
		mostrarMensaje("Escribe un mínimo de 9 digitos como teléfono");
		return (false);
	}*/
	if(CargoContacto == null || CargoContacto.length == 0 || /^\s+$/.test(CargoContacto)){
		mostrarMensaje('El Cargo de Contacto no debe estar en blanco', 'error');
		return false;
	}
	if(MailCotizacion == null || MailCotizacion.length == 0 || /^\s+$/.test(MailCotizacion)){
		mostrarMensaje('El Mail de Cotización no debe estar en blanco', 'error');
		return false;
	}
    if ( !expr.test(MailCotizacion) ){
        mostrarMensaje('La dirección de correo "' + MailCotizacion + '" es incorrecta.', 'error');
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
		<button type="button" class="close" data-dismiss="modal" onclick="ocultarMessage()" aria-hidden="true">×</button>
		<br />
		<p>message</p>
	</div>
  <div id="breadcrumb"> <a href="index.asp" title="Go to Home" class="tip-bottom" style="color:#666666"><i class="icon-home"></i> Inicio</a></div>
  <h1>Mantenedor de Clientes - Actualiza tus datos</h1>
</div>
<%if request.QueryString("opc")= "sav" then 
	
	sql="exec ActualizaCliente "
	sql=sql & " " & request.form("Idcliente") & ","
	sql=sql & "'" & request.form("nombre") & "', "
	sql=sql & "" & request.form("rut") & ", "
	sql=sql & "'" & request.form("dv") & "', "
	sql=sql & " " & request.form("vEstado") & ", " 
	sql=sql & "'" & request.form("direccion") & "', "
	sql=sql & "'" & request.form("rubro") & "'," 
	sql=sql & "'" & request.form("NomContacto") & "'," 
	sql=sql & "'" & request.form("mailcontacto") & "'," 
	sql=sql & "" & request.form("telefonocontacto") & "," 
	sql=sql & "'" & request.form("cargocontacto") & "'," 
	sql=sql & "'" & request.form("mailcotizacion") & "'" 

	set rs = nothing
	Set rs = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Datos Modificados Exitosamente.', 'success');
		window.location="act_dat.asp?msg=1";
	</script>
	<%
end if
if request.QueryString("opc")= "idmaq" then 
	
	var_chk_sel=request.form("Cliente")
	arr_chk_sel=split(var_chk_sel,",")

	For i=LBound(arr_chk_sel) to UBound(arr_chk_sel)

	Next 
	if len(var_chk_sel) > 0 then
            Response.Redirect("act_dat.asp?opc=edit&id="& var_chk_sel)
            Response.End
    end if			
end if

%>
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon border-blue"><i class="icon-th"></i></span>
            <h5>Mi Plan</h5>
          </div>
		  
		  <div class="widget-content nopadding">
		  <form name="form2_crit" action="#" method="post" class="form-horizontal">
            <table class="table table-bordered table-striped with-check">
              <thead>
                <tr>
				  <th>Tipo Pago</th>
				  <th>Tipo Plan</th>
				  <th>Valor Mensual</th>
				  <th>Valor Total</th>
				  <th>Fecha Pago</th>
                  <th>Fecha Inicio Plan</th>
				  <th>Fecha Termino Plan</th>
				  <th>Descripcion</th>
				  <th>Estado</th>

				  

                </tr>
              </thead>
              <tbody>
			  <%
				
					sql="exec listaPagos_IdUsuario "
					sql=sql & " " & session("id_usuario") & " "

					set rs = nothing
					Set rs = cn.Execute(sql)
					
					if not rs.eof then
						do while not rs.eof
						
						vIdPago	 		= rs("id_Pago")
						vTipoPlan		= rs("tip")
						vFecPago		= rs("fec_pago")
						vFecIni			= rs("fec_inicio")
						vFecTer			= rs("fec_termino")
						vValor			= rs("valor")
						vValortotal		= rs("total")
						vValor1			= rs("valor1")
						vValor2			= rs("valor2")
						vEstado			= rs("vigencia")
						vId_Tipo_Pago	= rs("tipopago")
						
						%>			
						
						<tr class="gradeX">
						  <th><%=vId_Tipo_Pago%></th>
						  <th><%=vTipoPlan%></th>
						  <th>$ <%=FormatNumber(vValor,0)%> +IVA</th>
						  <th>$ <%=FormatNumber(vValortotal,0)%> IVA Inc.</th>
						  <th><%=vFecPago%></th>
						  <th><%=vFecIni%></th>
						  <th><%=vFecTer%></th>
						  <th><%=UCase(vValor2)%></th>
						  <th><%=vEstado%></th>
						  
						</tr>
						
						<%
						rs.movenext
						loop
					end if
					%>
              </tbody>
            </table>
			
			</form>
          </div>
        </div>	
      </div>
    </div>
	<div class="widget-content nopadding">
			<form name="form3_crit" method="post" class="form-horizontal">
					<div id="planes" class="host_plans">
						<div class="container">
							<div class="one_fourth_less">
								<div class="planbox">
								<%
								sql="exec ClientePlan "
								sql=sql & " " & session("id_usuario") & " "

								set rs = nothing
								Set rs = cn.Execute(sql)
								if not rs.eof then %>
								<%end if%>	
									<div class="title"><h4 class="caps"><strong><%=rs("Nombre")%></strong></h4></div>
							
									<div class="prices">
										<strong>$<%=formatnumber(rs("valor"),0)%><i>/mes</i></strong>+ IVA</br></br>
									</div>
							
									<ul style="list-style: none;">
										<li><strong><%=rs("desc2")%></strong></li>
										<li><strong><%=rs("descripcion")%></strong></li>
										<li><strong><%=rs("desc3")%></strong></li>
										<% if rs("desc4") <> "" then %>
										<li><strong><%=rs("desc4")%></strong></li>
										<%end if%>
									</ul>
							
								</div>
							</div><!-- end plan -->*Si ud. desea modificar su plan, favor contactarse a contacto@mundomaquinaria.cl
						</div>
					</div>
				</div>
			</form>
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
				mostrarMensaje('Datos Modificados Exitosamente.', 'success');
			}
		}
	});
</script>
<style>
		#banner :last-child {
			margin-bottom: 0px !important;
		}
		.host_plans .planbox li {
			color: #f7931e !important;
		}
		.host_plans .planbox li strong {
			color: #f7931e !important;
		}
		.host_plans .planbox .prices {
			padding: 27px 0px 0px 0px !important;
		}
		.host_plans {
			padding: 0px 0px !important;
		}
	</style>
</body>
</html>
