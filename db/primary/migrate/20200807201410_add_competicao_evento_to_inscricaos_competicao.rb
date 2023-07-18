class AddCompeticaoEventoToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_reference :inscricaos_competicaos, :competicaos_evento, null: false, foreign_key: true
  end
end
