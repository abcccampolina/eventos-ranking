class AddEmpateToInscricaosCompeticaos < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos_competicaos, :empate, :boolean
  end
end
