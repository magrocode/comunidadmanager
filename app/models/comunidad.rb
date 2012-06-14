# == Schema Information
#
# Table name: comunidads
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  street     :string(255)
#  city       :string(255)
#  country    :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  email      :string(255)
#  twitter    :string(255)
#  telefono   :string(255)
#  activa     :boolean
#

class Comunidad < ActiveRecord::Base

  attr_accessible :nombre, :street, :city, :country
  attr_accessible :email, :twitter, :telefono

  has_many :unidads, dependent: :destroy
  has_many :usuarios, dependent: :destroy
  has_many :tipounidads, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :nombre, presence: true, length: { maximum: 50 }
  validates :street, :city, :country, length: { maximum: 255 }
  validates :email, :twitter, length: { maximum: 255 }
  validates :telefono, length: { maximum: 50 }

  def desactivar!
  	update_attribute(:activa, false)  	
  end

  def activar!
  	update_attribute(:activa, true)
  end
end
