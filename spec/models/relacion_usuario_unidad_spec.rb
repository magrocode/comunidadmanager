# == Schema Information
#
# Table name: relacion_usuario_unidads
#
#  id         :integer         not null, primary key
#  usuario_id :integer
#  unidad_id  :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

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
		it "Debe permitir acceso a usuario_id y unidad_id" do
			expect do
				RelacionUsuarioUnidad.new(usuario_id: usuario.id)
			end.should_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "Metodos de usuario" do
		before { relacion_usuario_unidad.save }

		it { should respond_to(:usuario) }
		it { should respond_to(:unidad) }
		its(:usuario) { should == usuario }
		its(:unidad) { should == unidad }
	end

	describe "Cuando usuario_id no esta presente" do
		before { relacion_usuario_unidad.usuario_id = nil }
		it { should_not be_valid }
	end	

	describe "Cuando unidad_id no esta presente" do
		before { relacion_usuario_unidad.unidad_id = nil }
		it { should_not be_valid }
	end

	describe "Cuando usuario es autorizado mas de una vez a la misma unidad" do
		before { relacion_usuario_unidad.save }

		let(:relacion_duplicada) do
			usuario.relacion_usuario_unidads.build(unidad_id: unidad.id)
		end

		it { relacion_duplicada.should_not be_valid }
	end
end
