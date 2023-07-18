class AddAjustesDeNotaToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_reference :inscricaos_competicaos, :catalogo, null: true, foreign_key: true
    add_column :inscricaos_competicaos, :posto, :string
    add_column :inscricaos_competicaos, :nota_final_sem_ajuste, :float
  end
end
