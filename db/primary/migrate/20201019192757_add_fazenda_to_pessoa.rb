class AddFazendaToPessoa < ActiveRecord::Migration[6.0]
  def change
    add_column :pessoas, :fazenda, :string
  end
end
