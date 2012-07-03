require 'spec_helper'

describe "Paginas" do
  
  subject { page }
  
  shared_examples_for "all paginas" do
    #it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: (page_title)) }
  end
  
  describe "Pagina 'Home'" do
    before { visit root_path }
    let(:heading) { 'Cloudapolis' }
    let(:page_title) { 'Home' }
    
    it_should_behave_like "all paginas"
    
    it { should have_link('Registrar Comunidad Ahora!', href: signup_path ) }
  end
  
  describe "Pagina 'Panel de Control'" do
    let(:comunidad) { FactoryGirl.create(:comunidad) }
    let(:usuario_admin) { FactoryGirl.create(:usuario_admin) }
    
    let(:heading) { 'Cloudapolis' }
    let(:page_title) { 'Panel de control' }
    
    before do
      comunidad.autorizar_usuario!(usuario_admin)
      sign_in usuario_admin
      visit wellcome_path
    end
    
    it_should_behave_like "all paginas"
  end   

  describe "Paginas de usuario autenticado" do
    let(:comunidad) { FactoryGirl.create(:comunidad) }
    let(:usuario) { FactoryGirl.create(:usuario) }

    before do  
      comunidad.autorizar_usuario!(usuario)
      sign_in usuario 
    end

    describe "viendo el menu superior" do

      it { should have_link('Mi Perfil', href: usuario_path(usuario) ) }
    end
  end

  describe "Pagina de comunidad inactiva" do
    let(:comunidad) { FactoryGirl.create(:comunidad) }
    let(:usuario) { FactoryGirl.create(:usuario) }

    before do 
      comunidad.autorizar_usuario!(usuario)
      comunidad.desactivar!
      sign_in usuario 
    end

    describe "Viendo pagina de bloqueo" do

      it { should have_selector('p', text: "Esta comunidad se encuentra actualmente desactivada") }
    end
  end
end
