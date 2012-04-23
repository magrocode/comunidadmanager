class CreateTipounidads < ActiveRecord::Migration
  def change
    create_table :tipounidads do |t|
      t.string :nombre
      t.integer :comunidad_id

      t.timestamps
    end
  end
end
