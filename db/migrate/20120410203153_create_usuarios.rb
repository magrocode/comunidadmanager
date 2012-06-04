class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.integer :comunidad_id
      t.string :email
      t.string :nombre
      t.boolean :administrador
      t.boolean :system_admin
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end

    add_index :usuarios, :comunidad_id
    add_index :usuarios, :email
    add_index :usuarios, :remember_token
  end
end
