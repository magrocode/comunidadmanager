class AddLenguajeToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :lenguaje, :string

  end
end
