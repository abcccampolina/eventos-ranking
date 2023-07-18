class AddSexoToInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :sexo, :string
  end
end
