require 'spec_helper'

describe "Paginas de Usuarios" do

  subject { page }
  
  let(:comunidad) { FactoryGirl.create(:comunidad) }
  let(:usuario_admin) { FactoryGirl.create(:usuario_admin) }
  before do
    comunidad.autorizar_usuario!(usuario_admin)
    sign_in usuario_admin 
  end
  
  describe "Creacion de usuario" do
    
    before { visit new_comunidad_usuario_path(comunidad) }
     
    describe "con informacion invalida" do
      it "no debe crear un usuario" do
        expect { click_button "Guardar" }.should_not change(Usuario, :count)
      end
      
      describe "mensaje de error" do
        let(:error) { 'El formulario contiene' }
        before { click_button "Guardar" }
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
        select('English', :from => 'Lenguaje')       
      end
      
      it "debe crear un usuario" do
        expect { click_button "Guardar" }.should change(Usuario, :count).by(1)
      end
      
      describe "despues de guardar usuario" do        
        before { click_button "Guardar" }
      
        it { should have_selector('title', text: 'Usuarios')}
      end
    end
    
    describe "por usuario no admin" do
      let(:usuario) { FactoryGirl.create(:usuario) }
      before do 
         comunidad.autorizar_usuario!(usuario)
         sign_in usuario
         visit new_comunidad_usuario_path(comunidad)
      end
      it { should_not have_selector('title', text: 'Nuevo usuario')}
    end
    
  end
  
  describe "Edicion de usuario" do
    
    #before { visit edit_usuario_path(usuario) }
    
    describe "por usuario no administrador" do
      let(:usuario) { FactoryGirl.create(:usuario) }
      before do
        comunidad.autorizar_usuario!(usuario)
        sign_in usuario
      end
      
      describe "editando su propio perfil" do
        before { visit edit_usuario_path(usuario) } 
        
        it { should have_selector('title', text: 'Editando usuario') }
        
        describe "Cambiando el password" do
          before do
            fill_in 'Password', with: "foobar2"
            fill_in 'Confirmacion', with: "foobar2"
            click_button "Guardar"        
          end
          
          it { should have_selector('h1', text: usuario.nombre )}
          
        end
      end
      
      describe "editando perfil de otro usuario" do
        let(:otro_usuario) { FactoryGirl.create(:usuario) }
        before do
          comunidad.autorizar_usuario!(otro_usuario)
          visit edit_usuario_path(otro_usuario)
        end
        
        it { should_not have_selector('title', text: 'Editando usuario') }  
        it { should have_content("Ups!! parece que no tienes autorizacion sobre el usuario que deseas")}

        describe "y viendo sus unidades autorizadas" do
          before { visit unidades_autorizadas_usuario_path(otro_usuario) }

          it { should have_selector('h2', text: 'Viviendas o unidades autorizadas a') }
        end
      end 
    end
  end
  
end
