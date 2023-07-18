class CreateInscricaosCompeticaos < ActiveRecord::Migration[6.0]
  def change
    create_table :inscricaos_competicaos do |t|
      t.references :inscricao, null: false, foreign_key: true
      t.references :competicao, null: false, foreign_key: true

      t.timestamps
    end
  end
end
