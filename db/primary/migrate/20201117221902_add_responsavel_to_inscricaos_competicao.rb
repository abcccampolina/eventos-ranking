class AddResponsavelToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos_competicaos, :responsavel_expositor, :string
  end
end
