<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="assets/css/uniform.css" />
<link rel="stylesheet" href="assets/css/select2.css" />
<link rel="stylesheet" href="assets/css/fullcalendar.css" />
<link rel="stylesheet" href="assets/css/matrix-style.css" />
<link rel="stylesheet" href="assets/css/matrix-media.css" />
<!--<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />-->
<!---<link rel="stylesheet" href="css/jquery.gritter.css" />-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>


<div class="logo2"><h1><a><img src="./images/logo_chico.png" /></a></h1></div>
<div id="sidebar"><a href="#" class="visible-phone" style="color:#F7931E"><i class="icon icon-home"></i>Mundo Maquinaria</a>
  <ul>
    <!-- <li><a href="#"><i class="icon icon-th-list"></i> <span>Mundo Maquinaria</span></a></li> -->
    <li class="submenu"><a><i class="icon icon-th-list"></i> <span>Clientes</span></a>
		<ul>
			<%	if session("Perfil_Administrador") <> "1" then	%>
				<li><a href="act_dat.asp">Actualiza tus Datos</a></li>
				<li><a href="pub_maq.asp">Publica tus Equipos</a></li>
				<li><a href="mant_venta.asp">Publicar tu Venta</a></li>
				<!-- <li><a href="rev_plan.asp">Planes de Clientes</a></li> -->
				<li><a href="rev_pag.asp">Revisar Mi Plan</a></li>
			<%else%>
				<li><a href="act_dat.asp">Datos Clientes</a></li>
				<li><a href="pub_maq.asp">Equipos Clientes</a></li>
				<li><a href="pub_adminventa.asp">Ventas Clientes</a></li>

				<!-- <li><a href="rev_plan.asp">Planes de Clientes</a></li> -->
				<!--<li><a href="rev_pag.asp">Revisar Mi Plan</a></li>-->
			<%end if%>
	<%	if session("Perfil_Administrador") <> "1" then	%>
			<li><a href="act_pass.asp">Actualiza tu Contraseña</a></li>
	<%end if%>
      </ul>
	</li>
	<%	if session("Perfil_Administrador") = "1" then	%>
	<li class="submenu"><a href="#"><i class="icon icon-th-list"></i> <span>Publicidad</span></a>
		<ul>
			<li><a href="demo_tabla.asp">Publicidad Principal</a></li>
			<li><a href="pub_c1.asp">Publicidad Cuadro 1</a></li>
			<li><a href="pub_c2.asp">Publicidad Cuadro 2</a></li>
			<li><a href="pub_c3.asp">Publicidad Cuadro 3</a></li>
			<li><a href="pub_cot.asp">Publicidad Cotización</a></li>
      </ul>
	</li>
	<li><a href="mant_eq.asp"><i class="icon icon-th-list"></i> <span>Equipos</span></a></li>
    <li class="submenu"><a href="#"><i class="icon icon-th-list"></i> <span>Planes</span></a>
		<ul>
			<li><a href="mant_pl_men.asp">Planes Mensuales</a></li>
			<li><a href="mant_pl_sem.asp">Planes Semestrales</a></li>
			<li><a href="mant_pl_anu.asp">Planes Anuales</a></li>
		</ul>
	</li>
	<li class="submenu"><a href="#"><i class="icon icon-th-list"></i> <span>Informes</span></a>
		<ul>
			<li><a href="graficos.asp">Resumen</a></li>
			<li><a href="graf_clientes.asp">Clientes</a></li>
			<li><a href="graf_equipos.asp">Equipos</a></li>
			<li><a href="graf_cotizacion.asp">Cotizaciones</a></li>
			<li><a href="graf_ventas.asp">Equipos Ventas</a></li>
			<li><a href="graf_visitas.asp">Visitas</a></li>
      </ul>
	</li>
	<li><a href="usr_adm.asp"><i class="icon icon-fullscreen"></i> <span>Usuarios Administradores</span></a></li>
	<li><a href="act_pass.asp"><i class="icon icon-fullscreen"></i> <span>Actualiza tu Contraseña</span></a></li>

	<% end if %>
	<li><a href="index.asp"><i class="icon icon-share-alt"></i> <span>Cerrar Sesión</span></a></li>

  </ul>
</div>
