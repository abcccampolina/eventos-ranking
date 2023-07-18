class AddRangeToEventos < ActiveRecord::Migration[6.0]
  def change
    add_column :eventos, :range_1_1, :integer
    add_column :eventos, :range_2_1, :integer
    add_column :eventos, :range_1_2, :integer
    add_column :eventos, :range_2_2, :integer
    add_column :eventos, :range_3_1, :integer
    add_column :eventos, :range_3_2, :integer
    add_column :eventos, :range_4_2, :integer
    add_column :eventos, :range_4_1, :integer
    add_column :eventos, :range_5_1, :integer
    add_column :eventos, :range_5_2, :integer
    add_column :eventos, :range_6_2, :integer
    add_column :eventos, :range_6_1, :integer
    add_column :eventos, :range_7_1, :integer
    add_column :eventos, :range_7_2, :integer
    add_column :eventos, :range_8_2, :integer
    add_column :eventos, :range_8_1, :integer
    add_column :eventos, :range_9_1, :integer
    add_column :eventos, :range_9_2, :integer
    add_column :eventos, :range_10_1, :integer
    add_column :eventos, :range_10_2, :integer
    add_column :eventos, :range_valor_1, :integer
    add_column :eventos, :range_valor_2, :integer
    add_column :eventos, :range_valor_3, :integer
    add_column :eventos, :range_valor_4, :integer
    add_column :eventos, :range_valor_5, :integer
    add_column :eventos, :range_valor_6, :integer
    add_column :eventos, :range_valor_7, :integer
    add_column :eventos, :range_valor_8, :integer
    add_column :eventos, :range_valor_9, :integer
    add_column :eventos, :range_valor_10, :integer
  end
end
