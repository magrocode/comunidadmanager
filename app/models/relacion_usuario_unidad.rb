# == Schema Information
#
# Table name: relacion_usuario_unidads
#
#  id         :integer         not null, primary key
#  usuario_id :integer
#  unidad_id  :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class RelacionUsuarioUnidad < ActiveRecord::Base
	attr_accessible :usuario_id, :unidad_id
	
	belongs_to :usuario
	belongs_to :unidad

	validates :usuario_id, presence: true
	validates :unidad_id, presence: true

	validates_uniqueness_of :usuario_id, scope: :unidad_id
end
