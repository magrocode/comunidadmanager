# == Schema Information
#
# Table name: usuarios
#
#  id               :integer         not null, primary key
#  nombre_comunidad :string(255)
#  email            :string(255)
#  direccion        :string(255)
#  ciudad           :string(255)
#  region           :string(255)
#  pais             :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

require 'spec_helper'

describe Usuario do
  
  before { @usuario = Usuario.new(nombre_comunidad: "Comunidad de Ejemplo", email: "mario@magrocode.com", 
                                  direccion: "Huerfanos 1055", ciudad: "Santiago", region: "Region metropolitana",
                                  pais: "Chile") }
                                  
  subject { @usuario }
  
  it { should respond_to(:nombre_comunidad) }
  it { should respond_to(:email) }
  it { should respond_to(:direccion) }  
  it { should respond_to(:ciudad) }
  it { should respond_to(:region) }
  it { should respond_to(:pais) }
  
  
  
end
