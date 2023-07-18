class AddNomeanimalToPremios < ActiveRecord::Migration[6.0]
  def change
    add_column :premios, :nome_animal, :string
  end
end
