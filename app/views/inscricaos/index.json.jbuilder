json.set! :data do
  json.array! @inscricaos do |inscricao|
    json.partial! 'inscricaos/inscricao', inscricao: inscricao
    json.url  "
              #{link_to 'Show', inscricao }
              #{link_to 'Edit', edit_inscricao_path(inscricao)}
              #{link_to 'Destroy', inscricao, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end