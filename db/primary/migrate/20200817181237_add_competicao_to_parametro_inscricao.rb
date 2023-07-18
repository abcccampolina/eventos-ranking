class AddCompeticaoToParametroInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :parametro_inscricaos, :competicao_antecessora, :integer
  end
end
