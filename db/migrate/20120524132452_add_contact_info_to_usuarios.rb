class AddContactInfoToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :twitter, :string

    add_column :usuarios, :telefono, :string

  end
end
