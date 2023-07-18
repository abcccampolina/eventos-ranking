class AddColumnAnimairPorCategoriaToEventos < ActiveRecord::Migration[6.0]
  def change
    add_column :eventos, :animais_por_categoria, :integer
  end
end
