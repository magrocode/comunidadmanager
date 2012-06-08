# == Schema Information
#
# Table name: comunidads
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  street     :string(255)
#  city       :string(255)
#  country    :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  email      :string(255)
#  twitter    :string(255)
#  telefono   :string(255)
#  activa     :boolean
#

require 'spec_helper'

describe Comunidad do
  
  before { @comunidad = Comunidad.new(nombre: "Comunidad de Ejemplo", 
                                      street: "Huerfanos 1055", 
                                      city: "Santiago", 
                                      country: "Chile") }
                                  
  subject { @comunidad }
  
  it { should respond_to(:nombre) }
  it { should respond_to(:street) }  
  it { should respond_to(:city) }
  it { should respond_to(:country) }
  it { should respond_to(:email) }
  it { should respond_to(:twitter) }
  it { should respond_to(:telefono) }
  
  it { should be_valid }
  
  describe "Cuando Comunidad invalido" do
    before { @comunidad.nombre = " " }
    it { should_not be_valid }
  end
  
  describe "Cuando nombre es demasiado largo" do
    before { @comunidad.nombre = "a" * 51 }
    it { should_not be_valid }    
  end
  
  describe "Cuando city es demasiado largo" do
    before { @comunidad.city = "a" * 256 }
    it { should_not be_valid }
  end
  
  describe "Cuando country es demasiado largo" do
    before { @comunidad.country = "a" * 256 }
    it { should_not be_valid }
  end
  
  describe "Cuando street es demasiado largo" do
    before { @comunidad.street = "a" * 256 }
    it { should_not be_valid }
  end

  describe "Cuando email es demasiado largo" do
    before { @comunidad.email = "a" * 256 }
    it { should_not be_valid }
  end

  describe "Cuando twitter es demasiado largo" do
    before { @comunidad.twitter = "a" * 256 }
    it { should_not be_valid }
  end

  describe "Cuando telefono es demasiado largo" do
    before { @comunidad.telefono = "a" * 256 }
    it { should_not be_valid }
  end

  
  describe "unidades de la comunidad" do
    
    before { @comunidad.save }
    let!(:unidad) do
      FactoryGirl.create(:unidad, comunidad: @comunidad)
    end
    
    it "debe tener las unidades correctas" do
      @comunidad.unidads.should == [unidad]
    end
    
    it "debe destruir las unidades de la comunidad" do
      unidads = @comunidad.unidads
      @comunidad.destroy
      unidads.each do |unidad|
        Unidad.find_by_id(unidad.id).should be_nil
      end
    end
  end

  describe "Desactivando comunidad" do
    before do 
      @comunidad.save
      @comunidad.desactivar!
    end

    it { should_not be_activa }

    describe "y activando comunidad" do
      before { @comunidad.activar! }

      it { should be_activa }
    end
  end 
end
