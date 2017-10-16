<%@LANGUAGE="VBSCRIPT"%>
<meta charset="UTF-8" />
<link rel="stylesheet" href="../assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="../assets/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="../assets/css/uniform.css" />
<link rel="stylesheet" href="../assets/css/select2.css" />
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
		var canvas = document.getElementById( 'previewcanvas' );

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

<%response.buffer=true
Func = Request("Func")
if isempty(Func) Then
Func = 1
End if
Select Case Func
Case 1
%>

<table width="360" border="0" align="center">
<tr>
<td> 
<div align="center">Selecciona una imagen. </div>
</td>
</tr>
</table>
<FORM ENCTYPE="multipart/form-data" ACTION="upload.asp?func=2" METHOD=POST id=form1 name=form1> 
<TABLE align="center">

</font></TD>
</TR>
<TR> 
<TD><font color="#330066" size="2">Luego pulsa el botón subir.<BR>
<BR>
</font></TD>
</TR>
<TR> 
<!--<TD><STRONG><font color="#330066" size="2">Nombre del archivo...</font></STRONG></TD>
</TR>
<TR> 
<TD> <font size="2"> 
<INPUT NAME=File1 class="btn btn-success" style="background:#3B5998" SIZE=30 TYPE=file>
<BR>
</font></TD>
</TR>-->
<BR>
<!-- Visualizar la imagen antes de subirla al servidor  -->
<div class="control-group">
   <div class="controls">
	<div id="previewcanvascontainer">
		<canvas id="previewcanvas">
		</canvas>
	</div>
	<!--<input File>-->

	<form action="/uploadfile.php" enctype="multipart/form-data" method="post">
	   <input type="file" id="foto1" class="btn btn-success" style="background:#3B5998" name ="foto1" onchange="return ShowImagePreview( this.files );" />
	</form>
  </div>
</div>



<TR> 
<TD align=left> 
<BR><BR><BR>
<INPUT type="submit" class="btn btn-success" style="background:#3B5998" value="Subir">
<BR>
<BR>
</TD>
</TR>

</font></TD>
</TR>
</TABLE>
<%
Case 2
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
Set f = fso.OpenTextFile(server.mappath("..") & "\upload\" &_
FileName, ForWriting, True)
f.Write strFileData
Set f = nothing
Set fso = nothing

lngNumberUploaded = lngNumberUploaded + 1

set cn =  server.CreateObject("ADODB.Connection")
cn.ConnectionTimeout = 3600
cn.Open "Driver={SQL Server}; Server=200.63.100.77;uid=sa_Go4MM;Database=MundoMaquinaria;pwd=9Vym7i%7"
'Insertar en la base de datos
sql="exec MantenedorPublicidad "
sql=sql & " 3,"
sql=sql & " -1, "
sql=sql & " '" & FileName & "', "
sql=sql & " 1 , "
sql=sql & " 1 , "
sql=sql & "'" & FileName & "',"
sql=sql & " 1231 "	

set rs = nothing
Set rs = cn.Execute(sql)

End if

'Get then next boundry postitions if any
' .
lngCurrentBegin = instr(1,strDataWhole,strBoundry)
lngCurrentEnd = instr(lngCurrentBegin + 1,strDataWhole,strBoundry) - 1
loop

%>
<script type="text/javascript">
	alert("Publicidad Agregada Exitosamente.");
	window.close();
</script>
<%
'Response.Write "Archivo subido"
'Response.Write lngNumberUploaded & " archivo ya está en el servidor.<BR>"
'Response.Write "<BR><BR><INPUT type='button' onclick='document.location=" & chr(34) & "upload.asp?nam="& FileName& "" & chr(34) & "' value='<< Volver' id='button'1 name='button'1>" 
End Select 
%>
</BODY>
</HTML>