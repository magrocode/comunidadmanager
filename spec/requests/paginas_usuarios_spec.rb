require 'spec_helper'

describe "Paginas de Usuarios" do

  subject { page }
  
  describe "pagina signup" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: "Sign up") }
    it { should have_selector('title', text: "Sign up") } 
  end
  
  describe "pagina del perfil" do
    let(:usuario) { FactoryGirl.create(:usuario) }
    before { visit usuario_path(usuario) }
    
    it { should have_selector('h1', text: usuario.nombre_comunidad) }
    it { should have_selector('title', text: usuario.nombre_comunidad) }
  end
  
  describe "Signup" do
    
    before { visit signup_path }
    
    describe "con informacion invalida" do
      it "no debe crear un usuario" do
        expect { click_button "Crear mi cuenta" }.not_to change(Usuario, :count)
      end
    end
    
    describe "con informacion valida" do
      before do
        fill_in "Nombre comunidad", with: "Comunidad de Ejemplo"
        fill_in "Email", with: "mario@foobar.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmacion", with: "foobar"
      end
      
      it "debe crear un usuario" do
        expect do
          click_button "Crear mi cuenta"
        end.to change(Usuario, :count).by(1)   
      end
    end
    
  end
end
