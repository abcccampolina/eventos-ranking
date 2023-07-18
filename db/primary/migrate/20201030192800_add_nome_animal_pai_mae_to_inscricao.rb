class AddNomeAnimalPaiMaeToInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :nome_animal, :string
    add_column :inscricaos, :pai_animal_id, :integer
    add_column :inscricaos, :mae_animal_id, :integer
  end
end
