class RelacionunidadsController < ApplicationController
  
  before_filter :signed_in_user

  def create
  	@unidad_principal = Unidad.find(params[:relacionunidad][:principal_id])
  	@unidad_vinculada = Unidad.find(params[:relacionunidad][:vinculada_id])
    @unidad_principal.vincular!(@unidad_vinculada)
    #redirect_to @unidad_principal
    respond_to do |format|
      format.html { redirect_to @unidad_principal }
      format.js
    end
  end

  def destroy
    @unidad_vinculada = Relacionunidad.find(params[:id]).vinculada
    @unidad_principal = Relacionunidad.find(params[:id]).principal
    @unidad_principal.desvincular!(@unidad_vinculada)
    #redirect_to @unidad_principal
    respond_to do |format|
      format.html { redirect_to @unidad_principal }
      format.js
    end
  end
end
