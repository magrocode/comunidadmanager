class CreateUnidads < ActiveRecord::Migration
  def change
    create_table :unidads do |t|
      t.integer :comunidad_id
      t.integer :tipounidad_id
      t.string :identificador
      t.float :participacion
      t.float :superficie

      t.timestamps
    end

    add_index :unidads, :comunidad_id
    add_index :unidads, :identificador
  end
end
