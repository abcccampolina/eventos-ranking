class AddColumnFuncionalToClusterCriteriosAvaliacaos < ActiveRecord::Migration[6.0]
  def change
    add_column :cluster_criterios_avaliacaos, :funcional, :boolean, default: false
  end
end
