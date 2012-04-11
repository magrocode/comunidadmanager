class CreateUnidads < ActiveRecord::Migration
  def change
    create_table :unidads do |t|
      t.integer :comunidad_id
      t.string :identificador
      t.float :participacion

      t.timestamps
    end
  end
end
