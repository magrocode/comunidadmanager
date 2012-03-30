class UnidadsController < ApplicationController
  before_filter :signed_in_user
  
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
  
  def index
    @unidads = Unidad.all
  end
  
end
