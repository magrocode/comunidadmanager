# == Schema Information
#
# Table name: accounts
#
#  id           :integer         not null, primary key
#  nombre       :string(255)
#  codigo       :string(255)
#  descripcion  :string(255)
#  notas        :text
#  comunidad_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#


require 'spec_helper'

describe Account do

	let(:comunidad) { FactoryGirl.create(:comunidad) }
	before { @account = comunidad.accounts.build(nombre: "Cuenta corriente BCI",
												codigo: "76543210",
												descripcion: "Cuenta para gastos generales",
												notas: "Los cheques deben ser emitidos por administracion") }

	subject { @account }

	it { should respond_to(:nombre) }
	it { should respond_to(:codigo) }
	it { should respond_to(:descripcion) }
	it { should respond_to(:notas) }
	its(:comunidad) { should == comunidad }

	it { should  be_valid }

	describe "Cuando comunidad_id no esta presente" do
		before { @account.comunidad_id = nil }
		it { should_not be_valid }
	end

	describe "Cuando nombre no esta presente" do
		before { @account.nombre = "" }
		it { should_not be_valid }
	end

	describe "Cuando el nombre es muy largo" do
		before { @account.nombre = "a" * 51 }
		it { should_not be_valid }
	end

	describe "Cuando el codigo es muy largo" do
		before { @account.codigo = "a" * 31 }
		it { should_not be_valid }
	end

	describe "Cuando descripcion es muy largo" do
		before { @account.descripcion = "a" * 51 }
		it { should_not be_valid }
	end	

	describe "Cuando notas es muy largo" do
		before { @account.notas = "a" * 501 }
		it { should_not be_valid }
	end

end
