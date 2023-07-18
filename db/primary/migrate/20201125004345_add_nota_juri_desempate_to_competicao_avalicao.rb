class AddNotaJuriDesempateToCompeticaoAvalicao < ActiveRecord::Migration[6.0]
  def change
    add_column :competicao_avalicaos, :nota_juri_desempate, :float
  end
end
