require 'spec_helper'

describe "Paginas de Comunidad" do

  subject { page }
  
  describe "pagina signup" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: "Sign up") }
    it { should have_selector('title', text: "Sign up") } 
    
  end
  
  describe "pagina del perfil" do
    let(:comunidad) { FactoryGirl.create(:comunidad) }
    before { visit comunidad_path(comunidad) }
    
    it { should have_selector('h1', text: comunidad.nombre) }
    it { should have_selector('title', text: comunidad.nombre) }
  end
  
  describe "Signup" do
    
    before { visit signup_path }
    
    describe "con informacion invalida" do
      it "no debe crear una comunidad" do
        expect { click_button "Crear mi cuenta" }.not_to change(Comunidad, :count)
      end
    end
    
    describe "con informacion valida" do
      before do
        fill_in "Nombre", with: "Comunidad de Ejemplo"
        fill_in "Email", with: "mario@foobar.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmacion", with: "foobar"
      end
      
      it "debe crear un comunidad" do
        expect do
          click_button "Crear mi cuenta"
        end.to change(Comunidad, :count).by(1)
      end
      
      describe "despues de guardar comunidad" do
        before { click_button "Crear mi cuenta" }
        let(:comunidad) { Comunidad.find_by_email('mario@foobar.com') }

        it { should have_selector('title', text: comunidad.nombre) }
        #it { should have_selector('div.flash.success', text: 'Bienvenido') }
        it { should have_selector('div.alert.alert-success', text: 'Bienvenido') }
        it { should have_link('Sign out') }
      end
    end
    
  end
end