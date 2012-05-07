# == Schema Information
#
# Table name: unidads
#
#  id            :integer         not null, primary key
#  comunidad_id  :integer
#  tipounidad_id :integer
#  identificador :string(255)
#  participacion :float
#  superficie    :float
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Unidad < ActiveRecord::Base
  
  attr_accessible :identificador, :participacion, :superficie, :tipounidad, :tipounidad_id

  belongs_to :comunidad
  belongs_to :tipounidad

  has_many :relacionunidads, foreign_key: "principal_id", dependent: :destroy
  has_many :vinculadas, through: :relacionunidads, source: :vinculada
  
  validates :comunidad_id, presence: true
  validates :identificador, presence: true, length: { maximum: 50 }
  validates :participacion, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :superficie, numericality: true    
            
  
  def vinculada?(otra_unidad)
    relacionunidads.find_by_vinculada_id(otra_unidad.id)
  end

  def vincular!(otra_unidad)
    relacionunidads.create!(vinculada_id: otra_unidad.id)
  end

  def desvincular!(otra_unidad)
    relacionunidads.find_by_vinculada_id(otra_unidad.id).destroy
  end

  def principal?
    vinculadas.count > 0
  end
end
