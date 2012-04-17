class UsuariosController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, :only => [:new, :destroy]
  
  
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
  
  def edit
    @usuario = Usuario.find(params[:id])
    @comunidad =  @usuario.comunidad
  end
  
  def update
    @usuario = Usuario.find(params[:id])
    @comunidad = @usuario.comunidad
    
    if @usuario.update_attributes(params[:usuario])
      flash[:success] = "Usuario actualizado exitosamente!"
      redirect_to usuario_path
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @usuario = Usuario.find(params[:id])
    @comunidad = @usuario.comunidad
    @usuario.destroy
    
    redirect_to comunidad_usuarios_path(@comunidad)
  end
  
  private
  
    def signed_in_user
      redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
    end
    
    
    def correct_user
      @usuario = Usuario.find(params[:id])
      redirect_to(root_path) unless current_user?(@usuario)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.administrador?
    end
end
