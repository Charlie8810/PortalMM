<%
	Response.Expires = 0
	
	Session.CodePage = 65001
	
	If instr(Request.ServerVariables("HTTP_REFERER"), "support.persits.com") = 0 Then
		Response.End
	end if
	
	' create instance of AspJpeg
	Set jpg = Server.CreateObject("Persits.Jpeg")
	
	' Open source file
	jpg.Open( Request("path") )

	' Set resizing algorithm
	jpg.Interpolation = Request("Interpolation")

	' Set new height and width
	jpg.Width = Request("Width")
	jpg.Height = Request("Height")
	
	' Convert to RGB if this is a CMYK image
	jpg.ToRGB
	
	' Sharpen resultant image
	If Request("Sharpen") <> "0" Then 
		jpg.Sharpen 1, Request("SharpenValue")
	End If

	' Rotate if necessary. Only available in version 1.2
	If Request("Rotate") = 1 Then jpg.RotateL
	If Request("Rotate") = 2 Then jpg.RotateR
	
	' Handle PNG images with alpha channel (AspJpeg 2.7+)
	jpg.FlattenAlpha &HFFFFFFFF
	

	' Perform resizing and 
	' send resultant image to client browser
	jpg.SendBinary
%>