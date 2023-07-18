class AddPesoToCriteriosCompeticaos < ActiveRecord::Migration[6.0]
  def change
    add_column :criterios_competicaos, :peso, :float
  end
end
