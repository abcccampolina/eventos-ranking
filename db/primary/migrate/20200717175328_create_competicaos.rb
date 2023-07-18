class CreateCompeticaos < ActiveRecord::Migration[6.0]
  def change
    create_table :competicaos do |t|
      t.string :nome
      t.references :modalidade, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
