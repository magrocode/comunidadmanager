class AddPasswordToComunidads < ActiveRecord::Migration
  def change
    add_column :comunidads, :password_digest, :string

    add_column :comunidads, :remember_token, :string
    add_index  :comunidads, :remember_token

  end
end
