require 'spec_helper'

describe "Paginas" do
  
  subject { page }
  
  shared_examples_for "all paginas" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: (page_title)) }
  end
  
  describe "Pagina 'Home'" do
    before { visit root_path }
    let(:heading) { 'bloombee' }
    let(:page_title) { 'Home' }
    
    it_should_behave_like "all paginas"
    
    it { should have_link('Crear Comunidad Ahora!', href: signup_path ) }
  end   
  
end
