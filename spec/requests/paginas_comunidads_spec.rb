require 'spec_helper'

describe "Paginas de Comunidads" do

  subject { page }
  
  describe "pagina signup" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: "Sign up") }
    it { should have_selector('title', text: "Sign up") } 
  end
  
  describe "pagina del perfil" do
    let(:comunidad) { FactoryGirl.create(:comunidad) }
    before { visit comunidad_path(comunidad) }
    
    it { should have_selector('h1', text: comunidad.nombre_comunidad) }
    it { should have_selector('title', text: comunidad.nombre_comunidad) }
  end
  
  describe "Signup" do
    
    before { visit signup_path }
    
    describe "con informacion invalida" do
      it "no debe crear un comunidad" do
        expect { click_button "Crear mi cuenta" }.not_to change(Comunidad, :count)
      end
    end
    
    describe "con informacion valida" do
      before do
        fill_in "Nombre comunidad", with: "Comunidad de Ejemplo"
        fill_in "Email", with: "mario@foobar.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmacion", with: "foobar"
      end
      
      it "debe crear un comunidad" do
        expect do
          click_button "Crear mi cuenta"
        end.to change(Comunidad, :count).by(1)   
      end
    end
    
  end
end
