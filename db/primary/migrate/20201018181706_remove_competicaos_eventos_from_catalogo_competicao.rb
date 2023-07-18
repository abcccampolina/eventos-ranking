class RemoveCompeticaosEventosFromCatalogoCompeticao < ActiveRecord::Migration[6.0]
  def change
    remove_reference :catalogo_competicaos, :competicaos_eventos, null: false, foreign_key: true
  end
end
