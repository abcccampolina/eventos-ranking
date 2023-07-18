class AddJsonCriterioToCompeticaoJuri < ActiveRecord::Migration[6.0]
  def change
    add_column :competicao_juris, :store_cluster_criterio_avaliacao_id, :json, default: []
  end
end
