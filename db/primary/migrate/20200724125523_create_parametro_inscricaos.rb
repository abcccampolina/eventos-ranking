class CreateParametroInscricaos < ActiveRecord::Migration[6.0]
  def change
    create_table :parametro_inscricaos do |t|
      t.string :nome
      t.references :competicao, null: false, foreign_key: true
      t.string :coluna_parametro
      t.string :operador_parametro
      t.string :valor_parametro

      t.timestamps
    end
  end
end
