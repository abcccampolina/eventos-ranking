class AddDataAvaliacaoToEvento < ActiveRecord::Migration[6.0]
  def change
    add_column :eventos, :data_avaliacao, :date
  end
end
