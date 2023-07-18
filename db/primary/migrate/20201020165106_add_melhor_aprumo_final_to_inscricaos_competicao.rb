class AddMelhorAprumoFinalToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos_competicaos, :nota_final_melhor_aprumo, :boolean
  end
end
