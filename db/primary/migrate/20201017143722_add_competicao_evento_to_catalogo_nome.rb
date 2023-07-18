class AddCompeticaoEventoToCatalogoNome < ActiveRecord::Migration[6.0]
  def change
    add_reference :catalogo_nomes, :competicaos_eventos, null: false, foreign_key: true
  end
end
