<%
   ' -- show.asp --
   ' Generates a list of uploaded files
   
   Response.Buffer = True
   
   ' Connection String
   dim cn, rs
	'luego
	set cn =  server.CreateObject("ADODB.Connection")
	'SI NECESITAS UN RECORDSET
    
	set rs = server.CreateObject("ADODB.Recordset")
    
	cn.ConnectionTimeout = 3600
	cn.Open "Driver={SQL Server}; Server=200.63.100.77;uid=sa_Go4MM;Database=MundoMaquinaria;pwd=9Vym7i%7"
%>
<html>
<head>
   <title>Inserts Images into Database</title>
   <style>
      body, input, td { font-family:verdana,arial; font-size:10pt; }
   </style>
</head>
<body>
   <p align="center">
      <b>Showing Binary Data from the Database</b><br>
      <a href="insert.htm">To insert data click here</a>
   </p>
   
   <table width="700" border="1" align="center">
<%
   ' Recordset Object

      ' opening connection
      rs.Open "select [ID],[FileName],[FileSize],[ContentType],[FirstName]," & _
         "[LastName],[Profession] from Files order by [ID] desc", cn, 3, 4

      If Not rs.EOF Then
         Response.Write "<tr><td colspan=""7"" align=""center""><i>"
         Response.Write "No. of records : " & rs.RecordCount
         Response.Write ", Table : Files</i><br>"
         Response.Write "</td></tr>"
   
         While Not rs.EOF
            Response.Write "<tr><td>"
            Response.Write rs("ID") & "</td><td>"
            Response.Write "<a href=""file.asp?ID=" & rs("ID") & """>"
            Response.Write rs("FileName") & "</a></td><td>"
            Response.Write rs("FileSize") & "</td><td>"
            Response.Write rs("ContentType") & "</td><td>"
            Response.Write rs("FirstName") & "</td><td>"
            Response.Write rs("LastName") & "</td><td>"
            Response.Write rs("Profession")
            Response.Write "</td></tr>"
            rs.MoveNext
         Wend
      Else
         Response.Write "No Record Found"
      End If
      
      rs.Close
      Set rs = Nothing
%>
   </table>
</body>
</html>