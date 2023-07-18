class AddCampeaoAnteriorToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos_competicaos, :campeao_anterior_json, :json, default: []
  end
end
