class AddClusterToCompeticaoJuri < ActiveRecord::Migration[6.0]
  def change
    add_reference :competicao_juris, :cluster_criterios_avaliacao, foreign_key: true
  end
end
