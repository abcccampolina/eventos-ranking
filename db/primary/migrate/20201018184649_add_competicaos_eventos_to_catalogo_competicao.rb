class AddCompeticaosEventosToCatalogoCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_reference :catalogo_competicaos, :competicaos_evento, null: false, foreign_key: true
  end
end
