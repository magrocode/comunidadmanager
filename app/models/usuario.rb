# == Schema Information
#
# Table name: usuarios
#
#  id              :integer         not null, primary key
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
  
  
  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
