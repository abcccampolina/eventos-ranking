class AddEventoToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_reference :inscricaos_competicaos, :evento, foreign_key: true
  end
end
