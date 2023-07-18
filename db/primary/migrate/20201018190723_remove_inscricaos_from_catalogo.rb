class RemoveInscricaosFromCatalogo < ActiveRecord::Migration[6.0]
  def change
    remove_reference :catalogos, :inscricaos, null: false, foreign_key: true
  end
end
