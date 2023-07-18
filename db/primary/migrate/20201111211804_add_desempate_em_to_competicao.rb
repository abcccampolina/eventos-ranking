class AddDesempateEmToCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :competicaos, :desempate_em, :string
  end
end
