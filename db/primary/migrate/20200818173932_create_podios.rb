class CreatePodios < ActiveRecord::Migration[6.0]
  def change
    create_table :podios do |t|
      t.string :descricao
      t.references :competicaos_evento, null: false, foreign_key: true
      t.integer :posicao
      t.boolean :exibir_home

      t.timestamps
    end
  end
end
