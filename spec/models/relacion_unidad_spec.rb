# == Schema Information
#
# Table name: relacionunidads
#
#  id           :integer         not null, primary key
#  principal_id :integer
#  vinculada_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'spec_helper'

describe RelacionUnidad do
  
	let(:comunidad) { FactoryGirl.create(:comunidad) }
	let(:unidad_principal) { FactoryGirl.create(:unidad, comunidad: comunidad) }  
	let(:unidad_relacionada) { FactoryGirl.create(:unidad, comunidad: comunidad) } 
	let(:relacion_unidad) do
		unidad_principal.relacion_unidads.build(vinculada_id: unidad_relacionada.id)
	end 

	subject { relacion_unidad }

	it { should be_valid }

	describe "Atributos accesibles" do
		it "no debe permitir acceso a principal_id" do
			expect do
				RelacionUnidad.new(principal_id: unidad_principal.id)
			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "metodos de unidad principal" do
		before { relacion_unidad.save }

		it { should respond_to(:principal) }
		it { should respond_to(:vinculada) }
		its(:principal) { should == unidad_principal }
		its(:vinculada) { should == unidad_relacionada }
	end

	describe "cuando relacionada_id no esta presente" do
		before { relacion_unidad.vinculada_id = nil }
		it { should_not be_valid }
	end

	describe "cuando principal_id no esta presente" do
		before { relacion_unidad.principal_id = nil }
		it { should_not be_valid }
	end
end
