class AddGroupProgenieToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos_competicaos, :grupo_progenie, :integer
  end
end
