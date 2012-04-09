class UnidadsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, :only => [:index, :new, :create]
  before_filter :propietario, :only => [:show, :edit, :destroy, :update]
  
  def index
    @comunidad = Comunidad.find(params[:comunidad_id])
    @unidads = @comunidad.unidads.paginate(page: params[:page], :per_page => 3)
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
      #redirect_to [@comunidad, @unidad]
      redirect_to @unidad
    else
       render action: 'new'  
    end
  end
  
  def show
    #@comunidad = Comunidad.find(params[:comunidad_id])
    #@unidad = @comunidad.unidads.find(params[:id])
    
    # Alternativa
    @unidad = Unidad.find(params[:id])
    @comunidad = @unidad.comunidad
  end
  
  def edit
    #@comunidad = Comunidad.find(params[:comunidad_id])
    #@unidad = @comunidad.unidads.find(params[:id])
    
    # Alternativa
    @unidad = Unidad.find(params[:id])
    @comunidad = @unidad.comunidad
  end
      
  def update
    #@comunidad = Comunidad.find(params[:comunidad_id])
    #@unidad = @comunidad.unidads.find(params[:id])
    
    # Alternativa
    @unidad = Unidad.find(params[:id])
    @comunidad = @unidad.comunidad
    
    if @unidad.update_attributes(params[:unidad])
       flash[:success] = "Unidad fue actualizada satisfactoriamente."
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
  
    #def correct_user
    #  @unidad = current_user.unidads.find_by_id(params[:id])
    #  redirect_to root_path if @unidad.nil?
    #end
     
    
    #def correct_user
    #  @comunidad = Comunidad.find(params[:comunidad_id])
    #  redirect_to(root_path, notice: "No esta habilitado para ver la informacion!") unless current_user?(@comunidad)
    #end
    
    def correct_user
      @comunidad = Comunidad.find(params[:comunidad_id])
      redirect_to(root_path, notice: "No esta habilitado para ver la informacion!") unless current_user?(@comunidad)
    end
    
    def propietario
      # buscar en el usuario actual la unidad
      @unidad = current_user.unidads.find_by_id(params[:id])
      redirect_to root_path if @unidad.nil?
    end
    
    #def comunidad_correcta
    #  @comunidad = Comunidad.find(params[:comunidad_id])
    #  redirect_to(root_path, notice: "No esta habilitado para ver la informacion!") unless current_user?(@comunidad)
    #end
  
end