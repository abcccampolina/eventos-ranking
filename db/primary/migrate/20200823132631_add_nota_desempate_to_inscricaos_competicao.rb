class AddNotaDesempateToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos_competicaos, :nota_desempate, :float
  end
end
