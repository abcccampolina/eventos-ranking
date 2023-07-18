class CreateDimPdfMarcha < ActiveRecord::Migration[6.0]
  def change
    create_table :dim_pdf_marchas do |t|
      t.references :competicaos_evento, null: true, foreign_key: true
      t.string :posto_anterior
      t.float :nota
      t.integer :classificacao
      t.string :animal
      t.string :colete
      t.references :catalogo, null: true, foreign_key: true
      t.references :criterios_competicao, null: true, foreign_key: true
    end
  end
end
