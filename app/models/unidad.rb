# == Schema Information
#
# Table name: unidads
#
#  id            :integer         not null, primary key
#  identificador :string(255)
#  participacion :float
#  comunidad_id  :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Unidad < ActiveRecord::Base
  attr_accessible :identificador, :participacion
  
end
