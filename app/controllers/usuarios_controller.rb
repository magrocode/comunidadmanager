class UsuariosController < ApplicationController
 
  before_filter :signed_in_user
  before_filter :correct_comunidad,   :only => [:index, :new]
  before_filter :correct_user,        :only => [:show, :edit, :update, :unidades_autorizadas] 
  #before_filter :correct_editor,      :only => [:edit, :update]
  before_filter :admin_user,          :only => [:new, :destroy] 
  
  after_filter  :signin_after_update, :only => :update

  helper_method :sort_column, :sort_direction
  
  def index
    @comunidad = Comunidad.find(params[:comunidad_id])
    @usuarios = @comunidad.usuarios.paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
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
      flash[:success] = "Usuario creado!"
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
  
  def unidades_autorizadas
    @usuario = Usuario.find(params[:id])
    @comunidad = @usuario.comunidad
    @unidads = @usuario.unidades_autorizadas.paginate(page: params[:page], per_page: 10)
    render 'show_unidades_autorizadas'

    #@sort_model = Unidad
    #@sort_column = 'identificador'
    #@unidads = @comunidad.unidads.paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
    #render 'show_vinculadas'
  end


  private
  
    def signed_in_user
      # un usuario que se encuentra logeado
      redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
    end
       
    def correct_editor
      # un editor correcto es quien puede editar el perfil del usuario: administrador o propio usuario
      @usuario = Usuario.find(params[:id])
      redirect_to current_user, alert: "Ups!! parece que no tienes autorizacion sobre el usuario que deseas" unless (current_user?(@usuario)  or current_user.administrador?)
    end
    
    def admin_user
      # el administrador de la comunidad
      redirect_to(root_path) unless current_user.administrador?
    end
    
    def correct_user
      # el usuario correcto es el mismo usuario conectado o administrador
      @usuario = Usuario.find(params[:id])
      redirect_to current_user, alert: "Ups!! parece que no tienes autorizacion sobre el usuario que deseas" unless current_user?(@usuario)  or current_user.administrador?

    end
    
    def correct_comunidad
      # comunidad correcta es una comunidad perteneciente al usuario
      @comunidad_autorizada = current_user.comunidad
      @comunidad_solicitada = Comunidad.find(params[:comunidad_id])
      redirect_to root_path if @comunidad_autorizada != @comunidad_solicitada  
    end

    def signin_after_update
      # una vez que el usuario es actualizado se logea automaticamente
      @usuario = Usuario.find(params[:id])
      sign_in @usuario if current_user?(@usuario)
    end
    
    def sort_column
      Usuario.column_names.include?(params[:sort]) ? params[:sort] : "email"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
