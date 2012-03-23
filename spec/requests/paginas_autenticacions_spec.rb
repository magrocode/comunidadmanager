require 'spec_helper'

describe "Autenticacion" do
  
  subject { page }
  
  
  describe "pagina signin" do
    
    # antes que todo visita el signin
    before { visit signin_path }
    
    # cada 'it' es una prueba
    it { should have_selector('h1', text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
    
  end
  
  describe "signin" do
     before { visit signin_path }
     
     describe "con informacion invalida" do
       before { click_button "Sign in" }
       
       it { should have_selector('title', text: 'Sign in') }
       it { should have_selector('div.alert.alert-error', text: 'invalid') }
       
       describe "despues de visitar otra pagina" do
         before { click_link "Home" }
         it { should_not have_selector('div.alert.alert-error') }
       end
     end
     
     describe "con informacion valida" do
       let(:comunidad) { FactoryGirl.create(:comunidad) }
       before do
         fill_in "Email", with: comunidad.email
         fill_in "Password", with: comunidad.password
         click_button "Sign in"
       end
       
       it { should have_selector('title', text: comunidad.nombre_comunidad) }
       it { should have_link('Perfil', href: comunidad_path(comunidad)) }
       it { should have_link('Sign out', href: signout_path) }
       it { should_not have_link('Sign in', href: signin_path) }
       
       describe "seguido por signout" do
         before { click_link "Sign out" }
         it { should have_link('Sign in') }
       end
     end
  end
end
