json.set! :data do
  json.array! @competicao_avalicaos do |competicao_avalicao|
    json.partial! 'competicao_avalicaos/competicao_avalicao', competicao_avalicao: competicao_avalicao
    json.url  "
              #{link_to 'Show', competicao_avalicao }
              #{link_to 'Edit', edit_competicao_avalicao_path(competicao_avalicao)}
              #{link_to 'Destroy', competicao_avalicao, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end