class RelacionUnidadsController < ApplicationController
  
  before_filter :signed_in_user

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
end
