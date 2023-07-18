class CreateCristeriosAvaiacaos < ActiveRecord::Migration[6.0]
  def change
    create_table :cristerios_avaiacaos do |t|
      t.string :nome
      t.float :peso
      t.string :metodo
      t.references :cluster_criterios_avaliacao, null: false, foreign_key: true

      t.timestamps
    end
  end
end
