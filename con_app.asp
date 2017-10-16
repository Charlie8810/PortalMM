<%
@LCID = 1034
%>
<!--#include file="./global.asp"-->
<%

dim cn, rs, rs2, rs3, rs4, StrSQL,ocmd
'luego
set cn =  server.CreateObject("ADODB.Connection")
'SI NECESITAS UN RECORDSET

set rs = server.CreateObject("ADODB.Recordset")
set rs2 = server.CreateObject("ADODB.Recordset")
set rs3 = server.CreateObject("ADODB.Recordset")
set rs4 = server.CreateObject("ADODB.Recordset")

cn.ConnectionTimeout = 3600
cn.Open "Driver={SQL Server}; Server=200.63.100.77;uid=mm-user001;Database=mundomaq_prod;pwd=Cwe3h61#"

%>
