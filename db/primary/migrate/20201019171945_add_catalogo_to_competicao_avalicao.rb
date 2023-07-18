class AddCatalogoToCompeticaoAvalicao < ActiveRecord::Migration[6.0]
  def change
    add_reference :competicao_avalicaos, :catalogo, foreign_key: true
  end
end
