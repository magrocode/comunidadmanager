class UsuariosController < ApplicationController
  
  def index
    @comunidad = Comunidad.find(params[:comunidad_id])
    @usuarios = @comunidad.usuarios.paginate(page: params[:page], per_page: 3)  
  end
  
  def new
    @comunidad = Comunidad.find(params[:comunidad_id])
    @usuario = @comunidad.usuarios.build
  end
  
  def show
    @usuario = Usuario.find(params[:id])
    @comunidad = @usuario.comunidad
  end
  
  def create
    @comunidad = Comunidad.find(params[:comunidad_id])
    @usuario = @comunidad.usuarios.build(params[:usuario])
    
    if @usuario.save
      #sign_in @usuario
      flash[:success] = "Usuario creado"
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
