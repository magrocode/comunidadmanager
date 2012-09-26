require 'spec_helper'

describe "Paginas de Accounts" do 

	subject { page }

	let(:comunidad) { FactoryGirl.create(:comunidad) }
	let(:usuario_admin) { FactoryGirl.create(:usuario)}
	
	before do
		comunidad.autorizar_usuario!(usuario_admin)
		comunidad.autorizar_administrador!(usuario_admin)
		sign_in usuario_admin
	end

	describe "Listando todas las cuentas" do

		before { visit comunidad_accounts_path(comunidad) }

		describe "viendo el titulo" do
			it { should have_selector('h2', text: "Cuentas corrientes en #{comunidad.nombre}") }
		end
	end
end