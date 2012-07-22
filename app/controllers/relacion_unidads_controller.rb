class RelacionUnidadsController < ApplicationController
  
  before_filter :signed_in_user
  before_filter :admin_user
  
  def create
  	@unidad = Unidad.find(params[:relacion_unidad][:principal_id])
  	@unidad_vinculada = Unidad.find(params[:relacion_unidad][:vinculada_id])
    @unidad.vincular!(@unidad_vinculada)
    #redirect_to @unidad
    flash[:success] = "Se ha vinculado la unidad #{@unidad_vinculada.identificador} a #{@unidad.identificador}"
    redirect_to :back
    
  end

  def destroy
    @unidad_vinculada = RelacionUnidad.find(params[:id]).vinculada
    @unidad = RelacionUnidad.find(params[:id]).principal
    @unidad.desvincular!(@unidad_vinculada)
    #redirect_to @unidad
    
    flash[:success] = "Se ha desvinculado la unidad #{@unidad_vinculada.identificador} de #{@unidad.identificador}"
    redirect_to :back
  end

  private 

  def signed_in_user
     # un usuario que se encuentra logeado
     redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
  end

  def admin_user
    # el administrador de la comunidad
    redirect_to(root_path) unless current_user.administrador?(current_comunidad) or current_user.system_admin?
  end
end
