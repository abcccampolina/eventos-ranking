class CreateCompeticaoAvalicaos < ActiveRecord::Migration[6.0]
  def change
    create_table :competicao_avalicaos do |t|
      t.references :competicao_juri, null: false, foreign_key: true
      t.references :criterios_competicao, null: false, foreign_key: true
      t.references :inscricao, null: false, foreign_key: true
      t.float :nota
      t.date :data

      t.timestamps
    end
  end
end
