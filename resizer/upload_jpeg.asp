<!-- Copyright (c) 2000 Persits Software, Inc.-->
<!-- For more information on AspJpeg, and to download your free eval version-->
<!-- visit http://www.aspupload.com -->

<HTML>
<HEAD>
<TITLE>JPEG Upload Script</TITLE>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>
<BODY BGCOLOR="#FFFFFF">

<%
	Set Upload = Server.CreateObject("Persits.Upload")
	Upload.OverwriteFiles = False
	Upload.SetMaxSize 5000000, True
	Upload.CodePage = 65001

	On Error Resume Next	
	Count = Upload.Save("C:\upload\jpeg")

	If Err <> 0 or Count = 0 Then
		
%>

<FONT SIZE="3" FACE="Arial" COLOR="#FF0000"><% If Err <> 0 Then Response.Write "An error occurred:" & Err.Description Else Response.Write "Nothing has been uploaded."%></B></FONT>
<P>
<FONT SIZE="2" FACE="Arial"><A HREF="pick_jpeg.asp">Try again</A>.</FONT>

<%		
	Else
		On Error Goto 0
		Set File = Upload.Files(1)
		If File.ImageType = "UNKNOWN" Then
			File.Delete
%>
<FONT SIZE="3" FACE="Arial" COLOR="#FF0000">This is not a valid image file.</B></FONT>
<P>
<FONT SIZE="3" FACE="Arial"><A HREF="pick_jpeg.asp">Try again</A>.</FONT>
<%		Else

			' Special handling of TIFF since AspUpload cannot extract TIFF dimensions
			if File.ImageType = "TIF" Then
				Set Tiff = Server.CreateObject("Persits.Jpeg")
				Tiff.Open File.Path
				ImageWidth = Tiff.OriginalWidth				
				ImageHeight = Tiff.OriginalHeight
				Tiff.Close
			Else
				ImageWidth = File.ImageWidth
				ImageHeight = File.ImageHeight
			End if
%>

<FONT SIZE="2" FACE="Arial">
<B>The following <% = File.ImageType%> image has been uploaded:</B><P>
<TABLE CELLSPACING="0" CELLPADDING="2" BORDER="1">
	<TR><TD><FONT SIZE="2" FACE="Arial"><B>Path:</B></FONT></TD>
	<TD><FONT SIZE="2" FACE="Arial"><% = Server.HTMLEncode(File.OriginalPath) %></FONT></TD></TR>
	<TR><TD><FONT SIZE="2" FACE="Arial"><B>Size:</B></FONT></TD>
	<TD><FONT SIZE="2" FACE="Arial"><% = File.Size %> bytes</FONT></TD></TR>
	<TR><TD><FONT SIZE="2" FACE="Arial"><B>Dimensions:</B></FONT></TD>
	<TD><FONT SIZE="2" FACE="Arial"><% = ImageWidth %> x <% = ImageHeight %> pixels</FONT></TD></TR>
</TABLE>
<P>
<FORM ACTION="thumbnail.asp" METHOD="GET">
	<INPUT TYPE="HIDDEN" NAME="Path" VALUE="<% = Server.HtmlEncode(File.Path) %>">
	<INPUT TYPE="HIDDEN" NAME="Height" VALUE="<% = ImageHeight %>">
	<INPUT TYPE="HIDDEN" NAME="Width" VALUE="<% = ImageWidth %>">
	<INPUT TYPE="HIDDEN" NAME="scale" VALUE="50">
	<INPUT TYPE="HIDDEN" NAME="NewWidth" VALUE="100">
	<INPUT TYPE="HIDDEN" NAME="NewHeight" VALUE="100">
	<INPUT TYPE="HIDDEN" NAME="ResizeOption" VALUE="1">
	<INPUT TYPE="HIDDEN" NAME="Quality" VALUE="1">
	<INPUT TYPE="HIDDEN" NAME="Sharpen" VALUE="">
	<INPUT TYPE="HIDDEN" NAME="SharpenValue" VALUE="130">
	<INPUT TYPE="HIDDEN" NAME="Rotate" VALUE="0">
	<INPUT TYPE="SUBMIT" VALUE="Continue...">	
</FORM>
<P>
<IMG SRC="/uploaddir/jpeg/<% = Server.HtmlEncode(File.ExtractFileName) %>">
<P>
<FONT SIZE="2" FACE="Arial"><A HREF="pick_jpeg.asp">Upload another image</A></FONT>


</FONT>
<%

		End If
	End If
%>

</BODY>
</HTML>
