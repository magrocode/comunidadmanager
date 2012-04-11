class PaginasController < ApplicationController
  before_filter :signed_in_user, only: [:home]
  
  def home
  end
  
  private
  
    def signed_in_user
      # si el usuario esta logueado redirecciona a perfil de comunidad
      redirect_to current_user if signed_in?      
    end

end
