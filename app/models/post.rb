# == Schema Information
#
# Table name: posts
#
#  id           :integer         not null, primary key
#  comunidad_id :integer
#  usuario_id   :integer
#  titulo       :string(255)
#  contenido    :text
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Post < ActiveRecord::Base

	attr_accessible :titulo, :contenido, :usuario, :usuario_id

	belongs_to :comunidad
	belongs_to :usuario

	validates :comunidad_id, presence: true
	validates :usuario_id, presence: true
	validates :titulo, length: { maximum: 50 }
	validates :contenido, presence: true
end
