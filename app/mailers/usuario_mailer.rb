class UsuarioMailer < ActionMailer::Base
  default from: "mario@magrocode.com"
  
  def registration_confirmation(usuario)
  	mail(:to => usuario.email, :subject => "Registrado")
  end
end