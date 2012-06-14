require 'spec_helper'

describe "PaginasPosts" do

	subject { page }

	let(:comunidad) { FactoryGirl.create(:comunidad) }
	let(:usuario) { FactoryGirl.create(:usuario, comunidad: comunidad) }
	before { sign_in usuario }

	describe "Creacion de post" do
		before { visit new_comunidad_post_path(usuario) }

		describe "Con informacion invalida" do
			# es invalida porque no llenamos ningun dato
			it "no debe crear un post" do
				expect { click_button "Guardar" }.should_not change(Post, :count)
			end
		end
	end
end
