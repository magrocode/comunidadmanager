class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :comunidad_id
      t.integer :usuario_id
      t.string :titulo
      t.text :contenido

      t.timestamps
    end

    add_index :posts, :comunidad_id
    add_index :posts, :usuario_id
  end
end
