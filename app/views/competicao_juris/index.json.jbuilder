json.set! :data do
  json.array! @competicao_juris do |competicao_juri|
    json.partial! 'competicao_juris/competicao_juri', competicao_juri: competicao_juri
    json.url  "
              #{link_to 'Show', competicao_juri }
              #{link_to 'Edit', edit_competicao_juri_path(competicao_juri)}
              #{link_to 'Destroy', competicao_juri, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end