class RemoveDataFromCompeticaoAvalicao < ActiveRecord::Migration[6.0]
  def change
    remove_column :competicao_avalicaos, :data, :date
  end
end
