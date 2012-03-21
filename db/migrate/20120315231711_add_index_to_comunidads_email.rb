class AddIndexToComunidadsEmail < ActiveRecord::Migration
  def change
    add_index :comunidads, :email, unique: true
  end
end
