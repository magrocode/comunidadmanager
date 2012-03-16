class UsuariosController < ApplicationController
  
  def new
    @usuario = Usuario.new
  end

end
