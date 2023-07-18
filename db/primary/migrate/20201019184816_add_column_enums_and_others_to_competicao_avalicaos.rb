class AddColumnEnumsAndOthersToCompeticaoAvalicaos < ActiveRecord::Migration[6.0]
  def change
    add_column :competicao_avalicaos, :ocorrencia, :string
    add_column :competicao_avalicaos, :melhor_cabeca, :boolean, default: false
    add_column :competicao_avalicaos, :aprumacao, :boolean, default: false
  end
end
