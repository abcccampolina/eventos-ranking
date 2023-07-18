class AddEventoToInscricaos < ActiveRecord::Migration[6.0]
  def change
    add_reference :inscricaos, :evento, null: false, foreign_key: true
  end
end
