class RemoveCompeticaoEventoFromPodio < ActiveRecord::Migration[6.0]
  def change
    remove_reference :podios, :competicaos_evento, null: false, foreign_key: true
  end
end
