class AddAnoToInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :ano_hipico, :string
  end
end
