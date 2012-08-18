class RelacionComunidadUsuariosController < ApplicationController
  
  def create
    @comunidad = Comunidad.find(params[:relacion_comunidad_usuario][:comunidad_id])
    @usuario = Usuario.find(params[:relacion_comunidad_usuario][:usuario_id])
    @comunidad.autorizar_usuario!(@usuario)
    
    #redirect_to unidades_autorizadas_usuario_path(@usuario)
    flash[:success] = "Se ha autorizado correctamente a #{@usuario.nombre} para la comunidad #{@comunidad.nombre}!"  
    
    respond_to do |format|
      format.html { redirect_to usuario_path(@usuario) }
      format.js 
    end
  end

  def destroy
    @comunidad = RelacionComunidadUsuario.find(params[:id]).comunidad
    @usuario = RelacionComunidadUsuario.find(params[:id]).usuario
    @comunidad.desautorizar_usuario!(@usuario)
    
    #redirect_to unidades_autorizadas_usuario_path(@usuario)
    flash[:success] = "Se ha desautorizado a #{@usuario.nombre} para la comunidad #{@comunidad.nombre}!"
    
    respond_to do |format|
      format.html { redirect_to usuario_path(@usuario) }
      format.js 
    end
  end

  def update
    @permiso = RelacionComunidadUsuario.find(params[:relacion_comunidad_usuario][:id])
    @usuario = Usuario.find(params[:relacion_comunidad_usuario][:usuario_id])
    @comunidad = Comunidad.find(params[:relacion_comunidad_usuario][:comunidad_id])

    if @permiso.update_attributes(params[:relacion_comunidad_usuario])
      #flash[:success] = "Los permisos de #{@usuario.nombre} han sido actualizados!"
      # redirect_to comunidad_usuarios_path(@comunidad)
      #render :nothing => true
      respond_to do |format|
        format.html { redirect_to comunidad_usuarios_path(@comunidad) }
        format.js 
      end
      
    end  
  end

  def autorizar_administrador
    @usuario = Usuario.find(params[:relacion_comunidad_usuario][:usuario_id])
    current_comunidad.autorizar_administrador!(@usuario)

    respond_to do |format|
      format.html { redirect_to comunidad_usuarios_path(current_comunidad) }
      format.js 
    end
  end
end
