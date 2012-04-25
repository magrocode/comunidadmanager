require 'spec_helper'

describe "UnidadPages" do

  subject { page }
  
  let(:comunidad) { FactoryGirl.create(:comunidad) }
  let(:usuario_admin) { FactoryGirl.create(:usuario_admin, comunidad: comunidad) }
  before { sign_in usuario_admin }
  
  describe "Creacion de unidad" do 
 
    before { visit new_comunidad_unidad_path(comunidad) }
   
    describe "con informacion invalida" do
      it "no debe crear una unidad" do
        expect { click_button "Enviar" }.should_not change(Unidad, :count)
      end
      
      describe "mensaje de error" do
        let(:error) { 'El formulario contiene' }
        before { click_button "Enviar" }
        it { should have_content(error) }
      end    
    end 
    
    describe "con informacion valida" do
      # pendiente de escribir
      before do
        fill_in 'Identificador', with: "DEP101"
        fill_in 'Participacion', with: 0.1225
        fill_in 'Superficie',    with: 54.65
      end
      
      it "debe crear una unidad" do
        expect { click_button "Enviar" }.should change(Unidad, :count).by(1)
      end
      
      describe "despues de guardar la unidad" do
        before { click_button "Enviar" }
        let(:unidad) { Unidad.find_by_identificador('DEP101') }
        
        it { should have_selector('title', text: unidad.identificador) }
      end
    end
  end

  describe "Viendo unidades" do
  
    describe "de otras comunidades" do
      let(:comunidadB) { FactoryGirl.create(:comunidad) }
      let(:unidadB) { FactoryGirl.create(:unidad, comunidad: comunidadB) }    
      before { visit comunidad_unidad_path(comunidadB, unidadB) }
      
      it { should_not have_selector('title', text: unidadB.identificador) }
    end
  end
end
