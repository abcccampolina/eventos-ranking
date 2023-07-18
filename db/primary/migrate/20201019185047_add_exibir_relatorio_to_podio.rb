class AddExibirRelatorioToPodio < ActiveRecord::Migration[6.0]
  def change
    add_column :podios, :exibir_relatorio, :boolean
  end
end
