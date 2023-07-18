class AddAjusteDeNotaToInscricaosCompeticao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos_competicaos, :posto_anterior, :string
  end
end
