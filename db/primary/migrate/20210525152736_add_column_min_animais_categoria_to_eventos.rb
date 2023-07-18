class AddColumnMinAnimaisCategoriaToEventos < ActiveRecord::Migration[6.0]
  def change
    add_column :eventos, :min_animais_categoria, :integer
  end
end
