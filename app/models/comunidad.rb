# == Schema Information
#
# Table name: comunidads
#
#  id               :integer         not null, primary key
#  nombre           :string(255)
#  email            :string(255)
#  direccion        :string(255)
#  ciudad           :string(255)
#  region           :string(255)
#  pais             :string(255)
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  password_digest  :string(255)
#  remember_token   :string(255)
#

class Comunidad < ActiveRecord::Base
  
  attr_accessible :nombre, :email, :direccion, :ciudad, :region, :pais, :password, :password_confirmation
  has_secure_password
  before_save :create_remember_token
  
  has_many :unidads, dependent: :destroy
    
  validates :nombre, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }

  
  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
