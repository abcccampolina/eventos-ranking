class AddActiveToEvento < ActiveRecord::Migration[6.0]
  def change
    add_column :eventos, :ativo, :string
  end
end
