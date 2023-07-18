json.extract! competicao, :id, :nome, :modalidade_id, :status, :created_at, :updated_at
json.url competicao_url(competicao, format: :json)
