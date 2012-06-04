class ComunidadsController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update, :show]
  before_filter :usuario_correcto, only: [:show, :edit]
  before_filter :usuario_administrador, only: [:edit, :update]
  before_filter :usuario_systemadmin, only: [:index]

  helper_method :sort_column, :sort_direction


  def index
    @comunidads = Comunidad.paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
  end 

  def new
    @comunidad = Comunidad.new
    @usuario = @comunidad.usuarios.build
  end

  def show
    @comunidad = Comunidad.find(params[:id])
    redirect_to root_path if @comunidad.nil?
  end
  
  def create
    @comunidad = Comunidad.new(nombre: params[:comunidad][:nombre])
    @usuario = @comunidad.usuarios.build(email: params[:usuario][:email],
                                         nombre: params[:usuario][:nombre],
                                         administrador: true,
                                         password: params[:usuario][:password],
                                         password_confirmation: params[:usuario][:password_confirmation])
    if @comunidad.valid? and @usuario.valid?                                     
      if @comunidad.save
        if @usuario.save 
          sign_in @usuario
          flash[:success] = "Bienvenido a Bloombee!"
          redirect_to @comunidad
          #redirect_to root_path
        end
      end      
    else
      render 'new'
    end
  end
  
  def edit
    @comunidad = Comunidad.find(params[:id])  
  end
  
  def update
    @comunidad = Comunidad.find(params[:id])
    
    if @comunidad.update_attributes(params[:comunidad])
      flash[:success] = "Comunidad actualizada exitosamente!"
      redirect_to comunidad_path
    else
      render action: 'edit'
    end  
  end
  
  #def unidads
  #  @comunidad = Comunidad.find(params[:id])
  #  @unidads = @comunidad.unidads
  #  render 'show_unidads'
  #end
  
  private
  
    def signed_in_user
      redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
    end
    
    def usuario_correcto
      # el usuario correcto pertenece a la comunidad, o es system_admin
      # el usuario correcto podra ver solamente :show
      @comunidad_autorizada = current_user.comunidad
      @comunidad_solicitada = Comunidad.find(params[:id])
      
      redirect_to comunidad_path(current_user.comunidad), alert: "Rayos! no tienes permisos en la comunidad que deseas..." unless @comunidad_autorizada == @comunidad_solicitada or current_user.system_admin?

      # el usuario correcto es el mismo usuario conectado o el administrador, o el systemadmin
      #@usuario = current_user
      #redirect_to current_user.comunidad, alert: "Ups!! parece que no tienes autorizacion sobre el usuario que deseas" unless current_user?(@usuario)  or current_user.administrador? or current_user.system_admin?
    end
    
    def usuario_administrador
      redirect_to(root_path) unless current_user.administrador?
    end

    def usuario_systemadmin
      redirect_to(root_path) unless current_user.system_admin?
    end

    def sort_column
      Comunidad.column_names.include?(params[:sort]) ? params[:sort] : "nombre"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
