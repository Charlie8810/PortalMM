<!-- Copyright (c) 2000 Persits Software, Inc.-->
<!-- For more information on AspJpeg, and to download your free eval version-->
<!-- visit http://www.aspupload.com -->

<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>AspJpeg Demo - Pick an Image</TITLE>
</HEAD>
<BODY BGCOLOR="#FFFFFF">
<BASEFONT FACE="Arial" SIZE="2">

<TABLE WIDTH="550">
<TR><TD>

<H3><A HREF="http://www.aspjpeg.com">AspJpeg</A> Live Demo</H3>

<FONT SIZE="2"><B>Instructions:</B>
Select an image file from your hard drive for which you would
like to create thumbnails. Upload it to our
server using the form below. Once the image is uploaded,
you will be given the opportunity to 
specify various resizing options.
<P>
No images handy? No problem!
We have put together a few large high-quality images you can experiment with. 
<A HREF="jpegimages.zip">Download them here</A>.

</FONT>


<FORM ACTION="upload_jpeg.asp" METHOD="POST" ENCTYPE="multipart/form-data">
<TABLE BORDER="1" CELLSPACING="0" CELLPADDING="2">
	<TR><TD BGCOLOR="#E0FFF0" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2" COLOR="#000000"><B>Select an Image</B></FONT></TD></TR>
	<TR><TD BGCOLOR="#EEEEEE"><INPUT TYPE="FILE" NAME="myFile" SIZE="40"></TD></TR>
	<TR><TD BGCOLOR="#EEEEEE"><INPUT TYPE="SUBMIT" VALUE="Upload Image"></TD></TR>
</TABLE>
</FORM>

<P>
<FONT SIZE="2"><A HREF="demo_jpeg.zip">Download source code for this demo</A></FONT>


</TD></TR>
</TABLE>


</BASEFONT>
</BODY>
</HTML>