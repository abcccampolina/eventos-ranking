class CreateDimPdfGrandeCampeao < ActiveRecord::Migration[6.0]
  def change
    create_table :dim_pdf_grande_campeaos do |t|
      t.references :competicaos_evento, foreign_key: true
      t.float :nota
      t.integer :classificacao
      t.string :animal
      t.integer :colete
      t.references :catalogo, foreign_key: true
      t.references :criterios_competicao, foreign_key: true
      t.string :posto_competicao
      t.string :posto_final
      t.integer :classificacao_final
    end
  end
end
