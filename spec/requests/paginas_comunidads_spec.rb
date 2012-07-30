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
      let(:comunidad) { FactoryGirl.build(:comunidad) }
      let(:usuario_admin) { FactoryGirl.build(:usuario_admin) }

      before do
        fill_in "comunidad_nombre", with: comunidad.nombre
        fill_in "usuario_nombre", with: usuario_admin.nombre
        fill_in "usuario_email", with: usuario_admin.email
        fill_in "usuario_password", with: usuario_admin.password
        fill_in "usuario_password_confirmation", with: usuario_admin.password_confirmation
      end
      
      it "debe crear un comunidad" do
        expect do
          click_button "Crear Comunidad"
        end.to change(Comunidad, :count).by(1)
      end
      
      describe "despues de guardar comunidad" do
        before { click_button "Crear Comunidad" }
        #let(:usuario) { Usuario.find_by_email('mario@foobar.com') }
        #let(:comunidad) { RelacionComunidadUsuario.find_by_usuario_id(usuario.id).comunidad.first }

        it { should have_selector('title', text: comunidad.nombre) }
        it { should have_selector('div.alert.alert-success', text: 'Bienvenido') }
        it { should have_link('Sign out') }
      end
    end
    
  end


  describe "Viendo perfil de comunidad" do
    
    let(:comunidad) { FactoryGirl.create(:comunidad) }
    let(:usuario) { FactoryGirl.create(:usuario) }
    
    before do
      comunidad.autorizar_usuario!(usuario)
      sign_in usuario
      visit comunidad_path(comunidad) 
    end 
      
    it { should have_selector('h1', text: comunidad.nombre) }
    it { should have_selector('title', text: comunidad.nombre) }
  end
  
  describe "Viendo perfil de otras comunidades" do

    describe "como usuario no-admin no-system-admin" do
      let(:comunidadA) { FactoryGirl.create(:comunidad) }
      let(:usuario) { FactoryGirl.create(:usuario) }

      let(:comunidadB) { FactoryGirl.create(:comunidad) }

      before do
        comunidadA.autorizar_usuario!(usuario)
        sign_in usuario
        visit comunidad_path(comunidadB) 
      end 
      
      it { should_not have_selector('h1', text: comunidadB.nombre) }
      it { should_not have_selector('title', text: comunidadB.nombre) }  
    end

    describe "como usuario system-admin" do
      let(:comunidadA) { FactoryGirl.create(:comunidad) }
      let(:usuario) { FactoryGirl.create(:usuario) }
      let(:system_admin) { FactoryGirl.create(:system_admin) }

      let(:comunidadB) { FactoryGirl.create(:comunidad) }
      

      before do
        comunidadA.autorizar_usuario!(usuario)
        comunidadA.autorizar_usuario!(system_admin)
        sign_in system_admin
        visit comunidad_path(comunidadB)
      end

      it { should have_selector('h1', text: comunidadB.nombre) }
    end
  end
  
  describe "Editando perfil de comunidad" do

    let(:comunidad) { FactoryGirl.create(:comunidad) }
    
    describe "como usuario admin" do
      let(:usuario_admin) { FactoryGirl.create(:usuario_admin) }
      
      before do
        comunidad.autorizar_usuario!(usuario_admin)
        comunidad.autorizar_administrador!(usuario_admin)
        sign_in usuario_admin
        visit edit_comunidad_path(comunidad)
      end
      
      it { should have_selector('title', text: "Editando comunidad") }
      it { should have_selector('h2', text: "Editando comunidad") }
    end

    describe "como usuario system_admin" do
      let(:system_admin) { FactoryGirl.create(:system_admin) }
      
      before do
        comunidad.autorizar_usuario!(system_admin)
        sign_in system_admin
        visit edit_comunidad_path(comunidad)
      end
      
      it { should have_selector('title', text: "Editando comunidad") }
      it { should have_selector('h2', text: "Editando comunidad") }
    end

    describe "como usuario no administrador" do
      let(:usuario) { FactoryGirl.create(:usuario) }

      before do
        comunidad.autorizar_usuario!(usuario)
        sign_in usuario
        visit edit_comunidad_path(comunidad)
      end
 
      it { should_not have_selector('title', text: "Editando comunidad" )}  

    end 
  end
end