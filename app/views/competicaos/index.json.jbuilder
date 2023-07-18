json.set! :data do
  json.array! @competicaos do |competicao|
    json.partial! 'competicaos/competicao', competicao: competicao
    json.url  "
              #{link_to 'Show', competicao }
              #{link_to 'Edit', edit_competicao_path(competicao)}
              #{link_to 'Destroy', competicao, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end