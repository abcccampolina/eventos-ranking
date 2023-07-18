class AddColeteProgenieToCatalogo < ActiveRecord::Migration[6.0]
  def change
    add_column :catalogos, :numero_colete_progenie, :integer
  end
end
