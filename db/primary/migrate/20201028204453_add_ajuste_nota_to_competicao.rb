class AddAjusteNotaToCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :competicaos, :ajuste_nota, :boolean
  end
end
