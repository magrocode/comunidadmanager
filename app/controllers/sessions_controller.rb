class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    usuario = Usuario.find_by_email(params[:session][:email])
    if usuario && usuario.authenticate(params[:session][:password])
      # Sign la comunidad y redirecciona a la pagina de comunidad
      sign_in usuario

      set_locale

      if usuario.comunidads.size > 1
        set_comunidad usuario.comunidads.first
        redirect_to usuario.comunidads.first
      else
        # redireccionar a seleccionar una unidad
        set_comunidad usuario.comunidads.first
        redirect_to usuario.comunidads.first
      end
    else
      # crea un mensaje de error y re-renderiza el formulario signin
      flash.now[:error] = 'Combinacion email/password es invalida'
      render 'new'
    end
  end
  
  def destroy
    sign_out    
    redirect_to signin_path
    flash[:success] = 'Ha cerrado su sesion!'
  end
  
end
