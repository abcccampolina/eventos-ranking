class AddCatalogoNomeToCatalogo < ActiveRecord::Migration[6.0]
  def change
    add_reference :catalogos, :catalogo_nome, foreign_key: true
  end
end
