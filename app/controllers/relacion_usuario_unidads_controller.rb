class RelacionUsuarioUnidadsController < ApplicationController
  
  before_filter :signed_in_user

  def create
  	@usuario = Usuario.find(params[:relacion_usuario_unidad][:usuario_id])
    @unidad = Unidad.find(params[:relacion_usuario_unidad][:unidad_id])
    @unidad.autorizar_usuario!(@usuario)
    
    respond_to do |format|
      format.html { redirect_to @unidad }
      format.js
    end
  end

  def destroy
    @usuario = RelacionUsuarioUnidad.find(params[:id]).usuario
    @unidad = RelacionUsuarioUnidad.find(params[:id]).unidad
    @unidad.desautorizar_usuario!(@usuario)
    
    respond_to do |format|
      format.html { redirect_to @unidad }
      format.js
    end
  end
end
