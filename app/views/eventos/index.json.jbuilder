json.set! :data do
  json.array! @eventos do |evento|
    json.partial! 'eventos/evento', evento: evento
    json.url  "
              #{link_to 'Show', evento }
              #{link_to 'Edit', edit_evento_path(evento)}
              #{link_to 'Destroy', evento, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end