class ChangeFaixaEtariaToIntFromInscricao < ActiveRecord::Migration[6.0]
    change_table :inscricaos do |table|
      # table.change :faixa_etaria, 'integer CAST(faixa_etaria AS integer)'
      change_column :inscricaos, :faixa_etaria, :integer 
    end
end