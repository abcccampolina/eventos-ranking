class RemovePesoFromCriteriosAvaliacao < ActiveRecord::Migration[6.0]
  def change
    remove_column :criterios_avaliacaos, :peso, :float
  end
end
