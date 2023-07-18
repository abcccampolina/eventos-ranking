class AddInscricaoToCatalogo < ActiveRecord::Migration[6.0]
  def change
    add_reference :catalogos, :inscricao, null: false, foreign_key: true
  end
end
