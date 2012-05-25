# == Schema Information
#
# Table name: usuarios
#
#  id              :integer         not null, primary key
#  comunidad_id    :integer
#  email           :string(255)
#  nombre          :string(255)
#  administrador   :boolean
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

require 'spec_helper'

describe Usuario do

  let(:comunidad) { FactoryGirl.create(:comunidad) }
  before { @usuario = comunidad.usuarios.build(email: "mario@foobar.com",
                                               nombre: "Mario Espinoza",
                                               administrador: true,
                                               twitter: "@codelious",
                                               telefono: "56-9-8806-0177",
                                               password: "foobar",
                                               password_confirmation: "foobar") }
  subject { @usuario }
  
  it { should respond_to(:email) }
  it { should respond_to(:nombre) }
  it { should respond_to(:administrador) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:twitter) }
  it { should respond_to(:telefono) }
  it { should respond_to(:relacion_usuario_unidads) }
  it { should respond_to(:unidades_autorizadas) }
  it { should respond_to(:unidad_autorizada?) }
  it { should respond_to(:autorizar_unidad!) }
  it { should respond_to(:desautorizar_unidad!) }
  its(:comunidad) { should == comunidad }

  it { should be_valid }
  
  describe "Cuando Usuario es invalido" do
    before { @usuario.email = " " }
    it { should_not be_valid }
  end
  
  describe "Cuando nombre es demasiado largo" do
    before { @usuario.nombre = "a" * 51 }
    it { should_not be_valid }    
  end
  
  describe "Cuando formato email es invalido" do
    emails_invalidos = %w[usuario@foo,com user_at_foo.org example.user@foo.]
    emails_invalidos.each do |email_invalido|
      before { @usuario.email = email_invalido }
      it { should_not be_valid }
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
  
  describe "Cuando twitter es muy largo" do
    before { @usuario.twitter = "a" * 51 }
    it { should be_invalid }
  end

  describe "Cuando telefono es muy largo" do
    before { @usuario.telefono = "a" * 51 }
    it { should be_invalid }
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
  
  describe "con un password que esta muy corto" do
    before { @usuario.password = @usuario.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  describe "retorna valor de metodo authenticate" do
    before { @usuario.save }
    let(:usuario_encontrado) { Usuario.find_by_email(@usuario.email) }
    
    describe "con password valido" do
      it { should == usuario_encontrado.authenticate(@usuario.password) }
    end
    
    describe "con password invalido" do
      let(:usuario_para_password_invalido) { usuario_encontrado.authenticate("pass_invalido") }
      
      it { should_not == usuario_para_password_invalido }
      specify { usuario_para_password_invalido.should be_false }
    end
  end
  
  describe "recuerda token" do
    before { @usuario.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "Autorizando unidad" do
    let(:unidad_autorizada) { FactoryGirl.create(:unidad) }
    before do
      @usuario.save
      @usuario.autorizar_unidad!(unidad_autorizada)
    end

    it { should be_unidad_autorizada(unidad_autorizada) }
    its(:unidades_autorizadas) { should include(unidad_autorizada) }

    describe "y desautorizando unidad" do
      before { @usuario.desautorizar_unidad!(unidad_autorizada) }

      it { should_not be_unidad_autorizada(unidad_autorizada) }
      its(:unidades_autorizadas) { should_not include(unidad_autorizada)}
    end
  end
end
