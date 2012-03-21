class AddPasswordToComunidads < ActiveRecord::Migration
  def change
    add_column :comunidads, :password_digest, :string

    add_column :comunidads, :remember_token, :string

  end
end
