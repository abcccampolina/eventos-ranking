class CreateEventos < ActiveRecord::Migration[6.0]
  def change
    create_table :eventos do |t|
      t.string :nome
      t.date :dataInicio
      t.date :dataFim
      t.string :anoHipico

      t.timestamps
    end
  end
end
