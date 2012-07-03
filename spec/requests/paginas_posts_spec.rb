require 'spec_helper'

describe "PaginasPosts" do

	subject { page }

	let(:comunidad) { FactoryGirl.create(:comunidad) }
	let(:usuario) { FactoryGirl.create(:usuario) }
	let(:system_admin) { FactoryGirl.create(:system_admin) }

	let(:comunidad_b) { FactoryGirl.create(:comunidad) }

	before do
		comunidad.autorizar_usuario!(usuario)
		comunidad.autorizar_usuario!(system_admin)
		sign_in usuario 
	end

	describe "Creacion de post" do
		before { visit comunidad_path(comunidad) }

		describe "Con informacion invalida" do
		# es invalida porque no llenamos ningun dato
			it "no debe crear un post" do
				expect { click_button "Agregar esta nota" }.should_not change(Post, :count)
			end
		end

		describe "para otra comunidad" do

			describe "enviado por usuario incorrecto" do
				before do
					visit comunidad_path(comunidad_b)
					fill_in 'post_contenido', with: 'Nota de un usuario incorrecto'
				end

				it "no debe crear un post" do
					expect { click_button "Agregar esta nota" }.should_not change(comunidad_b.posts, :count)
				end
			end

			describe "enviado por system_admin" do
				before do
					sign_in system_admin
					visit comunidad_path(comunidad_b)
					fill_in 'post_contenido', with: 'Nota de un usuario system_admin'
				end

				it "debe crear un post" do
					expect { click_button "Agregar esta nota" }.should change(comunidad_b.posts, :count)
				end
			end
		end
	end
end
