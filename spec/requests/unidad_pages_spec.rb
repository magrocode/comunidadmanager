require 'spec_helper'

describe "UnidadPages" do

  subject { page }
  
  let(:comunidad) { FactoryGirl.create(:comunidad) }
  before { sign_in comunidad }
  
  describe "Creacion de unidad" do 
    before { visit new_unidad_path }
   
    describe "con informacion invalida" do
      it "no debe crear una unidad" do
        expect { click_button "Crear unidad" }.should_not change(Unidad, :count)
      end
      
      describe "mensaje de error" do
        let(:error) { 'El formulario contiene' }
        before { click_button "Crear unidad" }
        it { should have_content(error) }
      end    
    end 
    
    describe "con informacion valida" do
      
      # pendiente de escribir
      before do
        
      end
    end
  end
end
