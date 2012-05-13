class CreateRelacionUnidads < ActiveRecord::Migration
  def change
    create_table :relacion_unidads do |t|
      t.integer :principal_id
      t.integer :vinculada_id

      t.timestamps
    end

    add_index :relacion_unidads, :principal_id
    add_index :relacion_unidads, :vinculada_id, unique: true
    add_index :relacion_unidads, [:principal_id, :vinculada_id], unique: true
  end
end
