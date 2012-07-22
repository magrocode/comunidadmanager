class RemoveComunidadIdFromUsuarios < ActiveRecord::Migration
  def up
    remove_column :usuarios, :comunidad_id
    remove_column :usuarios, :administrador
  end

  def down
    add_column :usuarios, :comunidad_id, :integer
    add_column :usuarios, :administrador, :boolean
  end
end
