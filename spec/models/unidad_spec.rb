# == Schema Information
#
# Table name: unidads
#
#  id            :integer         not null, primary key
#  comunidad_id  :integer
#  tipounidad_id :integer
#  identificador :string(255)
#  participacion :float
#  superficie    :float
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe Unidad do
  
  let(:comunidad) { FactoryGirl.create(:comunidad) }
  let(:tipounidad) { FactoryGirl.create(:tipounidad)}
  before { @unidad = comunidad.unidads.build(identificador: "DEP101", 
                                              participacion: 1.2556, 
                                              superficie: 54.76,
                                              tipounidad: tipounidad) }
  
  subject { @unidad }
  
  it { should respond_to(:identificador) }
  it { should respond_to(:participacion) }
  it { should respond_to(:superficie) }
  it { should respond_to(:comunidad_id) }
  it { should respond_to(:comunidad) }
  it { should respond_to(:tipounidad_id) }
  it { should respond_to(:tipounidad) }
  it { should respond_to(:relacion_unidads) }
  it { should respond_to(:vinculadas) }
  it { should respond_to(:vinculada?) }
  it { should respond_to(:vincular!) }
  it { should respond_to(:desvincular!) }
  it { should respond_to(:usuarios_autorizados) }
  it { should respond_to(:usuario_autorizado?) }
  it { should respond_to(:autorizar_usuario!) }
  it { should respond_to(:desautorizar_usuario!) }
  its(:comunidad) { should == comunidad }
  its(:tipounidad) { should == tipounidad }
  
  it { should be_valid }
    
  describe "cuando comunidad_id no esta presente" do
    before { @unidad.comunidad_id = nil }
    it { should_not be_valid }
  end
  
  describe "cuando identificador es vacio" do
    before { @unidad.identificador = "" }
    it { should_not be_valid }
  end
  
  describe "cuando identificador es muy largo" do
    before { @unidad.identificador = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "cuando participacion es vacio" do
    before { @unidad.participacion = " " }
    it { should_not be_valid }
  end
  
  describe "cuando participacion es < 0" do
    before { @unidad.participacion = -1 }
    it { should_not be_valid }
  end
  
  describe "cuando superficie es vacio" do
    before { @unidad.superficie = " " }
    it { should_not be_valid }
  end

  describe "vinculando" do
    let(:otra_unidad) { FactoryGirl.create(:unidad, comunidad: comunidad) }
    before do
      @unidad.save
      @unidad.vincular!(otra_unidad)
    end

    it { should be_vinculada(otra_unidad) }
    its(:vinculadas) { should include(otra_unidad) }

    describe "y desvinculando" do
      before { @unidad.desvincular!(otra_unidad) }

      it { should_not be_vinculada(otra_unidad) }
      its(:vinculadas) { should_not include(otra_unidad) }
    end
  end

  describe "Autorizando usuario" do
    let(:usuario_autorizado) { FactoryGirl.create(:usuario) }
    before do
      @unidad.save 
      @unidad.autorizar_usuario!(usuario_autorizado)
    end

    it { should be_usuario_autorizado(usuario_autorizado) }
    its(:usuarios_autorizados) { should include(usuario_autorizado) }

    describe "y Desautorizando usuario" do
      before { @unidad.desautorizar_usuario!(usuario_autorizado) }

      it { should_not be_usuario_autorizado(usuario_autorizado) }
      its(:usuarios_autorizados) { should_not include(usuario_autorizado) }
    end
  end
end
