class RemoveComunidadIdFromUsuarios < ActiveRecord::Migration
  def up
    remove_column :usuarios, :comunidad_id
  end

  def down
    add_column :usuarios, :comunidad_id, :integer
  end
end
