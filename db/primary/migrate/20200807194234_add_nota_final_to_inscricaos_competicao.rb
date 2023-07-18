class AddNotaFinalToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos_competicaos, :nota_final, :float
  end
end
