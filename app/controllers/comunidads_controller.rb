class ComunidadsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :show]
  before_filter :correct_user, only: [:show]
  before_filter :admin_user, only: [:edit, :update]
  
  def new
    @comunidad = Comunidad.new
    @usuario = @comunidad.usuarios.build
  end

  def show
    @comunidad = Comunidad.find(params[:id])
    redirect_to root_path if @comunidad.nil?
  end
  
  def create
    @comunidad = Comunidad.new(nombre: params[:comunidad][:nombre])
    @usuario = @comunidad.usuarios.build(email: params[:usuario][:email],
                                         nombre: params[:usuario][:nombre],
                                         administrador: true,
                                         password: params[:usuario][:password],
                                         password_confirmation: params[:usuario][:password_confirmation])
    if @comunidad.valid? and @usuario.valid?                                     
      if @comunidad.save
        if @usuario.save 
          sign_in @usuario
          flash[:success] = "Bienvenido a Bloombee!"
          redirect_to @comunidad
          #redirect_to root_path
        end
      end      
    else
      render 'new'
    end
  end
  
  def edit
    @comunidad = Comunidad.find(params[:id])  
  end
  
  def update
    @comunidad = Comunidad.find(params[:id])
    
    if @comunidad.update_attributes(params[:comunidad])
      flash[:success] = "Comunidad actualizada exitosamente!"
      redirect_to comunidad_path
    else
      render action: 'edit'
    end  
  end
  
  #def unidads
  #  @comunidad = Comunidad.find(params[:id])
  #  @unidads = @comunidad.unidads
  #  render 'show_unidads'
  #end
  
  private
  
    def signed_in_user
      redirect_to signin_path, notice: "Por favor autentiquese." unless signed_in?      
    end
    
    def correct_user
      @comunidad_autorizada = current_user.comunidad
      @comunidad_solicitada = Comunidad.find(params[:id])
      
      redirect_to root_path if @comunidad_autorizada != @comunidad_solicitada
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.administrador?
    end
end
