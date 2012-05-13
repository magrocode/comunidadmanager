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

  has_many :relacion_unidads, foreign_key: "principal_id", dependent: :destroy
  has_many :vinculadas, through: :relacion_unidads, source: :vinculada
  has_one :reverse_relacion_unidads, foreign_key: "vinculada_id",
                                      class_name: "RelacionUnidad",
                                      dependent: :destroy
  has_one :principal, through: :reverse_relacion_unidads, source: :principal
  
  validates :comunidad_id, presence: true
  validates :identificador, presence: true, length: { maximum: 50 }
  validates :participacion, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :superficie, numericality: true    
            
  
  def vinculada?(otra_unidad)
    relacion_unidads.find_by_vinculada_id(otra_unidad.id)
  end

  def vincular!(otra_unidad)
    relacion_unidads.create!(vinculada_id: otra_unidad.id)
  end

  def desvincular!(otra_unidad)
    relacion_unidads.find_by_vinculada_id(otra_unidad.id).destroy
  end

  def principal?
    vinculadas.count > 0
  end

  def has_principal?
    !principal.nil?
  end

  def vinculo_of?(otra_unidad)
    if !principal.nil?
      principal == otra_unidad
    end
  end
end
