class ComunidadsController < ApplicationController
  #before_filter :signed_in_user, only: [:index, :edit, :update]
  #before_filter :correct_user, only: [:show, :unidads]
  #before_filter :admin_user, only: [:edit, :update]
  
  def new
    @comunidad = Comunidad.new
    @usuario = @comunidad.usuarios.build
  end

  def show
    @comunidad = Comunidad.find(params[:id])
    redirect_to root_path if @comunidad.nil?
  end
  
  def create
    @comunidad = Comunidad.new(params[:comunidad])
    @usuario = @comunidad.usuarios.build(email: params[:usuario][:email],
                                         nombre: params[:usuario][:nombre],
                                         administrador: true,
                                         password: params[:usuario][:password],
                                         password_confirmation: params[:usuario][:password_confirmation])
    if @comunidad.valid? and @usuario.valid?                                     
      if @comunidad.save
        if @usuario.save 
          sign_in @usuario
          flash[:success] = "Bienvenido a Comunidad Manager!"
          #redirect_to @comunidad
          redirect_to root_path
        end
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
