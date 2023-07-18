class CreateCompeticaoDesempates < ActiveRecord::Migration[6.0]
  def change
    create_table :competicao_desempates do |t|
      t.references :competicaos_evento, null: false, foreign_key: true
      t.references :inscricao, null: false, foreign_key: true
      t.references :competicao_juri, null: false, foreign_key: true
      t.float :nota
      t.references :criterios_competicao, null: false, foreign_key: true

      t.timestamps
    end
  end
end
