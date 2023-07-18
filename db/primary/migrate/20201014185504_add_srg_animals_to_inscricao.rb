class AddSrgAnimalsToInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :srg_animal_id, :string
  end
end
