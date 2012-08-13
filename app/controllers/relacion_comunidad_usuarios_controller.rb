class RelacionComunidadUsuariosController < ApplicationController
  
  def create
  end

  def destroy
  end

#  def update
#    @permiso = RelacionComunidadUsuario.find(params[:relacion_comunidad_usuario][:id])
#    @usuario = Usuario.find(params[:relacion_comunidad_usuario][:usuario_id])
#    @comunidad = Comunidad.find(params[:relacion_comunidad_usuario][:comunidad_id])
#
#    if @permiso.update_attributes(params[:relacion_comunidad_usuario])
#      flash[:success] = "Los permisos de #{@usuario.nombre} han sido actualizados!"
#      redirect_to comunidad_usuarios_path(@comunidad)
#      #render :nothing => true
#    end  
#  end

  def autorizar_administrador
    @usuario = Usuario.find(params[:relacion_comunidad_usuario][:usuario_id])
    current_comunidad.autorizar_administrador!(@usuario)

    respond_to do |format|
      format.html { redirect_to comunidad_usuarios_path(current_comunidad) }
      format.js 
    end
  end
end
