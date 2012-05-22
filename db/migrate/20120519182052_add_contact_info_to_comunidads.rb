class AddContactInfoToComunidads < ActiveRecord::Migration
  def change
    add_column :comunidads, :email, :string

    add_column :comunidads, :twitter, :string

    add_column :comunidads, :telefono, :string 
  end
end
