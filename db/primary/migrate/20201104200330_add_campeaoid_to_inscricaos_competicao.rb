class AddCampeaoidToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos_competicaos, :campeao, :integer
    add_column :inscricaos_competicaos, :campeao_anterior, :integer
  end
end
