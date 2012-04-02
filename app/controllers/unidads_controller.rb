class UnidadsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:show]
  
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
  
    
  private
  
    def correct_user
      @unidad = current_user.unidads.find_by_id(params[:id])
      redirect_to root_path if @unidad.nil?
    end
  
end