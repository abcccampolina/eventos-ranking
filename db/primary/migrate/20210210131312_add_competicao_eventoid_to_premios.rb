class AddCompeticaoEventoidToPremios < ActiveRecord::Migration[6.0]
  def change
    add_reference :premios, :competicaos_evento, foreign_key: true
  end
end
