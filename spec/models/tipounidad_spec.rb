# == Schema Information
#
# Table name: tipounidads
#
#  id           :integer         not null, primary key
#  nombre       :string(255)
#  comunidad_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'spec_helper'

describe Tipounidad do
  
  let(:comunidad) { FactoryGirl.create(:comunidad) }
  before { @tipounidad = comunidad.tipounidads.build(nombre: "Departamento") }
  
  subject { @tipounidad }
  
  it { should respond_to(:nombre) }
  it { should respond_to(:comunidad_id) }
  it { should respond_to(:comunidad) }
  its(:comunidad) { should == comunidad }
  
  it { should be_valid }
  
  describe "cuando comunidad_id no esta presente" do
    before { @tipounidad.comunidad_id = nil }
    it { should_not be_valid } 
  end
  
  describe "cuando nombre es vacio" do
    before { @tipounidad.nombre = "" }
    it { should_not be_valid }
  end
  
  describe "cuando nombre es muy largo" do
    before { @tipounidad.nombre = "a" * 51 }
    it { should_not be_valid }
  end
end
