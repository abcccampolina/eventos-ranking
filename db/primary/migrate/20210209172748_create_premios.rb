class CreatePremios < ActiveRecord::Migration[6.0]
  def change
    create_table :premios do |t|
      t.references :inscricaos_competicao, foreign_key: true
      t.integer :inscricao_id
      t.integer :numero_colete
      t.string :posto
      t.integer :inscricao_campeao_id
    end
  end
end
