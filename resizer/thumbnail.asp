<!-- Copyright (c) 2000 Persits Software, Inc.-->
<!-- For more information on AspJpeg, and to download your free eval version-->
<!-- visit http://www.aspupload.com -->

<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>Create a Thumbnail</TITLE>
</HEAD>
<BODY BGCOLOR="#FFFFFF">

<FONT FACE="Arial" Size=2"><B>The dimensions of the original image are <% = Request("Width") %> x <% = Request("Height") %></B></FONT>
<P>
<FONT SIZE="2" FACE="Arial"><A HREF="pick_jpeg.asp">Upload another image</A></FONT>
<P>
<FORM ACTION="thumbnail.asp" METHOD="POST" NAME="MainForm">
	<INPUT TYPE="HIDDEN" NAME="Path" VALUE="<% = Request("Path") %>">
	<INPUT TYPE="HIDDEN" NAME="Width" VALUE="<% = Request("Width") %>">
	<INPUT TYPE="HIDDEN" NAME="Height" VALUE="<% = Request("Height") %>">

	<TABLE BGCOLOR="#E0FFF0" BORDER="1" CELLSPACING="0" CELLPADDING="2">
	<TR><TD><INPUT TYPE="RADIO" NAME="ResizeOption" VALUE="1" <% If Request("ResizeOption") = "1" Then Response.Write "CHECKED" %>><FONT SIZE="2" FACE="Arial">Scale to</FONT></TD>
		<TD><SELECT NAME="scale" onfocus="document.MainForm.ResizeOption[0].checked = true">
			<OPTION VALUE="200" <% If Request("scale") = "200" Then Response.Write "SELECTED" %>>200%
			<OPTION VALUE="80" <% If Request("scale") = "80" Then Response.Write "SELECTED" %>>80%
			<OPTION VALUE="50" <% If Request("scale") = "50" Then Response.Write "SELECTED" %>>50%
			<OPTION VALUE="25" <% If Request("scale") = "25" Then Response.Write "SELECTED" %>>25%
			<OPTION VALUE="10" <% If Request("scale") = "10" Then Response.Write "SELECTED" %>>10%
			</SELECT>
		</TD></TR>
	<TR><TD><INPUT TYPE="RADIO" NAME="ResizeOption" VALUE="2" <% If Request("ResizeOption") = "2" Then Response.Write "CHECKED" %>><FONT SIZE="2" FACE="Arial">Set width to</FONT></TD>
	<TD><INPUT TYPE="TEXT" NAME="NewWidth" SIZE="5" VALUE="<% = Request("NewWidth")%>" onfocus="document.MainForm.ResizeOption[1].checked = true"> <FONT SIZE="2" FACE="Arial">pixels, preserve Width/Height ratio</FONT></TD>
	</TR>

	<TR><TD><INPUT TYPE="RADIO" NAME="ResizeOption" VALUE="3" <% If Request("ResizeOption") = "3" Then Response.Write "CHECKED" %>><FONT SIZE="2" FACE="Arial">Set height to</FONT></TD>
	<TD><INPUT TYPE="TEXT" NAME="NewHeight" SIZE="5" VALUE="<% = Request("NewHeight")%>" onfocus="document.MainForm.ResizeOption[2].checked = true"> <FONT SIZE="2" FACE="Arial">pixels, preserve Width/Height ratio</FONT></TD>
	</TR>

	<TR><TD COLSPAN="1"><INPUT TYPE="CHECKBOX" NAME="Quality" <% If Request("Quality") <> "" Then Response.Write "CHECKED" %>><FONT SIZE="2" FACE="Arial">High Quality</FONT></TD>
	<TD COLSPAN="1">
		<INPUT TYPE="CHECKBOX" NAME="Sharpen" <% If Request("Sharpen") <> "" Then Response.Write "CHECKED" %>>
		<FONT SIZE="2" FACE="Arial">Sharpen at</FONT>
			<INPUT TYPE="TEXT" SIZE="4" NAME="SharpenValue" VALUE="<% = Request("SharpenValue")%>" onfocus="document.MainForm.Sharpen.checked = true">
			<FONT SIZE="2" FACE="Arial">% (must be > 100)</FONT>
		</TD>
	</TR>

	<!-- this will be implemented with version 1.2+-->
	<TR><TD COLSPAN="2" ALIGN="CENTER"><FONT SIZE="2" FACE="Arial">
		<INPUT TYPE="RADIO" NAME="Rotate" VALUE="1" <% If Request("Rotate") = "1" Then Response.Write "CHECKED" %>> 
		Rotate left
		<INPUT TYPE="RADIO" NAME="Rotate" VALUE="0" <% If Request("Rotate") = "0" Then Response.Write "CHECKED" %>>
		No rotation
		<INPUT TYPE="RADIO" NAME="Rotate" VALUE="2" <% If Request("Rotate") = "2" Then Response.Write "CHECKED" %>>
		Rotate right</FONT></TD>
	</TR>

	<TR><TD COLSPAN="2"><INPUT TYPE="SUBMIT" NAME="create" VALUE="Create Thumbnail"></TD></TR>
	
	</TABLE>
</FORM>

<P>

<%
If Request("Create") <> "" Then

	Path = Request("Path")

	If Request("Quality") <> "" Then
		Interpolation =	1 ' use Bilinear interpolation
	Else
		Interpolation =	0 ' use Nearest-neighbor algorithm
	End If
	
	If Request("Sharpen") <> "" Then
		Sharpen = "1"
		
		SharpenValue = Request("SharpenValue")
		If SharpenValue <= 100 Then
			Response.Write "<FONT FACE=""Arial""><B>Sharpening value must be greater than 100</B></FONT>"
			Response.End
		End If
	Else 
		Sharpen = "0"
	End If

	' resize according to user selection

	' Percentage scaling
	If Request("ResizeOption") = 1 Then
		Scale = Request("scale") / 100
		Height = Request("Height") * Scale
		Width = Request("Width") * Scale
	End If

	' user-specified width
	If Request("ResizeOption") = 2 Then
		If IsNumeric(Request("NewWidth")) Then Width = Request("NewWidth") Else Width = 0
		If Width > 0 and Width < 2000 Then
			Height = Request("Height") * Width / Request("Width")
		Else
			Response.Write "<FONT FACE=""Arial""><B>Invalid Width value</B></FONT>"
			Response.End
		End If
	End If

	' user-specified height
	If Request("ResizeOption") = 3 Then
		If IsNumeric(Request("NewHeight")) Then Height = Request("NewHeight") Else Height = 0
		If Height > 0 and Height < 2000 Then
			Width = Request("Width") * Height / Request("Height")
		Else
			Response.Write "<FONT FACE=""Arial""><B>Invalid Height value</B></FONT>"
			Response.End
		End If
	End If

	Rotate = Request("Rotate")

	' Display image
%>
<IMG SRC="send_binary.asp?Path=<% = Server.URLEncode(Path) %>&Width=<% = Width%>&Height=<% = Height %>&Interpolation=<% = Interpolation %>&sharpen=<% = Sharpen %>&sharpenvalue=<% = SharpenValue%>&Rotate=<% = Rotate %>">
<%
End If
%>


</BODY>
</HTML>
