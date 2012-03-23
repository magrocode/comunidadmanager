class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    comunidad = Comunidad.find_by_email(params[:session][:email])
    if comunidad && comunidad.authenticate(params[:session][:password])
      # Sign la comunidad y redirecciona a la pagina de comunidad
      sign_in comunidad  # necesita definirse
      redirect_to comunidad
    else
      # crea un mensaje de error y re-renderiza el formulario signin
      flash.now[:error] = 'Combinacion email/password es invalida'
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
end
