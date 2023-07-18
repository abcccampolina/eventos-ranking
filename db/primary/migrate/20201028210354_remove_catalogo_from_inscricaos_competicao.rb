class RemoveCatalogoFromInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    remove_reference :inscricaos_competicaos, :catalogo, null: false, foreign_key: true
  end
end
