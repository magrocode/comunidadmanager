require 'spec_helper'

describe "Paginas de Comunidad" do

  subject { page }
   
  describe "pagina signup" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: "Sign up") }
    it { should have_selector('title', text: "Sign up") } 
    
  end
  
  describe "Accion Signup" do
    
    before { visit signup_path }
    
    describe "con informacion invalida" do
      it "no debe crear una comunidad" do
        expect { click_button "Crear Comunidad" }.not_to change(Comunidad, :count)
      end
    end

   
    describe "con informacion valida" do
      before do
        fill_in "comunidad_nombre", with: "Comunidad de Ejemplo"
        fill_in "usuario_nombre", with: "Mario Espinoza"
        fill_in "usuario_email", with: "mario@foobar.com"
        fill_in "usuario_password", with: "foobar"
        fill_in "usuario_password_confirmation", with: "foobar"
      end
      
      it "debe crear un comunidad" do
        expect do
          click_button "Crear Comunidad"
        end.to change(Comunidad, :count).by(1)
      end
      
      describe "despues de guardar comunidad" do
        before { click_button "Crear Comunidad" }
        let(:comunidad) { Usuario.find_by_email('mario@foobar.com').comunidad }

        it { should have_selector('title', text: comunidad.nombre) }
        it { should have_selector('div.alert.alert-success', text: 'Bienvenido') }
        it { should have_link('Sign out') }
      end
    end
    
  end


  describe "Viendo perfil de comunidad" do
    
    let(:comunidad) { FactoryGirl.create(:comunidad) }
    let(:usuario) { FactoryGirl.create(:usuario, comunidad: comunidad)}
    
    before do
      sign_in usuario
      visit comunidad_path(comunidad) 
    end 
      
    it { should have_selector('h1', text: comunidad.nombre) }
    it { should have_selector('title', text: comunidad.nombre) }
  end
  
  describe "Viendo perfil de otras comunidades" do
    let(:comunidadA) { FactoryGirl.create(:comunidad) }
    let(:usuario) { FactoryGirl.create(:usuario, comunidad: comunidadA)}
    let(:comunidadB) { FactoryGirl.create(:comunidad) }
    before do
      sign_in usuario
      visit comunidad_path(comunidadB) 
    end 
    
    it { should_not have_selector('h1', text: comunidadB.nombre) }
    it { should_not have_selector('title', text: comunidadB.nombre) }
  end
  
  describe "Editando perfil de comunidad" do
    
    let(:comunidad) { FactoryGirl.create(:comunidad) }
    let(:usuario) { FactoryGirl.create(:usuario_admin, comunidad: comunidad) }
    
    before do
      sign_in usuario
      visit edit_comunidad_path(comunidad)
    end
    
    it { should have_selector('title', text: "Editando comunidad") }
    it { should have_selector('h2', text: "Editando comunidad") }
    
    
    describe "por usuario no administrador" do
      
      let(:usuario) { FactoryGirl.create(:usuario, comunidad: comunidad) }
      
      it { should_not have_selector('title', text: "Editando comunidad" )}  
    end 
  end

  
end