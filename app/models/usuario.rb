# == Schema Information
#
# Table name: usuarios
#
#  id              :integer         not null, primary key
#  comunidad_id    :integer
#  email           :string(255)
#  nombre          :string(255)
#  administrador   :boolean
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class Usuario < ActiveRecord::Base
  
  attr_accessible :email, :nombre, :administrador, :password, :password_confirmation
  has_secure_password
  before_save :create_remember_token
  
  belongs_to :comunidad
  has_many :relacion_usuario_unidads, dependent: :destroy
  has_many :unidads, through: :relacion_usuario_unidads
  
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
