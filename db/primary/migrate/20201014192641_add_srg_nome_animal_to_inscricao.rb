class AddSrgNomeAnimalToInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :srg_nome_animal, :string
  end
end
