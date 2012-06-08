class RelacionUsuarioUnidadsController < ApplicationController
  
  before_filter :signed_in_user

  def create
  	@usuario = Usuario.find(params[:relacion_usuario_unidad][:usuario_id])
    @unidad = Unidad.find(params[:relacion_usuario_unidad][:unidad_id])
    @unidad.autorizar_usuario!(@usuario)
    
    #redirect_to unidades_autorizadas_usuario_path(@usuario)
    flash[:success] = "Se ha autorizado correctamente a #{@usuario.nombre} para la unidad #{@unidad.identificador}!"  
    redirect_to :back
  end

  def destroy
    @usuario = RelacionUsuarioUnidad.find(params[:id]).usuario
    @unidad = RelacionUsuarioUnidad.find(params[:id]).unidad
    @unidad.desautorizar_usuario!(@usuario)
    
    #redirect_to unidades_autorizadas_usuario_path(@usuario)
    flash[:success] = "Se ha desautorizado a #{@usuario.nombre} para la unidad #{@unidad.identificador}!"
    redirect_to :back
  end
end
