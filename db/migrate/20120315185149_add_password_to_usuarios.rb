class AddPasswordToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :password_digest, :string

    add_column :usuarios, :remember_token, :string

    add_column :usuarios, :admin, :boolean

  end
end
