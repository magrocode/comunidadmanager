class RelacionComunidadUsuario < ActiveRecord::Base

	belongs_to :comunidad 
	belongs_to :usuario 

	validates :comunidad_id, presence: true
	validates :usuario_id, presence: true

	validates_uniqueness_of :comunidad_id, scope: :usuario_id
end
