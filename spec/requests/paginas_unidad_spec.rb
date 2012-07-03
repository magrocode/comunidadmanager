require 'spec_helper'

describe "UnidadPages" do

  subject { page }
  
  let(:comunidad) { FactoryGirl.create(:comunidad) }
  let(:usuario_admin) { FactoryGirl.create(:usuario_admin) }
  before do
    comunidad.autorizar_usuario!(usuario_admin)
    sign_in usuario_admin 
  end
  
  describe "Creacion de unidad" do 
 
    before { visit new_comunidad_unidad_path(comunidad) }
   
    describe "con informacion invalida" do
      it "no debe crear una unidad" do
        expect { click_button "Guardar" }.should_not change(Unidad, :count)
      end
      
      describe "mensaje de error" do
        let(:error) { 'El formulario contiene' }
        before { click_button "Guardar" }
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
        expect { click_button "Guardar" }.should change(Unidad, :count).by(1)
      end
      
      describe "despues de guardar la unidad" do
        before { click_button "Guardar" }
        let(:unidad) { Unidad.find_by_identificador('DEP101') }
        
        it { should have_selector('title', text: 'Unidades') }
      end
    end
  end

  describe "Viendo perfil de unidad" do
  
    describe "de otra comunidad" do
      let(:comunidadB) { FactoryGirl.create(:comunidad) }
      let(:unidadB) { FactoryGirl.create(:unidad, comunidad: comunidadB) }    
      before { visit comunidad_unidad_path(comunidadB, unidadB) }
      
      it { should_not have_content(unidadB.identificador) }

      describe "y viendo las unidades vinculadas de una unidad" do
        before { visit vinculadas_unidad_path(unidadB) }

        it { should_not have_selector('h2', text: unidadB.identificador) }
        it { should have_content("Bochornoso! no estas autorizado para realizar acciones en la comunidad que deseas")}

      end

      describe "y viendo los usuarios autorizados de una unidad" do
        before { visit usuarios_autorizados_unidad_path(unidadB) }

        it { should_not have_selector('h2', text: unidadB.identificador) }
        it { should have_content("Bochornoso! no estas autorizado para realizar acciones en la comunidad que deseas")}
      end

    end

    describe "de su comunidad como usuario autorizado" do
      let(:usuario) { FactoryGirl.create(:usuario) }
      let(:unidad_autorizada) { FactoryGirl.create(:unidad, comunidad: comunidad) }
      before do
        comunidad.autorizar_usuario!(usuario)
        unidad_autorizada.autorizar_usuario!(usuario)
        sign_in usuario
        visit unidad_path(unidad_autorizada)
      end

      it { should have_selector('h1', text: unidad_autorizada.identificador) }

      describe "y viendo una unidad vinculada pero no autorizada" do
        let(:unidad_vinculada) { FactoryGirl.create(:unidad, comunidad: comunidad) }
        before do
          unidad_autorizada.vincular!(unidad_vinculada)
          visit unidad_path(unidad_vinculada)
        end

        #it { should have_selector('h1', text: unidad_vinculada.identificador) }
      end

      describe "y viendo una unidad vinculada y si autorizada" do
        let(:unidad_vinculada) { FactoryGirl.create(:unidad, comunidad: comunidad) }
        before do
          unidad_autorizada.vincular!(unidad_vinculada)
          unidad_vinculada.autorizar_usuario!(usuario)
          visit unidad_path(unidad_vinculada)
        end

        it { should have_selector('h1', text: unidad_vinculada.identificador) }
      end

    end

    describe "de su comunidad como usuario no autorizado" do
      let(:usuario) { FactoryGirl.create(:usuario) }
      let(:unidad_no_autorizada) { FactoryGirl.create(:unidad, comunidad: comunidad) }
      before do
        comunidad.autorizar_usuario!(usuario)
        sign_in usuario
        visit unidad_path(unidad_no_autorizada)
        #save_and_open_page
      end

      it { should have_selector('h1', text: unidad_no_autorizada.identificador) }      
      
      describe "y viendo las unidades vinculadas de otra unidad" do
        before do
          visit vinculadas_unidad_path(unidad_no_autorizada)
        end

        it { should have_selector('h2', text: unidad_no_autorizada.identificador) }
      end

      describe "y viendo los usuarios autorizados de otra unidad" do
        before do
          visit usuarios_autorizados_unidad_path(unidad_no_autorizada)
        end

        it { should have_selector('h2', text: unidad_no_autorizada.identificador) }
      end
    end
  end
end
