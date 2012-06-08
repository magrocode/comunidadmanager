class RelacionUsuarioUnidad < ActiveRecord::Base
	attr_accessible :usuario_id, :unidad_id
	
	belongs_to :usuario
	belongs_to :unidad

	validates :usuario_id, presence: true
	validates :unidad_id, presence: true

	validates_uniqueness_of :usuario_id, scope: :unidad_id
end
