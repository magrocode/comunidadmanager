class RelacionComunidadUsuariosController < ApplicationController
  
  def create
  end

  def destroy
  end

  def update
    @permiso = RelacionComunidadUsuarios.find(params[:id])
    
    if @permiso.update_attributes(params[:comunidad])
      flash[:success] = "Comunidad actualizada exitosamente!"
      redirect_to comunidad_path
    end  
  end
end
