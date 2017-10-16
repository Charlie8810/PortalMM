
function irA(formulario,pagina)
{
	formulario.action=pagina;
	formulario.submit();
}

function goToByScroll(id){
      // Scroll
    $('html,body').animate({
        scrollTop: $("#"+id).offset().top},
        'slow');
}

jQuery.getURLParam = function(name){
	var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
	if (results==null){
	   return null;
	}
	else{
	   return decodeURI(results[1]) || 0;
	}
}

function mostrarMensaje(mensaje, tipo)
{
	var	divMessage = $('#messageDiv');
	divMessage.attr('class','message-'+tipo);
	//divMessage.show();
	divMessage.fadeIn(400);
	//var html = document.getElementById('messageDiv').innerHTML;
	//console.log(html);
	//mensaje = 'Bienvenido a Mundo Maquinaria. Su pago se realizo con exito, se envio un mail con sus datos de ingreso a su email registrado';
	var html = "<button type='button' class='close' data-dismiss='modal' onclick='ocultarMessage()' aria-hidden='true'>×</button>" + mensaje;
	//html = html.replace('message',mensaje);
	//console.log(html);
	document.getElementById('messageDiv').innerHTML =  html;
	setTimeout(ocultarMessage, 10000);
	//console.log(document.getElementById('messageDiv').innerHTML);
}

function mensajePopUp(mensaje, popUp)
{
	$('#' + popUp).animate({fontSize: '0px'}, "fast");
	$('#' + popUp).animate({height: '0px'}, "fast");
	var html = "<p>" + mensaje + "</p>";
	$('#' + popUp)[0].innerHTML = html;
	$('#' + popUp).animate({height: '25px'}, "slow");
	$('#' + popUp).animate({fontSize: '12px'}, "slow");
}

function ocultarMessage()
{
	//jQuery('#messageDiv').hide();
	jQuery('#messageDiv').slideUp(300);
}

function irAFuera(formulario, pagina, destino)
{
	 formulario.target=destino;
	 formulario.action=pagina;
	 formulario.submit();
}

function irPopup(pagina)
{
	var winURL = pagina

	var winName		 = "Informacion_Reserva";
	var winFeatures  = "status=no," ;
		winFeatures += "resizable=no," ;
		winFeatures += "toolbar=no," ;
		winFeatures += "location=no," ;
		winFeatures += "scrollbars=yes," ;
		winFeatures += "menubar=0," ;
		winFeatures += "width=600," ;
		winFeatures += "height=400," ;
		winFeatures += "top=0," ;
		winFeatures += "left=0" ;

		window.open(winURL , winName , winFeatures)
}

function Limpia_BarraEstado()
{
	window.status = " ";
}

function showhide(layer_ref, state)
{
	/*if (state == 'visible')
	{
		state = 'hidden';
	}
	else
	{
		state = 'visible';
	}*/
	if (document.all)
	{ //IS IE 4 or 5 (or 6 beta)
		eval( "document.all." + layer_ref + ".style.visibility = state");
	}
	if (document.layers)
	{ //IS NETSCAPE 4 or below
		document.layers[layer_ref].visibility = state;
	}
	if (document.getElementById && !document.all)
	{
		maxwell_smart = document.getElementById(layer_ref);
		maxwell_smart.style.visibility = state;
	}
}

function limpiaTexto(elemento)
{
	var cadena2;
	var cadena = elemento.value;
	str=cadena.split('');
	cadena2="";
	for (var i=0; i<str.length; i++)
	{
		var caracter = str[i];
		if (!isNaN(caracter))
		{
			cadena2=cadena2+caracter;
		}
	}
	return cadena2;
}
function contar(form,name) {
  n = document.forms[form][name].value.length;
  t = 500;
  if (n > t) {
    document.forms[form][name].value = document.forms[form][name].value.substring(0, t);
  }
  else {
    document.forms[form]['result'].value = t-n;
  }
}

function contar2(form,name) {
  n = document.forms[form][name].value.length;
  t = 1000;
  if (n > t) {
    document.forms[form][name].value = document.forms[form][name].value.substring(0, t);
  }
  else {
    document.forms[form]['result'].value = t-n;
  }
}

function selectTab(evt, tabName) {
	// Declare all variables
	var i, tabcontent, tablinks;
	// Get all elements with class="tabcontent" and hide them
	tabcontent = document.getElementsByClassName("tabcontent");
	for (i = 0; i < tabcontent.length; i++) {
		tabcontent[i].style.display = "none";
	}
	// Get all elements with class="tablinks" and remove the class "active"
	tablinks = document.getElementsByClassName("tablinks");
	for (i = 0; i < tablinks.length; i++) {
		tablinks[i].className = tablinks[i].className.replace(" active", "");
	}
	// Show the current tab, and add an "active" class to the button that opened the tab
	document.getElementById(tabName).style.display = "block";
	evt.currentTarget.className += " active";
}

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
        var valor=jQuery("#textfield").val();
        valor = valor.replace('.','');
        valor = valor.replace('.','');
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
                   //combo=document.getElementById("celda_aplicacion");
                   //combo.length=0;
                   //var nuevaOpcion=document.createElement("option"); nuevaOpcion.value=0; nuevaOpcion.innerHTML="Cargando...";
                   //combo.appendChild(nuevaOpcion);
                   //combo.disabled=false;
               }
               if (ajax.readyState==4){
                   //alert ("entra3");
                   //alert(ajax.responseText);
                   jQuery("#textfield2").val(ajax.responseText);
									 $('#popUpRS').animate({fontSize: '0px'}, "fast");
								 	 $('#popUpRS').animate({height: '0px'}, "fast");
               }
           }
           ajax.send(null);
        }
    }

		function checkRut(rut, popUp) {
			var popUpRut = $('#' + popUp);
			if (popUpRut != null) {
				$('#' + popUp).animate({fontSize: '0px'}, "fast");
				$('#' + popUp).animate({height: '0px'}, "fast");
			}

			//var rut = $('#textfield').val();
			
		    // Despejar Puntos
		    var valor = rut.replace('.','');
		    valor = valor.replace('.','');
		    // Despejar Guión
		    valor = valor.replace('-','');

		    // Aislar Cuerpo y Dígito Verificador
		    cuerpo = valor.slice(0,-1);
		    dv = valor.slice(-1).toUpperCase();

		    // Formatear RUN
		    rut.value = cuerpo + '-'+ dv

		    // Si no cumple con el mínimo ej. (n.nnn.nnn)
		    if(cuerpo.length < 7) {
					//rut.setCustomValidity("RUT Incompleto");
					if (popUpRut != null) {
						mensajePopUp('RUT Incompleto', popUp);
					}
					else {
						mostrarMensaje('RUT Incompleto','error')
					}
					return false;
				}

		    // Calcular Dígito Verificador
		    suma = 0;
		    multiplo = 2;

		    // Para cada dígito del Cuerpo
		    for(i=1;i<=cuerpo.length;i++) {

		        // Obtener su Producto con el Múltiplo Correspondiente
		        index = multiplo * valor.charAt(cuerpo.length - i);

		        // Sumar al Contador General
		        suma = suma + index;

		        // Consolidar Múltiplo dentro del rango [2,7]
		        if(multiplo < 7) { multiplo = multiplo + 1; } else { multiplo = 2; }

		    }

		    // Calcular Dígito Verificador en base al Módulo 11
		    dvEsperado = 11 - (suma % 11);

		    // Casos Especiales (0 y K)
		    dv = (dv == 'K')?10:dv;
		    dv = (dv == 0)?11:dv;

		    // Validar que el Cuerpo coincide con su Dígito Verificador
		    if(dvEsperado != dv) {
					//rut.setCustomValidity("RUT Inválido");
					//mostrarMensaje('RUT Incorrecto','error')
					
					if (popUpRut != null) {
						mensajePopUp('RUT Incorrecto', popUp);
					}
					else {
						mostrarMensaje('RUT Incorrecto','error')
					}

					return false;
				}

		    // Si todo sale bien, eliminar errores (decretar que es válido)
		    // rut.setCustomValidity('');
				// ocultarMessage();
				return true;
		}
		function ValidarImagen(obj, width, height) {
				var uploadFile = obj[0];//obj.files[0];

				if (!window.FileReader) {
						mostrarMensaje('El navegador no soporta la lectura de archivos', 'error');
						return false;
				}

				if (!(/\.(jpg|png|gif)$/i).test(uploadFile.name)) {
						mostrarMensaje('El archivo a adjuntar no es una imagen', 'error');
						return false;
				}
				else {
						var img = new Image();
						img.onload = function () {
								if (this.width.toFixed(0) > width || this.height.toFixed(0) > height) {
										mostrarMensaje('Las medidas máximas deben ser: '+ width +' x '+ height +' píxeles', 'error');
										return false;
								}
								else if (uploadFile.size > 200000)
								{
										mostrarMensaje('El peso de la imagen no puede exceder los 200 KB', 'error');
										return false;
								}
								else {
										//mostrarMensaje('Imagen correcta :)', 'success');
										return true;
								}
						};
						img.src = URL.createObjectURL(uploadFile);
				}
		}
function validaDatos(formulario, pagina){
	var Rut 				= document.getElementById('Rut_Reg').value;
	var Nombre 				= document.getElementById('Nom_Reg').value;
	var Mail 				= document.getElementById('Mail_Reg').value;
	var Pass1 				= document.getElementById('password').value;
	var Pass2 				= document.getElementById('password2').value;

	if(Rut == null || Rut.length == 0 || /^\s+$/.test(Rut)){
		mostrarMensaje('El campo Rut no debe ser vacío','error');
		return false;
	}

	if(Nombre == null || Nombre.length == 0 || /^\s+$/.test(Nombre)){
			mostrarMensaje('El campo Nombre no debe ser vacío','error');
		return false;
		}
	/*if(Mail == null || Nombre.length == 0 ||/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3,4})+$/.test(Mail){*/
	if(Mail == null || Mail.length == 0 || /^\s+$/.test(Mail)){
			mostrarMensaje('El Mail es incorrecto','error');
		return false;
		}
	expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	if ( !expr.test(Mail) ){
		mostrarMensaje('La dirección de correo ' + Mail + ' es incorrecta','error');
		return false;
		}
	if(Pass1 != Pass2 ){
		//mostrarMensaje('Las contraseñas no son iguales', 'error');
		mostrarMensaje('Estimado Usuario, Las contraseñas ingresadas no son iguales', 'error');
		//alert("Las contraseñas no son iguales")
		return false;
	}
		irA(formulario, pagina);

}
function validacion(formulario, pagina)
{
	if(formulario.user_rut.value=="" || formulario.passw.value=="" )
	{
		mostrarMensaje('Para Continuar debe Completar los datos de Ingreso','error');
		return false;
	}
	irA(formulario, pagina);
}