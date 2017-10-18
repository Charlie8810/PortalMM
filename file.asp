<%
   ' -- file.asp --
   ' Retrieves binary files from the database
   
   Response.Buffer = True
   
   ' ID of the file to retrieve
   Dim ID
      ID = Request("ID")
      
   If Len(ID) < 1 Then
      ID = 7
   End If
   
   ' Connection String
   dim cn, rs
	'luego
	set cn =  server.CreateObject("ADODB.Connection")
	'SI NECESITAS UN RECORDSET
    
	set rs = server.CreateObject("ADODB.Recordset")
    
	cn.ConnectionTimeout = 3600
	cn.Open "Driver={SQL Server}; Server=200.63.100.77;uid=sa_Go4MM;Database=MundoMaquinaria;pwd=9Vym7i%7"
      
      ' opening connection
      rs.Open "select [FileData],[ContentType] from Files where ID = " & _
         ID, cn, 2, 4

      If Not rs.EOF Then
         Response.ContentType = rs("ContentType")
         Response.BinaryWrite rs("FileData")
      End If
      
      
      rs.Close
      Set rs = Nothing
%>