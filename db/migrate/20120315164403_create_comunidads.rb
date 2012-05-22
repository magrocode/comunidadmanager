class CreateComunidads < ActiveRecord::Migration
  def change
    create_table :comunidads do |t|
      t.string :nombre
      t.string :street
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
