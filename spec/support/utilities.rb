
def sign_in(usuario)
  visit signin_path
  fill_in "Email", with: usuario.email
  fill_in "Password", with: usuario.password
  click_button "Sign in"
  
  cookies[:remember_token] = usuario.remember_token
end
