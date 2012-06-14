# == Schema Information
#
# Table name: usuarios
#
#  id              :integer         not null, primary key
#  comunidad_id    :integer
#  email           :string(255)
#  nombre          :string(255)
#  administrador   :boolean
#  system_admin    :boolean
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  twitter         :string(255)
#  telefono        :string(255)
#

class Usuario < ActiveRecord::Base
  
  attr_accessible :email, :nombre, :twitter, :telefono, :administrador, :system_admin, :password, :password_confirmation
  has_secure_password
  before_save :create_remember_token
  
  belongs_to :comunidad
  has_many :relacion_usuario_unidads, dependent: :destroy
  has_many :unidades_autorizadas, through: :relacion_usuario_unidads, source: :unidad
  has_many :posts, dependent: :destroy
  
  validates :nombre, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :twitter, :telefono, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  
  
  def unidad_autorizada?(unidad)
    relacion_usuario_unidads.find_by_unidad_id(unidad.id)
  end

  def autorizar_unidad!(unidad)
    relacion_usuario_unidads.create!(unidad_id: unidad.id)
  end

  def desautorizar_unidad!(unidad)
    relacion_usuario_unidads.find_by_unidad_id(unidad.id).destroy
  end

  def cambiar_comunidad!(nueva_comunidad)
    comunidad = nueva_comunidad
    update_attribute(:comunidad, nueva_comunidad)
  end

  def comunidad?(nueva_comunidad)
    comunidad == nueva_comunidad
  end

  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
