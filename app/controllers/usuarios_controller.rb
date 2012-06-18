class UsuariosController < ApplicationController
 
  before_filter :signed_in_user
  before_filter :correct_comunidad,     :only => [:index, :new]
  #before_filter :correct_user,         :only => [:show, :edit, :update, :unidades_autorizadas]
  before_filter :correct_user,          :only => [:edit, :update,]
  before_filter :usuario_en_comunidad,  :only => [:show, :unidades_autorizadas]
  
  before_filter :admin_user,            :only => [:new, :destroy] 
  
  after_filter  :signin_after_update,   :only => :update

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
    @post = @comunidad.posts.build(usuario_id: current_user.id)
    @feed_posts = @usuario.feed_posts.paginate(page: params[:page], per_page: 10).order("created_at DESC")
  end
  
  def create
    @comunidad = Comunidad.find(params[:comunidad_id])
    @usuario = @comunidad.usuarios.build(params[:usuario])
    
    if @usuario.save
      UsuarioMailer.welcome_email(@usuario).deliver
      flash[:success] = "Usuario creado!"
      redirect_to comunidad_usuarios_path(@comunidad)
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
    
    params[:usuario].delete(:password) if params[:usuario][:password].blank?
    params[:usuario].delete(:password_confirmation) if params[:usuario][:password].blank? and params[:usuario][:password_confirmation].blank?
    if @usuario.update_attributes(params[:usuario])
      flash[:success] = "Usuario actualizado exitosamente!"
      redirect_to usuario_path(@usuario)
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @usuario = Usuario.find(params[:id])
    @comunidad = @usuario.comunidad
    @usuario.destroy
    flash[:success] = "Usuario eliminado"
    redirect_to comunidad_usuarios_path(@comunidad)
  end
  
  def unidades_autorizadas
    @usuario = Usuario.find(params[:id])
    @comunidad = @usuario.comunidad
    @unidads = @usuario.unidades_autorizadas.paginate(page: params[:page], per_page: 10)
    render 'show_unidades_autorizadas'
  end


  private
  
    def signed_in_user
      # un usuario que se encuentra logeado
      redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
    end
           
    def admin_user
      # el administrador de la comunidad o system_admin
      redirect_to comunidad_usuarios_path(current_user.comunidad), alert: "Wrong!! no eres administrador" unless current_user.administrador? or current_user.system_admin?
    end
    
    def correct_user
      # el usuario correcto es el mismo usuario conectado o administrador
      @usuario = Usuario.find(params[:id])
      redirect_to comunidad_usuarios_path(@usuario.comunidad), alert: "Ups!! parece que no tienes autorizacion sobre el usuario que deseas" unless current_user?(@usuario)  or current_user.administrador?
    end

    def usuario_en_comunidad
      @usuario = Usuario.find(params[:id])
      redirect_to comunidad_usuarios_path(current_user.comunidad), notice: "Bochornoso! no estas autorizado para realizar acciones en la comunidad que deseas" unless (@usuario.comunidad == current_user.comunidad) or current_user.system_admin?
    end
    
    def correct_comunidad
      # comunidad correcta es una comunidad perteneciente al usuario
      @comunidad_autorizada = current_user.comunidad
      @comunidad_solicitada = Comunidad.find(params[:comunidad_id])
      redirect_to comunidad_path(current_user.comunidad) unless @comunidad_autorizada == @comunidad_solicitada  or current_user.system_admin?
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
