class UnidadsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:show]
  
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
    #@user = User.find(params[:id])
    if @unidad.update_attributes(params[:comunidad][:unidad])
       flash[:success] = "Unidad actualizada"
       #sign_in @user
       #redirect_to @unidad
     else
       render 'edit'
    end
  end
  
  private
  
    def correct_user
      @unidad = current_user.unidads.find_by_id(params[:id])
      redirect_to root_path if @unidad.nil?
    end
    #def correct_user
    #  @comunidad = Comunidad.find(params[:comunidad_id])
    #  redirect_to(root_path) unless current_user?(@comunidad)
    #end
  
end