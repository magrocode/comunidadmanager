class Comunidad < ActiveRecord::Base
  
  attr_accessible :nombre_comunidad, :email, :direccion, :ciudad, :region, :pais, :password, :password_confirmation
  has_secure_password
    
  validates :nombre_comunidad, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }

end
