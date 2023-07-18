class RenameColumnAnimaisPorCategoriaToEventos < ActiveRecord::Migration[6.0]
  def change
    rename_column :eventos, :animais_por_categoria, :max_animais_categoria
  end
end
