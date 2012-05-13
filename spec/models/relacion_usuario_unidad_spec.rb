require 'spec_helper'

describe RelacionUsuarioUnidad do

	let(:usuario) { FactoryGirl.create(:usuario) }
	let(:unidad) { FactoryGirl.create(:unidad) }
	let(:relacion_usuario_unidad) do
		usuario.relacion_usuario_unidads.build(unidad_id: unidad.id)
	end

	subject { relacion_usuario_unidad }

	it { should be_valid }

	describe "Atributos accesibles" do
		it "no debe permitir acceso a usuario_id" do
			expect do
				RelacionUsuarioUnidad.new(usuario_id: usuario.id)
			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end
end
