
def sign_in(usuario)
  visit signin_path
  fill_in "session_email", with: usuario.email
  fill_in "session_password", with: usuario.password
  click_button "Entrar"
  
  cookies[:remember_token] = usuario.remember_token
end
