class CreateUnidads < ActiveRecord::Migration
  def change
    create_table :unidads do |t|
      t.string :identificador
      t.float :participacion
      t.integer :comunidad_id

      t.timestamps
    end
  end
end
