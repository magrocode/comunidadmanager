class CreateComunidads < ActiveRecord::Migration
  def change
    create_table :comunidads do |t|
      t.string :nombre
      t.string :direccion
      t.string :ciudad
      t.string :region
      t.string :pais

      t.timestamps
    end
  end
end
