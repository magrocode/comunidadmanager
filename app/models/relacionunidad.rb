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

class Relacionunidad < ActiveRecord::Base

  attr_accessible :vinculada_id
  
  belongs_to :principal, class_name: "Unidad"
  belongs_to :vinculada, class_name: "Unidad"
  
  validates :principal_id, presence: true
  validates :vinculada_id, presence: true
end
