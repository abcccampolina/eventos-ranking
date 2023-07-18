class CreateInscricaos < ActiveRecord::Migration[6.0]
  def change
    create_table :inscricaos do |t|
      t.references :srg_animal, null: false, foreign_key: true
      t.references :criador, foreign_key: { to_table: 'pessoas' }
      t.references :expositor, foreign_key: { to_table: 'pessoas' }
      t.string :status

      t.timestamps
    end
  end
end
