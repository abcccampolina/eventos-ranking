class AddNumRegistroPaieMaeToInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :inscricaos, :num_registro_pai, :integer
    add_column :inscricaos, :num_registro_mae, :integer
  end
end
