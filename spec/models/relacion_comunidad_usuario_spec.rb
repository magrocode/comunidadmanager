# == Schema Information
#
# Table name: relacion_comunidad_usuarios
#
#  id            :integer         not null, primary key
#  comunidad_id  :integer
#  usuario_id    :integer
#  administrador :boolean         default(FALSE)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe RelacionComunidadUsuario do
  
  let(:comunidad) { FactoryGirl.create(:comunidad) }
  let(:usuario) { FactoryGirl.create(:usuario) }
  let(:relacion_comunidad_usuario) do
  	comunidad.relacion_comunidad_usuarios.build(usuario_id: usuario.id)
  end

  subject { relacion_comunidad_usuario }

  it { should be_valid }

  describe "Atributos accesibles" do
  	it "Debe permitir accesso a usuario_id y unidad_id" do
  		expect do
  			RelacionComunidadUsuario.new(usuario_id: usuario.id)
  		end.should_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end

  describe "Metodos de comunidad" do
  	before { relacion_comunidad_usuario.save }

  	it { should respond_to(:comunidad) }
  	it { should respond_to(:usuario) }
  	its(:comunidad) { should == comunidad }
  	its(:usuario) { should == usuario }
  end

  describe "Cuando comunidad_id no esta presente" do
  	before { relacion_comunidad_usuario.comunidad_id = nil }
  	it { should_not be_valid }
  end

  describe "Cuando ususario_id no esta presente" do
  	before { relacion_comunidad_usuario.usuario_id = nil }
  	it { should_not be_valid }
  end

  describe "Cuando usuario es autorizado mas de una vez a la misma comunidad" do
  	before { relacion_comunidad_usuario.save }

  	let(:relacion_duplicada) do
  		comunidad.relacion_comunidad_usuarios.build(usuario_id: usuario.id)
  	end

  	it { relacion_duplicada.should_not be_valid }
  end
  
end
