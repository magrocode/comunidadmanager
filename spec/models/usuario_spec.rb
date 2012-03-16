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
#  password_digest  :string(255)
#  remember_token   :string(255)
#  admin            :boolean
#

require 'spec_helper'

describe Usuario do
  
  before { @usuario = Usuario.new(nombre_comunidad: "Comunidad de Ejemplo", email: "mario@magrocode.com", 
                                  direccion: "Huerfanos 1055", ciudad: "Santiago", region: "Region metropolitana",
                                  pais: "Chile", password: "foobar", password_confirmation: "foobar") }
                                  
  subject { @usuario }
  
  it { should respond_to(:nombre_comunidad) }
  it { should respond_to(:email) }
  it { should respond_to(:direccion) }  
  it { should respond_to(:ciudad) }
  it { should respond_to(:region) }
  it { should respond_to(:pais) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  
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
    emails_validos = %w[example.user@foo.com mario.espinoza@magrocode.com mario_espinoza@magrocode.com]
    emails_validos.each do |email_valido|
      before { @usuario.email = email_valido }
      it { should be_valid }
    end
  end
  
  describe "Cuando email ya existe" do
    before do
      usuario_con_mismo_email = @usuario.dup
      usuario_con_mismo_email.email = @usuario.email.upcase
      usuario_con_mismo_email.save      
    end
    
    it { should_not be_valid }
  end
  
  describe "Cuando el password no esta presente" do
    before { @usuario.password = @usuario.password_confirmation = " " }
    it { should_not be_valid }
  end
  
  describe "Cuando el password no coincide con la confirmacion" do
    before { @usuario.password_confirmation = "nocoincidente" }
    it { should_not be_valid }
  end
  
  describe "Cuando confirmacion de password esta vacia" do
    before { @usuario.password_confirmation = nil }
    it { should_not be_valid }
  end
    
end
