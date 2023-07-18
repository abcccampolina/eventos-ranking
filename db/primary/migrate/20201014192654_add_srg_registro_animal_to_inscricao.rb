class AddSrgRegistroAnimalToInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :srg_registro_animal, :string
  end
end
