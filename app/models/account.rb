# == Schema Information
#
# Table name: accounts
#
#  id           :integer         not null, primary key
#  nombre       :string(255)
#  codigo       :string(255)
#  descripcion  :string(255)
#  notas        :text
#  comunidad_id :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

class Account < ActiveRecord::Base

	belongs_to :comunidad

	validates :comunidad_id, presence: true
	validates :nombre, presence: true, length: { maximum: 50 }
	validates :codigo, length: { maximum: 30 }
	validates :descripcion, length: { maximum: 50 }
	validates :notas, length: { maximum: 500 }

end
