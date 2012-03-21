class UsuariosController < ApplicationController
  
  def new
    @usuario = Usuario.new
  end

  def show
    @usuario = Usuario.find(params[:id])
  end
  
  def create
    @usuario = Usuario.new(params[:usuario])
    if @usuario.save
      flash[:success] = "Bienvenido a Comunidad Manager!"
      redirect_to @usuario
    else
      render 'new'
    end
  end
end
