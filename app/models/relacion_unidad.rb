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

class RelacionUnidad < ActiveRecord::Base

  attr_accessible :vinculada_id
  
  belongs_to :principal, class_name: "Unidad"
  belongs_to :vinculada, class_name: "Unidad"
  
  validates :principal_id, presence: true
  validates :vinculada_id, presence: true
  validate  :vinculada_no_debe_ser_principal
  validate  :principal_no_debe_ser_vinculada
  validate  :vinculada_no_debe_ser_vinculada

  def vinculada_no_debe_ser_principal
    # cuando vinculada ya se encuentra en principal
    # es decir, cuando una vinculada ya es principal y tiene otras vinculadas
    if RelacionUnidad.find_by_principal_id(vinculada_id)
      errors.add(:vinculada_id, "Es principal de otras unidades")
    end
  end

  def principal_no_debe_ser_vinculada
    if RelacionUnidad.find_by_vinculada_id(principal_id)
      errors.add(:principal_id, "Es vinculada a otra principal")
    end
  end

  def vinculada_no_debe_ser_vinculada
    if RelacionUnidad.find_by_vinculada_id(vinculada_id)
      errors.add(:vinculada_id, "Es vinculada")
    end
  end

end
