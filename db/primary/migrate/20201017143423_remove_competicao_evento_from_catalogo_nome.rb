class RemoveCompeticaoEventoFromCatalogoNome < ActiveRecord::Migration[6.0]
  def change
    remove_reference :catalogo_nomes, :competicaos_eventos, null: false, foreign_key: true
  end
end
