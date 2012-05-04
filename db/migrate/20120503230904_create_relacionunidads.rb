class CreateRelacionunidads < ActiveRecord::Migration
  def change
    create_table :relacionunidads do |t|
      t.integer :principal_id
      t.integer :relacionada_id

      t.timestamps
    end

    add_index :relacionunidads, :principal_id
    add_index :relacionunidads, :relacionada_id, unique: true
    add_index :relacionunidads, [:principal_id, :relacionada_id], unique: true
  end
end
