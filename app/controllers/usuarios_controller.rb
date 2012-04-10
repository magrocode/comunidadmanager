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
      sign_in @usuario
      flash[:success] = "Bienvenido a bloombee!"
      redirect_to @usuario
    else
      render 'new'
    end
  end
  
  private
  
    def correct_user
      @usuario = Usuario.find(params[:id])
      redirect_to(root_path) unless current_user?(@usuario)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
