class RelacionunidadsController < ApplicationController

  def create
  	@unidad_principal = Unidad.find(params[:relacionunidad][:principal_id])
  	@unidad_vinculada = Unidad.find(params[:relacionunidad][:vinculada_id])
    @unidad_principal.vincular!(@unidad_vinculada)
    redirect_to @unidad_principal
  end

  def destroy
  end
end
