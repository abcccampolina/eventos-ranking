class CreateCriteriosCompeticaos < ActiveRecord::Migration[6.0]
  def change
    create_table :criterios_competicaos do |t|
      t.references :competicao, null: false, foreign_key: true
      t.references :criterios_avaliacao, null: false, foreign_key: true

      t.timestamps
    end
  end
end
