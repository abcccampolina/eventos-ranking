class AddClassificacaoToCompeticaoAvalicao < ActiveRecord::Migration[6.0]
  def change
    add_column :competicao_avalicaos, :classificacao, :integer
  end
end
