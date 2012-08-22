class CreateRelacionComunidadUsuarios < ActiveRecord::Migration
  def change
    create_table :relacion_comunidad_usuarios do |t|
      t.integer :comunidad_id
      t.integer :usuario_id
      t.boolean :administrador, default: false

      t.timestamps
    end

    add_index :relacion_comunidad_usuarios, :comunidad_id
    add_index :relacion_comunidad_usuarios, :usuario_id
    add_index :relacion_comunidad_usuarios, [:comunidad_id, :usuario_id], unique: true, name: "index_rel_comunidad_usuarios_on_comunidad_id_and_usuario_id"
  end
end
