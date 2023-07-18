class AddColumnTempoToCompeticaoAvalicaos < ActiveRecord::Migration[6.0]
  def change
    add_column :competicao_avalicaos, :tempo_executado, :float
    add_column :competicao_avalicaos, :tempo_final, :float
  end
end
