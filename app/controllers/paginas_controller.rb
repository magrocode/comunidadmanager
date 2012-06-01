class PaginasController < ApplicationController
  before_filter :signed_in_user, only: [:wellcome]
  before_filter :home_signed_in_user, only: [:home]
  
  def home
  end
  
  def wellcome
  end
  
  private
  
    def signed_in_user
      redirect_to root_path unless signed_in?  
    end
    
    def home_signed_in_user
      # si el usuario esta logueado redirecciona a pagina wellcome
      # redirect_to wellcome_path if signed_in?      
      redirect_to comunidad_path(current_user.comunidad) if signed_in?
    end

end
