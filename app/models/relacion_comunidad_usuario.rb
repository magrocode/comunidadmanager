# == Schema Information
#
# Table name: relacion_comunidad_usuarios
#
#  id            :integer         not null, primary key
#  comunidad_id  :integer
#  usuario_id    :integer
#  administrador :boolean         default(FALSE)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class RelacionComunidadUsuario < ActiveRecord::Base
	attr_accessible :id, :comunidad_id, :usuario_id, :administrador

	belongs_to :comunidad 
	belongs_to :usuario 

	validates :comunidad_id, presence: true
	validates :usuario_id, presence: true

	validates_uniqueness_of :comunidad_id, scope: :usuario_id

end
