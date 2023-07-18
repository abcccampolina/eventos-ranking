class AddCatalogoGeradoToCompeticaosEvento < ActiveRecord::Migration[6.0]
  def change
    add_column :competicaos_eventos, :catalogo_gerado, :boolean
  end
end
