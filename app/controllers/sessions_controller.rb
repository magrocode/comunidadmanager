class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    usuario = Usuario.find_by_email(params[:session][:email])
    if usuario && usuario.authenticate(params[:session][:password])
      # Sign la comunidad y redirecciona a la pagina de comunidad
      sign_in usuario 
      redirect_to wellcome_path #usuario.comunidad
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
