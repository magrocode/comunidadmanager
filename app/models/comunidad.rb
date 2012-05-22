# == Schema Information
#
# Table name: comunidads
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  direccion  :string(255)
#  ciudad     :string(255)
#  region     :string(255)
#  pais       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Comunidad < ActiveRecord::Base

  attr_accessible :nombre, :street, :city, :country
  attr_accessible :email, :twitter, :telefono

  has_many :unidads, dependent: :destroy
  has_many :usuarios, dependent: :destroy
  has_many :tipounidads, dependent: :destroy

  validates :nombre, presence: true, length: { maximum: 50 }
  validates :street, :city, :country, length: { maximum: 255 }
  validates :email, :twitter, length: { maximum: 255 }
  validates :telefono, length: { maximum: 50 }

end