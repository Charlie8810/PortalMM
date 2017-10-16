<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<html>
    <head>
    <script language="javascript" type="text/javascript">
    function nuevoAjax(){ 
        /* Crea el objeto AJAX. Esta funcion es generica para cualquier utilidad de este tipo, por
        lo que se puede copiar tal como esta aqui */
        var xmlhttp=false; 
        try{ 
           // Creacion del objeto AJAX para navegadores no IE
           xmlhttp=new ActiveXObject("Msxml2.XMLHTTP"); 
        }
        catch(e){ 
           try{ 
               // Creacion del objet AJAX para IE 
               xmlhttp=new ActiveXObject("Microsoft.XMLHTTP"); 
           } 
           catch(E) { xmlhttp=false; 
           }
        }
        if (!xmlhttp && typeof XMLHttpRequest!='undefined') { 
            xmlhttp=new XMLHttpRequest(); 
        } 
        return xmlhttp; 
    }
 
    function cargaAplicacion(){
        //alert ("entra1");
        var valor=document.getElementById("rut").value;
        //alert (valor);        
        
        if (valor==0){          
           document.getElementById("celda_aplicacion").innerHTML=" Escribe un rut previamente";
        }
        else{
            //alert ("entra2");
            ajax=nuevoAjax();
            ajax.open("GET", "careferencias.asp?rut="+valor, true);
            ajax.onreadystatechange=function(){ 
               if (ajax.readyState==1){
                   combo=document.getElementById("celda_aplicacion");
                   combo.length=0;
                   var nuevaOpcion=document.createElement("option"); nuevaOpcion.value=0; nuevaOpcion.innerHTML="Cargando...";
                   combo.appendChild(nuevaOpcion); 
                   combo.disabled=false;       
               }
               if (ajax.readyState==4){ 
                    //alert ("entra3");
                   //alert(ajax.responseText);
                   document.getElementById("celda_aplicacion").innerHTML=ajax.responseText;
               } 
           }
           ajax.send(null);
        }
    }
    </script>
 
    </head>
    <body>
        <table border="5">
            <tr>
                <td>
                    <form action="referencias_revisiones.asp" method = "post" id="form4" name="buscarPedido">
                        <table border="2" align="center">
                            <tr>
                                <td align="center" colspan="2">
                                    <u><big><big><strong><tt>REFERENCIAS - REVISIONES</tt></strong></big></big></u>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Introduce rut: 
                                    <input type="text" name="rut" id="rut" size=20 value="" onchange="cargaAplicacion()">
                                </td>
                                <td id="celda_aplicacion">
                                </td>
                            </tr>
                        </table>
                    </form>
                </td>
            </tr>
        </table>
    </body>
</html>