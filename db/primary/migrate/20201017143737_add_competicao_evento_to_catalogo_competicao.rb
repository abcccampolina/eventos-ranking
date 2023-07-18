class AddCompeticaoEventoToCatalogoCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_reference :catalogo_competicaos, :competicaos_eventos, null: false, foreign_key: true
  end
end
