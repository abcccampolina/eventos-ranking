class AddPontuacaoToPremio < ActiveRecord::Migration[6.0]
  def change
    add_column :premios, :pontuacao, :float
  end
end
