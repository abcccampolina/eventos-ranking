class AddClassificacaoFinalToDimPdfMarcha < ActiveRecord::Migration[6.0]
  def change
    add_column :dim_pdf_marchas, :classificacao_final, :integer
  end
end
