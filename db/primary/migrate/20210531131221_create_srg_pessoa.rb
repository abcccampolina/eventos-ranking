class CreateSrgPessoa < ActiveRecord::Migration[6.0]
  def change
    create_table :srg_pessoas do |t|
      t.string :nome
      t.string :codigo
      t.string :telefone
      t.string :celular
      t.string :email
      t.string :tipo_pessoa
      t.string :cpf
      t.string :cnpj
      t.string :rg
      t.string :cidade_nascimento
      t.string :contato
      t.integer :associado_endereco_fazenda
      t.string :associado_nome_fazenda
      t.string :associado_cidade_fazenda
      t.integer :associado_estado_fazenda
      t.string :status

      t.timestamps
    end
  end
end

