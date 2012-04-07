class UnidadsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user
  
  def index
    @comunidad = Comunidad.find(params[:comunidad_id])
    @unidads = @comunidad.unidads
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
      redirect_to [@comunidad, @unidad]
    else
       render action: 'new'  
    end
  end
  
  def show
    @comunidad = Comunidad.find(params[:comunidad_id])
    @unidad = @comunidad.unidads.find(params[:id])
  end
  
  def edit
    @comunidad = Comunidad.find(params[:comunidad_id])
    @unidad = @comunidad.unidads.find(params[:id])
  end
      
  def update
    @comunidad = Comunidad.find(params[:comunidad_id])
    @unidad = @comunidad.unidads.find(params[:id])
    
    if @unidad.update_attributes(params[:unidad])
       flash[:success] = "Unidad fue actualizada satisfactoriamente."
       redirect_to comunidad_unidad_path
     else
       render action: 'edit'
    end
  end
  
  def destroy
    @unidad = Unidad.find(params[:id])
    @unidad.destroy
    @comunidad = Comunidad.find(params[:comunidad_id])
    
    redirect_to comunidad_unidads_path
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
      redirect_to(root_path, notice: "No esta habilitado para ver la informacion!") unless current_user?(@comunidad)
    end
  
end