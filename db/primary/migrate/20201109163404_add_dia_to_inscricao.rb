class AddDiaToInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :faixa_etaria_dia, :integer
  end
end
