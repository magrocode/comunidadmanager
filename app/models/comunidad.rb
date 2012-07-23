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
  #has_many :usuarios, dependent: :destroy
  has_many :relacion_comunidad_usuarios
  has_many :usuarios, through: :relacion_comunidad_usuarios
  has_many :tipounidads, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :nombre, presence: true, length: { maximum: 50 }
  validates :street, :city, :country, length: { maximum: 255 }
  validates :email, :twitter, length: { maximum: 255 }
  validates :telefono, length: { maximum: 50 }

  def feed_posts
    posts
  end

  def desactivar!
  	update_attribute(:activa, false)  	
  end

  def activar!
  	update_attribute(:activa, true)
  end

  def autorizar_usuario!(usuario)
    relacion_comunidad_usuarios.create!(usuario_id: usuario.id)
  end

  def usuario_autorizado?(usuario)
    relacion_comunidad_usuarios.find_by_usuario_id(usuario.id)
  end

  def administradores
    relacion_comunidad_usuarios.where(:administrador => true)
  end

  def administrador?(usuario)
     # verifica si es administrador en comunidad
    if relacion_comunidad_usuarios.find_by_usuario_id(usuario.id) == nil
      false
    else
      relacion_comunidad_usuarios.find_by_usuario_id(usuario.id).administrador?
    end
  end

end
