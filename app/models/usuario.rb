# == Schema Information
#
# Table name: usuarios
#
#  id               :integer         not null, primary key
#  nombre_comunidad :string(255)
#  email            :string(255)
#  direccion        :string(255)
#  ciudad           :string(255)
#  region           :string(255)
#  pais             :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  password_digest  :string(255)
#  remember_token   :string(255)
#  admin            :boolean
#

class Usuario < ActiveRecord::Base
  attr_accessible :nombre_comunidad, :email, :direccion, :ciudad, :region, :pais, :password, :password_confirmation
  has_secure_password
    
  validates :nombre_comunidad, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

end
