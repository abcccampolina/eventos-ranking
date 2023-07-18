class CreateCatalogoNomes < ActiveRecord::Migration[6.0]
  def change
    create_table :catalogo_nomes do |t|
      t.string :nome
      t.integer :ordem_nome
      t.references :competicaos_eventos, null: false, foreign_key: true

      t.timestamps
    end
  end
end
