class CreateCompeticaoJuris < ActiveRecord::Migration[6.0]
  def change
    create_table :competicao_juris do |t|
      t.references :competicaos_evento, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
