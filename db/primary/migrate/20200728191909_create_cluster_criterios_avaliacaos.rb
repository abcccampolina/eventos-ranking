class CreateClusterCriteriosAvaliacaos < ActiveRecord::Migration[6.0]
  def change
    create_table :cluster_criterios_avaliacaos do |t|
      t.string :nome

      t.timestamps
    end
  end
end
