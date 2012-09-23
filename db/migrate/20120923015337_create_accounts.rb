class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :nombre
      t.string :codigo
      t.string :descripcion
      t.text :notas
      t.integer :comunidad_id

      t.timestamps
    end
  end
end
