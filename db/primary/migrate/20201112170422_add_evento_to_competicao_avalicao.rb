class AddEventoToCompeticaoAvalicao < ActiveRecord::Migration[6.0]
  def change
    add_reference :competicao_avalicaos, :evento, null: true, foreign_key: true
  end
end
