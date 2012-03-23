class ComunidadsController < ApplicationController
  
  def new
    @comunidad = Comunidad.new
  end

  def show
    @comunidad = Comunidad.find(params[:id])
  end
  
  def create
    @comunidad = Comunidad.new(params[:comunidad])
    if @comunidad.save
      sign_in @comunidad
      flash[:success] = "Bienvenido a Comunidad Manager!"
      redirect_to @comunidad
    else
      render 'new'
    end
  end
end
