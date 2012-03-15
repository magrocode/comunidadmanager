# == Schema Information
#
# Table name: usuarios
#
#  id               :integer         not null, primary key
#  nombre_comunidad :string(255)
#  email            :string(255)
#  direccion        :string(255)
#  ciudad           :string(255)
#  region           :string(255)
#  pais             :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

require 'spec_helper'

describe Usuario do
  
  before { @usuario = Usuario.new(nombre_comunidad: "Comunidad de Ejemplo", email: "mario@magrocode.com", 
                                  direccion: "Huerfanos 1055", ciudad: "Santiago", region: "Region metropolitana",
                                  pais: "Chile") }
                                  
  subject { @usuario }
  
  it { should respond_to(:nombre_comunidad) }
  it { should respond_to(:email) }
  it { should respond_to(:direccion) }  
  it { should respond_to(:ciudad) }
  it { should respond_to(:region) }
  it { should respond_to(:pais) }
  
  it { should be_valid }
  
  describe "Cuando Usuario invalido" do
    before { @usuario.nombre_comunidad = " " }
    it { should_not be_valid }
  end
  
  describe "Cuando nombre es demasiado largo" do
    before { @usuario.nombre_comunidad = "a" * 51 }
    it { should_not be_valid }    
  end
  
  describe "Cuando formato email es invalido" do
    emails_invalidos = %w[usuario@foo,com user_at_foo.org example.user@foo.]
    emails_invalidos.each do |email_invalido|
      before { @usuario.email = email_invalido }
      it { should_not be_valid}
    end
  end
  
  describe "Cuando formato email es valido" do
    emails_validos = %w[usuario@foo.com mario.espinoza@magrocode.com mario_espinoza@magrocode.com]
    emails_validos.each do |email_valido|
      before { @usuario.email = email_valido }
      it { should be_valid }
    end
  end
  
end
