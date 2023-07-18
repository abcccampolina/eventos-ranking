class AddMetodoToCompeticaosEvento < ActiveRecord::Migration[6.0]
  def change
    add_column :competicaos_eventos, :metodo, :string
  end
end
