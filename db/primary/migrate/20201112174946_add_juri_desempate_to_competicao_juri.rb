class AddJuriDesempateToCompeticaoJuri < ActiveRecord::Migration[6.0]
  def change
    add_column :competicao_juris, :juri_desempate, :boolean, default: false
  end
end
