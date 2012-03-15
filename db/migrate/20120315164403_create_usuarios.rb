class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nombre_comunidad
      t.string :email
      t.string :direccion
      t.string :ciudad
      t.string :region
      t.string :pais

      t.timestamps
    end
  end
end
