json.set! :data do
  json.array! @competicaos_eventos do |competicaos_evento|
    json.partial! 'competicaos_eventos/competicaos_evento', competicaos_evento: competicaos_evento
    json.url  "
              #{link_to 'Show', competicaos_evento }
              #{link_to 'Edit', edit_competicaos_evento_path(competicaos_evento)}
              #{link_to 'Destroy', competicaos_evento, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end