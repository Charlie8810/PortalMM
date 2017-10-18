<!-- Modal Login -->
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <form name="formLogin" method="post" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Inicio Sesión</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                        <label>Rut</label>
                        <input class="form-control text-box-modal" placeholder="11111111-1" type="text" id="user_rut" name="user_rut" pattern="[0-9]|k"/>
                        <div data-role="popup" class="popUp-validacion" id="popUpUserRut"></div>
                    </div>
                    <div class="form-group">
                        <label>Contraseña</label>
                        <input class="form-control text-box-modal" type="password" name="passw"/>
                    </div>
                    </div>
                    <div class="modal-footer">
                        <!-- Olvidaste tu contraseña -->
                        <a data-toggle="modal" data-target="#myModal10" style="cursor:pointer;color:#F7931E;">Olvidaste tu contraseña </a>
                        <button type="button" class="btn btn-modal" onClick="javascript:validacion(document.forms.formLogin,'login2.asp?opc=in');">Ingresar</button>
                    </div>
                </div>
            </div>
        </form>
        <div class="modal fade" id="myModal10" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <script type="text/javascript">
                function fCarga(formulario, pagina)
                {
                    if(formulario.textcorreo.value=="" )
                    {
                        mostrarMensaje('Para Continuar debe Completar los datos','error');
                        return false;
                    }
                    irA(formulario, pagina);
                }
            </script>
            <form name="formLogin2" method="post" >
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">Recuperación de usuario o contraseña</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                            <label>Ingrese el mail informado</label>
                            <input class="form-control text-box-modal" type="text" name="textcorreo" pattern="[0-9]|k"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-modal" onClick="JavaScript:fCarga(document.forms.formLogin2,'Envio_datos.asp');">Enviar</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- Modal Login Fin -->
    <!-- Modal Registro -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <form name="formReg1" method="post" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">REGISTRO</h4>
                    </div>
                    <div class="modal-body ">
                        <div class="form-group">
                            <label>RAZÓN SOCIAL / NOMBRE</label>
                            <input class="form-control text-box-modal" type="text" style="color:#F7931E" id="Nom_Reg" name="Nom_Reg" value="<%=vNombre%>"/>
                        </div>
                        <div class="form-group">
                            <label>RUT</label>
                            <input class="form-control text-box-modal" placeholder="11111111-1" type="text" style="color:#F7931E" id ="Rut_Reg" name="Rut_Reg" value="<%=vRut%>"/>
                            <div data-role="popup" class="popUp-validacion" id="popUpRegRut"></div>
                        </div>
                        <div class="form-group">
                            <label>CORREO</label>
                            <input class="form-control text-box-modal" type="text" style="color:#F7931E" id="Mail_Reg" name="Mail_Reg" value="<%=vMail%>"/>
                        </div>
                        <div class="form-group">
                            <label>CONTRASEÑA</label>
                            <input class="form-control text-box-modal" type="password" style="color:#F7931E" id ="password" name="password" value="<%=vPassword%>"/>
                        </div>
                        <div class="form-group">
                            <label>REINGRESAR CONTRASEÑA</label>
                            <input class="form-control text-box-modal" type="password" style="color:#F7931E" id ="password2" name="password2" value="<%=vPassword%>"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-modal" style="background:#F7931E" onClick="javascript:validaDatos(document.forms.formReg1,'index.asp?est=new');">ENVIAR</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <!-- Modal Registro Fin -->