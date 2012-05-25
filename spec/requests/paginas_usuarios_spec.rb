require 'spec_helper'

describe "Paginas de Usuarios" do

  subject { page }
  
  let(:comunidad) { FactoryGirl.create(:comunidad) }
  let(:usuario_admin) { FactoryGirl.create(:usuario_admin, comunidad: comunidad) }
  before { sign_in usuario_admin }
  
  describe "Creacion de usuario" do
    
    before { visit new_comunidad_usuario_path(comunidad) }
     
    describe "con informacion invalida" do
      it "no debe crear un usuario" do
        expect { click_button "Enviar" }.should_not change(Usuario, :count)
      end
      
      describe "mensaje de error" do
        let(:error) { 'El formulario contiene' }
        before { click_button "Enviar" }
        it { should have_content(error) }
      end
    end
    
    describe "con informacion valida" do
      
      before do
        fill_in 'Email', with: "miguel@foobar.com"
        fill_in 'Nombre', with: "Miguel Hernandez"
        check   'usuario_administrador'
        fill_in 'Password', with: "foobar"
        fill_in 'Confirmacion', with: "foobar"        
      end
      
      it "debe crear un usuario" do
        expect { click_button "Enviar" }.should change(Usuario, :count).by(1)
      end
      
      describe "despues de guardar usuario" do        
        before { click_button "Enviar" }
        let(:nuevo_usuario) { Usuario.find_by_email("miguel@foobar.com") }
        
        it { should have_selector('title', text: nuevo_usuario.email) }
      end
    end
    
    describe "por usuario no admin" do
      let(:usuario) { FactoryGirl.create(:usuario, comunidad: comunidad) }
      before do 
         sign_in usuario
         visit new_comunidad_usuario_path(comunidad)
      end
      it { should_not have_selector('title', text: 'Nuevo usuario')}
    end
    
  end
  
  describe "Edicion de usuario" do
    
    #before { visit edit_usuario_path(usuario) }
    
    describe "por usuario no administrador" do
      let(:usuario) { FactoryGirl.create(:usuario, comunidad: comunidad) }
      before {  sign_in usuario }
      
      describe "editando su propio perfil" do
        before { visit edit_usuario_path(usuario) } 
        
        it { should have_selector('title', text: 'Editando usuario') }
        
        describe "Cambiando el password" do
          before do
            fill_in 'Password', with: "foobar2"
            fill_in 'Confirmacion', with: "foobar2"
            click_button "Enviar"        
          end
          
          it { should have_selector('title', text: usuario.email )}
          
        end
      end
      
      describe "editando perfil de otro usuario" do
        let(:otro_usuario) { FactoryGirl.create(:usuario, comunidad: comunidad) }
        before { visit edit_usuario_path(otro_usuario) }
        
        it { should_not have_selector('title', text: 'Editando usuario') }  
      end 
    end
    
  end
end
