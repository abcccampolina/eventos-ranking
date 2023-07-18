json.extract! inscricao, :id, :srg_animal_id, :criador_id, :expositor_id, :nome, :cpf, :email, 
                         :fazenda, :cidade, :uf :status, :created_at, :updated_at
json.url inscricao_url(inscricao, format: :json)
