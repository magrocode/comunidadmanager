class CreateTipounidads < ActiveRecord::Migration
  def change
    create_table :tipounidads do |t|
      t.string :nombre
      t.integer :comunidad_id

      t.timestamps
    end

    add_index :tipounidads, :comunidad_id
  end
end
