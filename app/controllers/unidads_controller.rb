class UnidadsController < ApplicationController
  before_filter :signed_in_user
  #before_filter :correct_user, only: [:index, :new]
  
  def index
    @comunidad = Comunidad.find(params[:comunidad_id])
    @unidads = @comunidad.unidads
  end
  
  def new
    @unidad = Unidad.new
  end
  
  def create
    @unidad = current_user.unidads.build(params[:unidad])
    if @unidad.save
      flash[:success] = "Unidad creada!"
      redirect_to @unidad
    else
       render 'new'  
    end
  end
  
  def show
    @unidad = Unidad.find(params[:id])
  end
  
  def edit
    @unidad = Unidad.find(params[:id])
  end
      
  def update
    @unidad = Unidad.find(params[:id])
    
    if @unidad.update_attributes(params[:unidad])
       flash[:success] = "Unidad actualizada"
       redirect_to @unidad
     else
       render 'edit'
    end
  end
  
  private
  
    def signed_in_user
      redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
    end
  
    #def correct_user
    #  @unidad = current_user.unidads.find_by_id(params[:id])
    #  redirect_to root_path if @unidad.nil?
    #end
    
    def correct_user
      @comunidad = Comunidad.find(params[:comunidad_id])
      redirect_to(root_path) unless current_user?(@comunidad)
    end
  
end