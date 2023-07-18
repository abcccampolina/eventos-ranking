class AddCriterioCompeticaoAnteriorToParametroInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :parametro_inscricaos, :criterio_competicao_antecessora, :integer
  end
end
