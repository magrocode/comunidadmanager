# == Schema Information
#
# Table name: tipounidads
#
#  id           :integer         not null, primary key
#  nombre       :string(255)
#  comunidad_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Tipounidad < ActiveRecord::Base
  
  attr_accessible :nombre
  belongs_to :comunidad
  has_many :unidads
  
  validates :comunidad_id, presence: true
  validates :nombre, presence: true, length: { maximum: 50 }
  
end
