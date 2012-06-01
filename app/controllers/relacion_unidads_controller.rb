class RelacionUnidadsController < ApplicationController
  
  before_filter :signed_in_user
  before_filter :admin_user
  
  def create
  	@unidad = Unidad.find(params[:relacion_unidad][:principal_id])
  	@unidad_vinculada = Unidad.find(params[:relacion_unidad][:vinculada_id])
    @unidad.vincular!(@unidad_vinculada)
    #redirect_to @unidad
    respond_to do |format|
      format.html { redirect_to vinculadas_unidad_path(@unidad) }
      format.js
    end
  end

  def destroy
    @unidad_vinculada = RelacionUnidad.find(params[:id]).vinculada
    @unidad = RelacionUnidad.find(params[:id]).principal
    @unidad.desvincular!(@unidad_vinculada)
    #redirect_to @unidad
    respond_to do |format|
      format.html { redirect_to vinculadas_unidad_path(@unidad) }
      format.js
    end
  end

  private 

  def signed_in_user
     # un usuario que se encuentra logeado
     redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
  end

  def admin_user
    # el administrador de la comunidad
    redirect_to(root_path) unless current_user.administrador?
  end
end
