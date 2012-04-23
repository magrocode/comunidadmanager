class UnidadsController < ApplicationController
  
  before_filter :signed_in_user
  before_filter :correct_comunidad, :only => [:index]
  before_filter :correct_user, :only => [:show, :edit, :update]
  before_filter :admin_user, :only => [:new, :destroy]

  #before_filter :propietario, :only => [:show, :edit, :destroy, :update]

  helper_method :sort_column, :sort_direction
  
  def index
    @comunidad = Comunidad.find(params[:comunidad_id])
    @unidads = @comunidad.unidads.paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
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
      redirect_to @unidad
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
       redirect_to unidad_path
     else
       render action: 'edit'
    end
  end
  
  def destroy
    @unidad = Unidad.find(params[:id])
    @comunidad = @unidad.comunidad
    @unidad.destroy

    redirect_to comunidad_unidads_path(@comunidad)
  end
  
  private
  
    def signed_in_user
      redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
    end
    
    def admin_user
      redirect_to(root_path, notice: "No esta habilitado para ver la informacion!") unless current_user.administrador?
    end
    
    def correct_user
      @unidad = Unidad.find(params[:id])
      redirect_to root_path if (@unidad.comunidad != current_user.comunidad or !current_user.administrador?)
    end
       
    def correct_comunidad
      @comunidad_autorizada = current_user.comunidad
      @comunidad_solicitada = Comunidad.find(params[:comunidad_id])
      redirect_to root_path if @comunidad_autorizada != @comunidad_solicitada  
    end
    
    def propietario
      # buscar en el usuario actual la unidad
      @unidad = current_user.unidads.find_by_id(params[:id])
      redirect_to root_path if @unidad.nil?
    end
    
    def sort_column
      Unidad.column_names.include?(params[:sort]) ? params[:sort] : "identificador"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
  
end