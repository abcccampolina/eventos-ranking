class CreateCatalogoCompeticaos < ActiveRecord::Migration[6.0]
  def change
    create_table :catalogo_competicaos do |t|
      t.integer :qtd_inscritos
      t.string :qtd_catalogos
      t.references :competicaos_eventos, null: false, foreign_key: true

      t.timestamps
    end
  end
end
