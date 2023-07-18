class AddAnimaisJulgadosToPremios < ActiveRecord::Migration[6.0]
  def change
    add_column :premios, :animais_julgados, :integer
  end
end
