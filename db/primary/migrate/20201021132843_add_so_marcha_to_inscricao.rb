class AddSoMarchaToInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :so_marcha, :boolean
  end
end
