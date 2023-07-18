class AddTablecompToParametroInscricao < ActiveRecord::Migration[6.0]
  def change
    add_column :parametro_inscricaos, :comp_or_table, :string
    add_column :parametro_inscricaos, :comp_posicao_inicio, :integer
    add_column :parametro_inscricaos, :comp_posicao_fim, :integer
  end
end
