class UsuarioMailer < ActionMailer::Base
  default from: "mario@magrocode.com"
  
  def welcome_email(usuario)
  	@usuario = usuario
  	mail(:to => usuario.email, :subject => "Usuario Registrado en Cloudapolis")
  end
end