class AddCatalogoNomeToPodio < ActiveRecord::Migration[6.0]
  def change
    add_reference :podios, :catalogo_nome, foreign_key: true
  end
end
