class CreateRelacionComunidadUsuarios < ActiveRecord::Migration
  def change
    create_table :relacion_comunidad_usuarios do |t|
      t.integer :comunidad_id
      t.integer :usuario_id

      t.timestamps
    end

    add_index :relacion_comunidad_usuarios, :comunidad_id
    add_index :relacion_comunidad_usuarios, :usuario_id
    add_index :relacion_comunidad_usuarios, [:comunidad_id, :usuario_id], unique: true
  end
end
