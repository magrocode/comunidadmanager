module SessionsHelper
        
  def sign_in(usuario)
    cookies.permanent[:remember_token] = usuario.remember_token
    current_user = usuario
  end

  def set_comunidad(comunidad)
    cookies.permanent[:comunidad_id] = comunidad.id 
    current_comunidad = comunidad
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(usuario)
    @current_user = usuario
  end

  def current_comunidad=(comunidad)
    @current_comunidad = comunidad
  end
  
  def current_user
    @current_user  ||= user_from_remember_token
  end

  def current_comunidad
    @current_comunidad ||= comunidad_from_cookie
  end
  
  def current_user?(usuario)
    usuario == current_user
  end

  def current_comunidad?(comunidad)
    comunidad == current_comunidad
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Por favor, inicie sesion."
    end
  end
  
  def sign_out
    current_user = nil
    cookies.delete(:remember_token)    
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
  private
    
    def user_from_remember_token
      remember_token = cookies[:remember_token]
      Usuario.find_by_remember_token(remember_token) unless remember_token.nil?
    end

    def comunidad_from_cookie
      comunidad_id = cookies[:comunidad_id]
      Comunidad.find_by_id(comunidad_id) unless comunidad_id.nil?
    end
    
    def clear_return_to
      session.delete(:return_to)
    end
end
