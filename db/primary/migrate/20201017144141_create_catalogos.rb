class CreateCatalogos < ActiveRecord::Migration[6.0]
  def change
    create_table :catalogos do |t|
      t.references :inscricaos, null: false, foreign_key: true
      t.string :nome_catalogo
      t.references :competicaos_eventos, null: false, foreign_key: true

      t.timestamps
    end
  end
end
