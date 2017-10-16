<% ' Insert.asp 
%>
<!--#include file="Loader.asp"-->
<html>
<head>
	<link rel="icon" type="image/png" href="./images/icon.ico" />
	<title>Mundo Maquinaria</title>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<%
  Response.Buffer = True

  ' load object
  Dim load
    Set load = new Loader
    
    ' calling initialize method
    load.initialize
    
  ' File binary data
  Dim fileData
    fileData = load.getFileData("foto1")
  ' File name
  Dim fileName
    fileName = LCase(load.getFileName("foto1"))
  ' File path
  Dim filePath
    filePath = load.getFilePath("foto1")
  ' File path complete
  Dim filePathComplete
    filePathComplete = load.getFilePathComplete("foto1")
  ' File size
  Dim fileSize
    fileSize = load.getFileSize("foto1")
  ' File size translated
  Dim fileSizeTranslated
    fileSizeTranslated = load.getFileSizeTranslated("foto1")
  ' Content Type
  Dim contentType
    contentType = load.getContentType("foto1")
  
  ' No. of Form elements
  'Dim countElements
  '  countElements = load.Count
  '' Value of text input field "fname"
  'Dim fnameInput
  '  fnameInput = load.getValue("fname")
  '' Value of text input field "lname"
  'Dim lnameInput
  '  lnameInput = load.getValue("lname")
  '' Value of text input field "profession"
  'Dim profession
  '  profession = load.getValue("profession")  
    
  ' destroying load object
  Set load = Nothing
    ' Checking to make sure if file was uploaded
	'Response.Write(fileSize)
	'Response.End()
    If fileSize > 0 and fileSize < 4000 Then
    
		' Connection string
		dim cn, rs
		'luego
		set cn =  server.CreateObject("ADODB.Connection")
		'SI NECESITAS UN RECORDSET
		
		set rs = server.CreateObject("ADODB.Recordset")
		
		cn.ConnectionTimeout = 3600
		cn.Open "Driver={SQL Server}; Server=200.63.100.77;uid=sa_Go4MM;Database=MundoMaquinaria;pwd=9Vym7i%7"
	
        rs.Open "Publicidad", cn, 2, 2
        ' Adding data
        rs.AddNew
          'rs("FileName") = fileName
          'rs("FileSize") = fileSize
          rs("imagen").AppendChunk fileData
          'rs("ContentType") = contentType
          'rs("FirstName") = fnameInput
          'rs("LastName") = lnameInput
          'rs("Profession") = profession
        rs.Update
        
        rs.Close
        Set rs = Nothing
   
    '  Response.Write "<font color=""green"">File was successfully uploaded..."
    '  Response.Write "</font>"
    'Else
    '  Response.Write "<font color=""brown"">No file was selected for uploading"
    '  Response.Write "...</font>"
    End If
      
      
    'If Err.number <> 0 Then
    '  Response.Write "<br><font color=""red"">Something went wrong..."
    '  Response.Write "</font>"
    'End If
  %>
<body>
<script>
	IrA()(document.forms.form3_crit,'demo_tabla.asp?opc=sav2');
</script>
<script type="text/javascript" src="assets/js/funciones.js"></script>
</body>
</html>