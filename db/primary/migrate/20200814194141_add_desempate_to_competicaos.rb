class AddDesempateToCompeticaos < ActiveRecord::Migration[6.0]
  def change
    add_reference :competicaos, :competicao, foreign_key: true
    rename_column :competicaos, :competicao_id, :competicao_desempate
  end
end
