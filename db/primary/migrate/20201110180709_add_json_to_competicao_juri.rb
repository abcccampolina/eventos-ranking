class AddJsonToCompeticaoJuri < ActiveRecord::Migration[6.0]
  def change
    add_column :competicao_juris, :store_competicao_evento_id, :json, default: []
  end
end
