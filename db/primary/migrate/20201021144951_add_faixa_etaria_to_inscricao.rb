class AddFaixaEtariaToInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :faixa_etaria, :string
  end
end
