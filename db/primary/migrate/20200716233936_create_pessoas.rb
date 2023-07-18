class CreatePessoas < ActiveRecord::Migration[6.0]
  def change
    create_table :pessoas do |t|
      t.string :nome
      t.string :email
      t.string :status
      t.string :cpf
      t.string :cep
      t.string :endereco
      t.string :numero
      t.string :bairro
      t.string :cidade
      t.string :uf

      t.timestamps
    end
  end
end
