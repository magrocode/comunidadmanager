module SessionsHelper
  
  def sign_in(usuario)
    cookies.permanent[:remember_token] = usuario.remember_token
    current_user = usuario
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(usuario)
    @current_user = usuario
  end
  
  def current_user
    @current_user  ||= user_from_remember_token
  end
  
  def sign_out
    current_user = nil
    cookies.delete(:remember_token)    
  end


  private
  
    def user_from_remember_token
      remember_token = cookies[:remember_token]
      Comunidad.find_by_remember_token(remember_token) unless remember_token.nil?
    end
end
