class AddNotaJuriDesempateToDimPdfGrandeCampeao < ActiveRecord::Migration[6.0]
  def change
    add_column :dim_pdf_grande_campeaos, :nota_juri_desempate, :float
  end
end
