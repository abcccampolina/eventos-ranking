class RemoveMetodoFromCriteriosAvaliacao < ActiveRecord::Migration[6.0]
  def change
    remove_column :criterios_avaliacaos, :metodo, :string
  end
end
