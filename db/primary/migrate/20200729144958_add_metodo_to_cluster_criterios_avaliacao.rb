class AddMetodoToClusterCriteriosAvaliacao < ActiveRecord::Migration[6.0]
  def change
    add_column :cluster_criterios_avaliacaos, :metodo, :string
  end
end
