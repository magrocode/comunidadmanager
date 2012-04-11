class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.integer :comunidad_id
      t.string :email
      t.string :nombre
      t.boolean :administrador
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
  end
end
