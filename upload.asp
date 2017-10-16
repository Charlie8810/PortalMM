<%@LANGUAGE="VBSCRIPT"%>
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
<div align="center">Selecciona una imagen para subir. </div>
</td>
</tr>
</table>
<FORM ENCTYPE="multipart/form-data" ACTION="upload.asp?func=2" METHOD=POST id=form1 name=form1> 
<TABLE align="center">
<TR> 
<TD>&nbsp;</TD>
</TR>
<TR> 
<TD><font color="#330066" size="2">Pulsa en el botón examinar y elige el archivo 
de tu ordenador.<BR>
<BR>
</font></TD>
</TR>
<TR> 
<TD><font color="#330066" size="2">Luego pulsa el botón subir.<BR>
<BR>
</font></TD>
</TR>
<TR> 
<TD><STRONG><font color="#330066" size="2">Nombre del archivo...</font></STRONG></TD>
</TR>
<TR> 
<TD> <font size="2"> 
<INPUT NAME=File1 SIZE=30 TYPE=file>
<BR>
</font></TD>
</TR>
<TR> 
<TD align=left> 
<INPUT type="submit" value="Subir">
<BR>
<BR>
</TD>
</TR>
<TR> 
<TD><font color="#330066" size="2">NOTA: Espera, recibirás una notificación 
cuando el archivo haya sido subido</font><font size="2">.<BR>
<BR>
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
Set f = fso.OpenTextFile(server.mappath("..") & ".\images" &_
FileName, ForWriting, True)
f.Write strFileData
Set f = nothing
Set fso = nothing

lngNumberUploaded = lngNumberUploaded + 1

End if

'Get then next boundry postitions if any
' .
lngCurrentBegin = instr(1,strDataWhole,strBoundry)
lngCurrentEnd = instr(lngCurrentBegin + 1,strDataWhole,strBoundry) - 1
loop


Response.Write "Archivo subido"
Response.Write lngNumberUploaded & " archivo ya está en el servidor.<BR>"
Response.Write "<BR><BR><INPUT type='button' onclick='document.location=" & chr(34) & "upload.asp" & chr(34) & "' value='<< Volver' id='button'1 name='button'1>" 
End Select 
%>
</BODY>
</HTML>