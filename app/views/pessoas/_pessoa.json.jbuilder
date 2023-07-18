json.extract! pessoa, :id, :nome, :email, :status, :cpf, :cep, :endereco, :numero, :bairro, :cidade, :uf, :created_at, :updated_at
json.url pessoa_url(pessoa, format: :json)
