class AddMarchaePelagemToInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :pelagem, :string
    add_column :inscricaos, :marcha, :string
  end
end
