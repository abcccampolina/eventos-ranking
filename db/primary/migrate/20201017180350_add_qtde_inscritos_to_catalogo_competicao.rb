class AddQtdeInscritosToCatalogoCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :catalogo_competicaos, :qtd_inscritos_fim, :integer
  end
end
