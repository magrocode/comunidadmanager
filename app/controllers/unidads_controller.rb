class UnidadsController < ApplicationController
  
  before_filter :signed_in_user
  before_filter :comunidad_correcta,    :only => [:index, :new]
  before_filter :usuario_en_comunidad,  :only => [:show, :vinculadas, :usuarios_autorizados]
  before_filter :admin_user,            :only => [:new, :edit, :update, :destroy]
  #before_filter :usuario_autorizado,    :only => [:show, :vinculadas, :usuarios_autorizados]  #, :edit, :destroy, :update]

  helper_method :sort_column, :sort_direction
  
  def index
    @comunidad = Comunidad.find(params[:comunidad_id])
    @sort_model = Unidad
    @sort_column = 'identificador'
    @unidads = @comunidad.unidads.paginate(page: params[:page],
             per_page: 10).order(sort_column + " " + sort_direction)
  end
  
  def new 
    @comunidad = Comunidad.find(params[:comunidad_id])
    @unidad = @comunidad.unidads.build
  end
  
  def create  
    @comunidad = Comunidad.find(params[:comunidad_id])
    @unidad = @comunidad.unidads.build(params[:unidad])
    
    if @unidad.save
      flash[:success] = "Unidad creada!"
      redirect_to comunidad_unidads_path(@comunidad)
    else
       render action: 'new'  
    end
  end
  
  def show
    @unidad = Unidad.find(params[:id])
    @comunidad = @unidad.comunidad
  end
  
  def edit
    @unidad = Unidad.find(params[:id])
    @comunidad = @unidad.comunidad
  end
      
  def update
    @unidad = Unidad.find(params[:id])
    @comunidad = @unidad.comunidad
    
    if @unidad.update_attributes(params[:unidad])
       flash[:success] = "Unidad actualizada exitosamente!"
       #redirect_to comunidad_unidad_path
       redirect_to comunidad_unidads_path(@comunidad)
     else
       render action: 'edit'
    end
  end
  
  def destroy
    @unidad = Unidad.find(params[:id])
    @comunidad = @unidad.comunidad
    @unidad.destroy
    flash[:success] = "Unidad eliminada"
    redirect_to comunidad_unidads_path(@comunidad)
  end
  
  def vinculadas
    @unidad = Unidad.find(params[:id])
    @comunidad = @unidad.comunidad
    @sort_model = Unidad
    @sort_column = 'identificador'
    @unidads = @unidad.vinculadas.paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
    render 'show_vinculadas'
  end

  def usuarios_autorizados
    @unidad = Unidad.find(params[:id])
    @comunidad = @unidad.comunidad
    @sort_model = Usuario
    @sort_column = 'nombre'
    @usuarios = @unidad.usuarios_autorizados.paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
    render 'show_usuarios_autorizados'
  end


  private
  
    def signed_in_user
      # usuario logeado
      redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
    end
    
    def admin_user
      # permisos de usuario administrador
      redirect_to comunidad_unidads_path(current_comunidad), notice: "Esto es injusto!! Solo el administrador puede realizar esta accion" unless current_user.administrador? or current_user.system_admin?
    end
    
    def usuario_en_comunidad
      @unidad = Unidad.find(params[:id])
      redirect_to comunidad_unidads_path(current_comunidad), notice: "Bochornoso! no estas autorizado para realizar acciones en la comunidad que deseas" unless (@unidad.comunidad == current_comunidad) or current_user.system_admin?
    end
       
    def comunidad_correcta
      # comunidad correcta es una comunidad perteneciente al usuario logeado
      @comunidad_autorizada = current_comunidad
      @comunidad_solicitada = Comunidad.find(params[:comunidad_id])
      redirect_to comunidad_unidads_path(current_comunidad), alert: "Ups!! parece que estas intentando con la comunidad equivocada" unless @comunidad_autorizada == @comunidad_solicitada  or current_user.system_admin?
    end
    
    def usuario_autorizado      
      # buscar en el usuario actual la unidad a la que tiene autorizacion
      @unidad = current_user.unidades_autorizadas.find_by_id(params[:id])
      redirect_to comunidad_unidads_path(current_comunidad), alert: "Algo salio mal?? no tienes permisos para la unidad que deseas" unless !@unidad.nil? or current_user.administrador? or current_user.system_admin?
    end
    
    def sort_column
      @sort_model.column_names.include?(params[:sort]) ? params[:sort] : @sort_column
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
  
end