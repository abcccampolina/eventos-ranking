class RemoveJsonFromCompeticaoJuri < ActiveRecord::Migration[6.0]
  def change
    remove_column :competicao_juris, :store_competicao_evento_id, :json
  end
end
