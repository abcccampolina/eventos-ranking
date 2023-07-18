class AddPesoToPodio < ActiveRecord::Migration[6.0]
  def change
    add_column :podios, :pontuacao, :float
  end
end
