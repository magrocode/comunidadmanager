# == Schema Information
#
# Table name: comunidads
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  direccion  :string(255)
#  ciudad     :string(255)
#  region     :string(255)
#  pais       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Comunidad do
  
  before { @comunidad = Comunidad.new(nombre: "Comunidad de Ejemplo", 
                                      direccion: "Huerfanos 1055", 
                                      ciudad: "Santiago", 
                                      region: "Region metropolitana",
                                      pais: "Chile") }
                                  
  subject { @comunidad }
  
  it { should respond_to(:nombre) }
  it { should respond_to(:direccion) }  
  it { should respond_to(:ciudad) }
  it { should respond_to(:region) }
  it { should respond_to(:pais) }
#  it { should respond_to(:authenticate) }
  
  it { should be_valid }
  
  describe "Cuando Comunidad invalido" do
    before { @comunidad.nombre = " " }
    it { should_not be_valid }
  end
  
  describe "Cuando nombre es demasiado largo" do
    before { @comunidad.nombre = "a" * 51 }
    it { should_not be_valid }    
  end
  
###
##  
#  describe "unidades de la comunidad" do
#    
#    before { @comunidad.save }
#    let!(:unidad) do
#      FactoryGirl.create(:unidad, comunidad: @comunidad)
#    end
#    
#    it "debe tener las unidades correctas" do
#      @comunidad.unidads.should == [unidad]
#    end
#    
#    it "debe destruir las unidades de la comunidad" do
#      unidads = @comunidad.unidads
#      @comunidad.destroy
#      unidads.each do |unidad|
#        Unidad.find_by_id(unidad.id).should be_nil
#      end
#    end
#  end

 
end
