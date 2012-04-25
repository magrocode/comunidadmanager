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
  it { should respond_to(:tipounidad)}
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
  
end
