class AddProgenieToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos_competicaos, :progenie_id, :integer
    add_column :inscricaos_competicaos, :acasalamento_mae_id, :integer
    add_column :inscricaos_competicaos, :acasalamento_pai_id, :integer
  end
end
