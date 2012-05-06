class Relacionunidad < ActiveRecord::Base

  attr_accessible :vinculada_id
  
  belongs_to :principal, class_name: "Unidad"
  belongs_to :vinculada, class_name: "Unidad"
  
  validates :principal_id, presence: true
  validates :vinculada_id, presence: true
end
