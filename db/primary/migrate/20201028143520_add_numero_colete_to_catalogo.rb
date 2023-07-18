class AddNumeroColeteToCatalogo < ActiveRecord::Migration[6.0]
  def change
    add_column :catalogos, :numero_colete, :integer
  end
end
