# == Schema Information
#
# Table name: posts
#
#  id           :integer         not null, primary key
#  comunidad_id :integer
#  usuario_id   :integer
#  titulo       :string(255)
#  contenido    :text
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'spec_helper'

describe Post do
  
  let(:comunidad) { FactoryGirl.create(:comunidad) }
  let(:usuario) { FactoryGirl.create(:usuario) }
  before { @post = comunidad.posts.build(titulo: "Reparaciones en quincho",
  											contenido: "A partir del dia 14 de junio de 2012 comenzaran los trabajos",
  											usuario: usuario) }

  subject { @post }

  it { should respond_to(:titulo) }
  it { should respond_to(:contenido) }
  it { should respond_to(:comunidad_id) }
  it { should respond_to(:comunidad) }
  it { should respond_to(:usuario_id) }
  it { should respond_to(:usuario) }

  it { should be_valid }

  describe "Cuando comunidad_id no esta presente" do
  	before { @post.comunidad_id = nil }
  	it { should_not be_valid }
  end

  describe "Cuando usuario_id no esta presente" do
  	before { @post.usuario_id = nil }
  	it { should_not be_valid }
  end

  describe "Cuando titulo no esta presente" do
  	before { @post.titulo = nil }
  	it { should_not be_valid }
  end

  describe "Cuando contenido no esta presente" do
  	before { @post.contenido = nil }
  	it { should_not be_valid }
  end

  describe "Cuando titulo es muy largo" do
  	before { @post.titulo = "a" * 51 }
  	it { should_not be_valid }
  end

  #describe "Cuando contenido es muy largo" do
  #	before { @post.contenido = "a" * 1001 }
  #	it { should_not be_valid }
  #end
end
