class AddPontuacaoCriadorToPodio < ActiveRecord::Migration[6.0]
  def change
    add_column :podios, :pontuacao_criador, :float
  end
end
