class RemoveColumnNomeJuriDesempateFromCompeticaoAvaliacaos < ActiveRecord::Migration[6.0]
  def change
    remove_column(:competicao_avalicaos, :nome_juri_desempate, :string) if column_exists? :competicao_avalicaos, :nome_juri_desempate
  end
end
