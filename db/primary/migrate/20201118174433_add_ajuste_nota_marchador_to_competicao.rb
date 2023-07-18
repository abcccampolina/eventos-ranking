class AddAjusteNotaMarchadorToCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :competicaos, :ajuste_nota_marchador, :boolean, default: false
  end
end
