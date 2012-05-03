class Relacionunidad < ActiveRecord::Base

  attr_accessible :relacionada_id
  
  belongs_to :principal, class_name: "Unidad"
  belongs_to :relacionada, class_name: "Unidad"
  
  validates :principal_id, presence: true
  validates :relacionada_id, presence: true
end
