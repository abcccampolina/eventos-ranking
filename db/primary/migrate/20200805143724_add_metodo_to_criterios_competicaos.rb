class AddMetodoToCriteriosCompeticaos < ActiveRecord::Migration[6.0]
  def change
    add_column :criterios_competicaos, :metodo, :string
  end
end
