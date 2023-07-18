class CreateRanking < ActiveRecord::Migration[6.0]
  def change
    create_table :rankings do |t|
      t.string :tipo
      t.integer :identificacao
      t.string :nome
      t.integer :pontuacao
    end
  end
end
