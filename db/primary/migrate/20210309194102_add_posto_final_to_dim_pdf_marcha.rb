class AddPostoFinalToDimPdfMarcha < ActiveRecord::Migration[6.0]
  def change
    add_column :dim_pdf_marchas, :posto_final, :string
  end
end
