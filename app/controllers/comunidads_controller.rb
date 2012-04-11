class ComunidadsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:show, :unidads]
  #before_filter :admin_user, only: [:edit, :update]
  
  def new
    @comunidad = Comunidad.new
    @usuario = Usuario.new
  end

  def show
    @comunidad = Comunidad.find(params[:id])
  end
  
  def create
    @comunidad = Comunidad.new(params[:comunidad])
    @usuario = Usuario.new(:email => "mario@magrocode.com", 
                            :nombre => "Mario Espinoza", 
                            :administrador => true,
                            :password => "foobar",
                            :password_confirmation => "foobar")
    if @comunidad.save
      if @usuario.save 
        sign_in @usuario
        flash[:success] = "Bienvenido a Comunidad Manager!"
        #redirect_to @comunidad
        redirect_to root_path
      end      
    else
      render 'new'
    end
  end
  
  #def unidads
  #  @comunidad = Comunidad.find(params[:id])
  #  @unidads = @comunidad.unidads
  #  render 'show_unidads'
  #end
  
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
