class AddAjustesColunasToDimPdfMorfologia < ActiveRecord::Migration[6.0]
  def change
    add_column :dim_pdf_morfologia, :posto_competicao, :string
    add_column :dim_pdf_morfologia, :nota_juri_desempate, :integer
    add_column :dim_pdf_morfologia, :posto_final, :string
    add_column :dim_pdf_morfologia, :classificacao_final, :integer
  end
end
