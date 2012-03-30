class ComunidadsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:show]
  #before_filter :admin_user, only: [:edit, :update]
  
  def new
    @comunidad = Comunidad.new
  end

  def show
    @comunidad = Comunidad.find(params[:id])
  end
  
  def create
    @comunidad = Comunidad.new(params[:comunidad])
    if @comunidad.save
      sign_in @comunidad
      flash[:success] = "Bienvenido a Comunidad Manager!"
      redirect_to @comunidad
    else
      render 'new'
    end
  end
  
   private
  
    #def signed_in_user
    #  redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
    #end
    
    def correct_user
      @comunidad = Comunidad.find(params[:id])
      redirect_to(root_path) unless current_user?(@comunidad)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
