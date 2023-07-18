class AddOrdemToCompeticaosEvento < ActiveRecord::Migration[6.0]
  def change
    add_column :competicaos_eventos, :ordem, :integer
  end
end
