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

<script type="text/javascript">
function validarDatos(formulario, pagina){
	var Pass1 			= document.getElementById('pass').value;
	var Pass2 			= document.getElementById('pass2').value;
	
	var regex = /^(?=.*[az])(?=.*[AZ])(?=.*[0-9])(?=.{8,})/;
	if(Pass1 != Pass2 ){
		//mostrarMensaje('Las contraseñas no son iguales', 'error');
		alert("Las contraseñas no son iguales")
		document.form1_crit.Pass1.focus()
		return false;
	}
	if ( !regex.test(Pass1) ){
       // alert("Error: La dirección de correo " + MailContacto + " es incorrecta.");
	   mostrarMensaje('La password debe tener de 8 a 15 digitos, debe contener una minuscula y un numero', 'error');
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
  <h1>Actualiza tu contraseña</h1>
</div>
<%if request.QueryString("opc")= "sav" then

	sql="exec Update_Pass "
	sql=sql & " " & 2 & ","
	sql=sql & "'" & session("id_usuario") & "',"
	sql=sql & "''"

	set rs = nothing
	Set rs = cn.Execute(sql)

	if request.form("pass_ant") <> rs("pass") then
	%>
	<script type="text/javascript">
		//mostrarMensaje('La contraseña ingresada no es igual a la vigente.', 'error');
		window.location="act_pass.asp?msg=1";

	</script>
	<%
	else
	sql="exec Update_Pass "
	sql=sql & " " & 1 & ","
	sql=sql & " " & session("id_usuario") & ","
	sql=sql & "'" & request.form("pass") & "'"
	set rs2 = nothing
	Set rs2 = cn.Execute(sql)
	%>
	<script type="text/javascript">
		//mostrarMensaje('Contraseña Modificada Exitosamente.', 'success');
		window.location="act_dat.asp?msg=2";
	</script>
	<%
	end if
end if
%>
<div class="widget-content nopadding">
          <form name="form1_crit" action="#" method="post" class="form-horizontal">
              <div class="control-group">

				<label class="control-label">Contraseña anterior :</label>
				<div class="modal-body">
					<input class="span11 text-box-modal" type="password" id=pass_ant name="pass_ant" />
				</div>
				<label class="control-label">Nueva Contraseña :</label>
				<div class="modal-body">
					<input class="span11 text-box-modal" type="password" id=pass name="pass" />
				</div>
				<label class="control-label">Repita Contraseña :</label>
				<div class="modal-body">
					<input class="span11 text-box-modal" type="password" id=pass2 name="pass2" />
				</div>

				</div>

            <div class="form-actions">
			  <button type="button" class="btn btn-success" onClick="javascript:validarDatos(document.forms.form1_crit,'act_pass.asp?opc=sav');">Guardar</button>
            </div>
          </form>


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
				mostrarMensaje('La contraseña ingresada no es igual a la vigente.', 'error');
			} else if (mensaje == 2) {
				mostrarMensaje('Contraseña Modificada Exitosamente.', 'success');
			}
		}
	});
</script>
</body>
</html>
