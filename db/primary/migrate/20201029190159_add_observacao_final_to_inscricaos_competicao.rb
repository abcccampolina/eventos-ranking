class AddObservacaoFinalToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos_competicaos, :observacao_final, :string
  end
end
