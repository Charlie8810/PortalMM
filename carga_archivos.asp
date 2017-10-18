<!--#include file="con_app.asp"-->
<!--#include file="freeASPUpload.asp"-->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<script type="text/javascript">showhide("msg2","hidden");</script>
<style type="text/css" title="currentStyle">
			@import "./js/demo_page.css";
			@import "./css/demo_table_jui.css";
			@import "./js/jquery-ui-1.8.4.custom.css";
			thead{
			    border: 2px solid black;
				background-color: #43a0d3;
			   	color: white;
				font-weight:bold;
				font-family: "Verdana";
				font-size: 13px;} //Medida de letra
			}
</style>
<link href="./css/css.css" rel="stylesheet" type="text/css">
<link type="text/css" href="css/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
<script type="text/javascript" src="js/funciones.js"></script>
<script type="text/javascript" src="js/Caracteres.js"></script>
<link type="text/css" href="menu3.1/menu.css" rel="stylesheet" />
<script type="text/javascript" language="javascript" src="./js/jquery.js"></script>
<script type="text/javascript" src="menu3.1/menu.js"></script>


<script>

function onSubmitForm(pagina) {

    var formDOMObj = document.frmSend;
    if (formDOMObj.attach1.value=="")
        mostrarMensaje('Por favor seleccione un archivo para subir.', 'error')
	else
		showhide("msg2","visible");
        return true;
    return false;
}
$(document).ready(function(){
		var mensaje = $.getURLParam("msg");
			if (mensaje == 1) {
				mostrarMensaje('Archivo subido exitosamente', 'success');
			}
	});
</script>
		<script>
function ir(pagina)
{

    location.href = pagina
}

 	</script>
<script>
function ir2(pagina,nombre)
{

	  var status = confirm("Desea eliminar el archivo "+nombre+"?");
	  if (status == true) {
		ir(pagina);
	   }

}
</script>
<%

  Dim uploadsDirVar
  dim nombre
		fecha=now()
		fecha= right("00" & day(fecha),2) & "/" & right("00" & month(fecha),2) & "/" & year(fecha) &" "& hour(fecha) &":"& minute(fecha)&":"& second(fecha)
		uploadsDirVar = "./mmloock/assets/img"
        		   if request.querystring("opc")="del" then
				nombre = request.querystring("ruta")

				Set fso = CreateObject("Scripting.FileSystemObject")
						if (fso.FileExists(uploadsDirVar&"\"&nombre)) then
						FSO.deletefile(uploadsDirVar&"\"&nombre)
						end if
						sql = "exec adm_archivos 'eliminar', "
						sql = sql & "'"&fecha&"', "
						sql = sql & "'"&nombre&"', "
						sql = sql & session("Id_Usuario")&", "
						sql = sql & "''"

						set rs=nothing
						set rs = cn.execute(sql)
			end if


		if request.queryString("opc")="dw" then
		      nombre=request.querystring("ruta")

				Dim RutaFichero
					RutaFichero = uploadsDirVar &"\"&nombre

					Set objStream = Server.CreateObject("ADODB.Stream")
					objStream.Open
					objStream.Type = adTypeBinary
					objStream.LoadFromFile RutaFichero
					Response.BinaryWrite objStream.Read
					objStream.Close
					Set objStream = Nothing

			 Response.AddHeader "Content-Disposition", "attachment; filename="&nombre

		end if

function SaveFiles
    Dim Upload, fileName, fileSize, ks, i, fileKey

	Set Upload = New FreeASPUpload

  Upload.Save(uploadsDirVar)

	' If something fails inside the script, but the exception is handled
	If Err.Number<>0 then Exit function
    SaveFiles = ""
    ks = Upload.UploadedFiles.keys

		if (UBound(ks) <> -1) then

		'	SaveFiles = "<B>Archivo subido:</B> "
			for each fileKey in Upload.UploadedFiles.keys
				If Instr(Right(Upload.UploadedFiles(fileKey).FileName,4),".jpg") or Instr(Right(Upload.UploadedFiles(fileKey).FileName,4),".png") or Instr(Right(Upload.UploadedFiles(fileKey).FileName,4),".jpeg") or Instr(Right(Upload.UploadedFiles(fileKey).FileName,5),".docx") or Instr(Right(Upload.UploadedFiles(fileKey).FileName,5),".xlsx") then
						sql = "exec adm_archivos 'nuevo', "
						sql = sql & "'"&fecha&"', "
						sql = sql & "'"&Upload.UploadedFiles(fileKey).FileName&"', "
						sql = sql & session("Id_Usuario")&", "
						sql = sql & "'"&uploadsDirVar&"\"&Upload.UploadedFiles(fileKey).FileName&"'"
					response.write(sql)
response.end()
						set rs = nothing
						set rs = cn.execute(sql)


				end if

        next


    end if


end function
%>
</head>
<body>
<div id="messageDiv" class="" style="display: none;">
	<button type="button" class="close" data-dismiss="modal" onclick="ocultarMessage()" aria-hidden="true">×</button>
	<br />
	<p>message</p>
</div>
	<div id="header" align ="center" class="tituloazul">
	   <h3>Archivos</h3>
	  </div>
	<div align="center">

	    <form class="parrafoazul" name="frmSend" method="POST" enctype="multipart/form-data" accept-charset="utf-8" action="carga_archivos.asp"  onSubmit="return onSubmitForm();">

			Seleccione archivo a subir:<br><br>
				Archivo: <input name="attach1" type="file" size=40><br>
			<br>
			<input style="margin-top:4" type="submit" value="Subir" name="upload" class="botonazul">

    </form>

	</div>

	<pre></pre>
 	   <div id="msg2" align="center" style="visibility:visible ">Subiendo archivo
			<img src="./img/ajax-loader.gif">
			</div>
    <pre></pre>

		<%'solo llamo al UPLOAD si hay envio de formulario


		if Request.ServerVariables("REQUEST_METHOD") = "POST" then

		response.write SaveFiles()

		end if

	%>
<br></br>
</script>
</body>
</html>
