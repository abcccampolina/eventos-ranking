class AddNotaFinalAjusteToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos_competicaos, :nota_final_ajustada, :float
  end
end
