class AddNomeCatalogoToPremios < ActiveRecord::Migration[6.0]
  def change
    add_column :premios, :nome_catalogo, :string
  end
end
