class AddPontuacaoExpositorCriadorToPremio < ActiveRecord::Migration[6.0]
  def change
    add_column :premios, :expositor, :string
    add_column :premios, :pontuacao_expositor, :float
    add_column :premios, :criador, :string
    add_column :premios, :pontuacao_criador, :string
  end
end
