class CreateRelacionUsuarioUnidads < ActiveRecord::Migration
  def change
    create_table :relacion_usuario_unidads do |t|
    	t.integer :usuario_id 
    	t.integer :unidad_id

    	t.timestamps
    end

    add_index :relacion_usuario_unidads, :usuario_id
    add_index :relacion_usuario_unidads, :unidad_id
    add_index :relacion_usuario_unidads, [:usuario_id, :unidad_id], unique: true
  end
end
