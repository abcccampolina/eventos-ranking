class AddCategoriaUnicaToCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :competicaos, :categoria_unica, :bool, default: false
  end
end
