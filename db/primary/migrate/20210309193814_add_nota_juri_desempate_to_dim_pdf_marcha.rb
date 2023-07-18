class AddNotaJuriDesempateToDimPdfMarcha < ActiveRecord::Migration[6.0]
  def change
    add_column :dim_pdf_marchas, :nota_juri_desempate, :integer
  end
end
