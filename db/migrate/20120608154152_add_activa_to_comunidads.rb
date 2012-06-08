class AddActivaToComunidads < ActiveRecord::Migration
  def change
    add_column :comunidads, :activa, :boolean, default: true

  end
end
