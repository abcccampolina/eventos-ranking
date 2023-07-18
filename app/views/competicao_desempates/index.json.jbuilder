json.set! :data do
  json.array! @competicao_desempates do |competicao_desempate|
    json.partial! 'competicao_desempates/competicao_desempate', competicao_desempate: competicao_desempate
    json.url  "
              #{link_to 'Show', competicao_desempate }
              #{link_to 'Edit', edit_competicao_desempate_path(competicao_desempate)}
              #{link_to 'Destroy', competicao_desempate, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end