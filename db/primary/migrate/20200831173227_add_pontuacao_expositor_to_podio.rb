class AddPontuacaoExpositorToPodio < ActiveRecord::Migration[6.0]
  def change
    add_column :podios, :pontuacao_expositor, :float
  end
end
