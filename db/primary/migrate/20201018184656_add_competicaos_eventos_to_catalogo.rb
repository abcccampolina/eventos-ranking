class AddCompeticaosEventosToCatalogo < ActiveRecord::Migration[6.0]
  def change
    add_reference :catalogos, :competicaos_evento, null: false, foreign_key: true
  end
end
