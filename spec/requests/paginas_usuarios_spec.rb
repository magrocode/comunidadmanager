require 'spec_helper'

describe "PaginasUsuarios" do

  subject { page }
  
  describe "pagina de 'sign up'" do
    before { visit signup_path }
    
    it { should have_selector('title', text: "Signup" ) } 
    
  end
  
end
