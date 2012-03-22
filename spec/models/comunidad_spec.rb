# == Schema Information
#
# Table name: comunidads
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
#

require 'spec_helper'

describe Comunidad do
  
  before { @comunidad = Comunidad.new(nombre_comunidad: "Comunidad de Ejemplo", email: "mario@magrocode.com", 
                                  direccion: "Huerfanos 1055", ciudad: "Santiago", region: "Region metropolitana",
                                  pais: "Chile", password: "foobar", password_confirmation: "foobar") }
                                  
  subject { @comunidad }
  
  it { should respond_to(:nombre_comunidad) }
  it { should respond_to(:email) }
  it { should respond_to(:direccion) }  
  it { should respond_to(:ciudad) }
  it { should respond_to(:region) }
  it { should respond_to(:pais) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  
  it { should be_valid }
  
  describe "Cuando Comunidad invalido" do
    before { @comunidad.nombre_comunidad = " " }
    it { should_not be_valid }
  end
  
  describe "Cuando nombre es demasiado largo" do
    before { @comunidad.nombre_comunidad = "a" * 51 }
    it { should_not be_valid }    
  end
  
  describe "Cuando formato email es invalido" do
    emails_invalidos = %w[comunidad@foo,com user_at_foo.org example.user@foo.]
    emails_invalidos.each do |email_invalido|
      before { @comunidad.email = email_invalido }
      it { should_not be_valid}
    end
  end
  
  describe "Cuando formato email es valido" do
    emails_validos = %w[example.user@foo.com mario.espinoza@magrocode.com mario_espinoza@magrocode.com]
    emails_validos.each do |email_valido|
      before { @comunidad.email = email_valido }
      it { should be_valid }
    end
  end
  
  describe "Cuando email ya existe" do
    before do
      comunidad_con_mismo_email = @comunidad.dup
      comunidad_con_mismo_email.email = @comunidad.email.upcase
      comunidad_con_mismo_email.save      
    end
    
    it { should_not be_valid }
  end
  
  describe "Cuando el password no esta presente" do
    before { @comunidad.password = @comunidad.password_confirmation = " " }
    it { should_not be_valid }
  end
  
  describe "Cuando el password no coincide con la confirmacion" do
    before { @comunidad.password_confirmation = "nocoincidente" }
    it { should_not be_valid }
  end
  
  describe "Cuando confirmacion de password esta vacia" do
    before { @comunidad.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "con un password que esta muy corto" do
    before { @comunidad.password = @comunidad.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  describe "retorna valor de metodo authenticate" do
    before { @comunidad.save }
    let(:comunidad_encontrado) { Comunidad.find_by_email(@comunidad.email) }
    
    describe "con password valido" do
      it { should == comunidad_encontrado.authenticate(@comunidad.password) }
    end
    
    describe "con password invalido" do
      let(:comunidad_para_password_invalido) { comunidad_encontrado.authenticate("invalido") }
      
      it { should_not == comunidad_para_password_invalido }
      specify { comunidad_para_password_invalido.should be_false }
    end
  end
  
  describe "remember token" do
    before { @comunidad.save }
    its(:remember_token) { should_not be_blank }
  end
    
end
