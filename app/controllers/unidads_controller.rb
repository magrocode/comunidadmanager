class UnidadsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit]
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
    @unidad = Unidad.find(params[:comunidad][:id])
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