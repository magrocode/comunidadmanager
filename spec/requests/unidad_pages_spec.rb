require 'spec_helper'

describe "UnidadPages" do

  subject { page }
  
  let(:comunidad) { FactoryGirl.create(:comunidad) }
  before { sign_in comunidad }
  
  describe "Creacion de unidad" do 
    before { visit new_comunidad_unidad_path(comunidad) }
   
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
        fill_in 'Identificador', with: "DEP101"
        fill_in 'Participacion', with: 0.25
      end
      
      it "debe crear una unidad" do
        expect { click_button "Crear unidad" }.should change(Unidad, :count).by(1)
      end
      
      describe "despues de guardar la unidad" do
        before { click_button "Crear unidad" }
        let(:unidad) { Unidad.find_by_identificador('DEP101') }
        
        it { should have_selector('title', text: unidad.identificador) }
      end
    end
  end
  
  describe "Viendo unidades de otras comunidades" do
    let(:comunidad1) { FactoryGirl.create(:comunidad) }
    let(:unidad1) { FactoryGirl.create(:unidad, comunidad: comunidad1) }    
    before { visit unidad_path(unidad1) }
    
    it { should_not have_selector('title', text: unidad1.identificador) }
  end
  

end
