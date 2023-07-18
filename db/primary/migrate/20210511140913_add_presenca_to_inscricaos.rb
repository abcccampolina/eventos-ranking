class AddPresencaToInscricaos < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :presenca_evento, :string
  end
end
