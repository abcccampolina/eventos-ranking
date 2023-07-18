class CreateCompeticaosEventos < ActiveRecord::Migration[6.0]
  def change
    create_table :competicaos_eventos do |t|
      t.references :competicao, null: false, foreign_key: true
      t.references :evento, null: false, foreign_key: true

      t.timestamps
    end
  end
end
