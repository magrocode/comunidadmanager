require 'spec_helper'

describe "Paginas Tipo unidades" do

	subject { page }

	let(:comunidad) { FactoryGirl.create(:comunidad) }
	let(:usuario_admin) { FactoryGirl.create(:usuario_admin, comunidad: comunidad) }
	before { sign_in usuario_admin }

	describe "Creacion de Tipo de Unidad" do
		
		before { visit new_comunidad_tipounidad_path(comunidad) }

		describe "Con informacion invalida" do
			it "no debe crear un tipounidad" do
				expect { click_button "Enviar" }.should_not change(Tipounidad, :count)
			end

			describe "mensaje de error" do
				let(:error) { 'El formulario contiene' }
				before { click_button "Enviar" }
				it { should have_content(error) }
			end
		end

		describe "Con informacion valida" do

			before do
				fill_in 'tipounidad_nombre', with: "Departamento"
			end

			it "debe crear un tipo de unidad" do
				expect { click_button "Enviar" }.should change(Tipounidad, :count).by(1)
			end

			describe "despues de guardar el tipounidad" do
				before { click_button "Enviar" }
				let(:tipounidad) { Tipounidad.find_by_nombre('Departamento') }

				it { should have_selector('title', text: tipounidad.nombre )}
			end
		end
	end

	describe "Viendo tipos de unidades" do

		describe "de otras comunidades" do
			let(:otra_comunidad) { FactoryGirl.create(:comunidad) }
			let(:otro_tipounidad) { FactoryGirl.create(:tipounidad, comunidad: otra_comunidad) }
			before { visit new_comunidad_tipounidad_path(otra_comunidad, otro_tipounidad) }

			it { should_not have_selector('title', text: otro_tipounidad.nombre) }
		end
	end

end
