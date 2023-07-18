class AddColumnMelhorIndicacaoEOutrosToParametroInscricaos < ActiveRecord::Migration[6.0]
  def change
    add_column :parametro_inscricaos, :melhor_indicacao_select, :string
    add_column :parametro_inscricaos, :tipo_marcha_select, :string
  end
end
