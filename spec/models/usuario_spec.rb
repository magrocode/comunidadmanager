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

require 'spec_helper'

describe Usuario do
  pending "add some examples to (or delete) #{__FILE__}"
end
