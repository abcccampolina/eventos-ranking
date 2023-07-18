class AddAnoHipicoToRanking < ActiveRecord::Migration[6.0]
  def change
    add_column :rankings, :ano_hipico, :integer
  end
end
