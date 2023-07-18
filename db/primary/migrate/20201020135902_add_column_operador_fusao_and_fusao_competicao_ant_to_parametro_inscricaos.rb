class AddColumnOperadorFusaoAndFusaoCompeticaoAntToParametroInscricaos < ActiveRecord::Migration[6.0]
  def change
    add_column :parametro_inscricaos, :operador_fusao, :string
    add_column :parametro_inscricaos, :fusao_competicao_antecessora_id, :integer
    add_index :parametro_inscricaos, :fusao_competicao_antecessora_id
  end
end
