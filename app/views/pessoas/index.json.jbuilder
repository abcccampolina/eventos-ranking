json.set! :data do
  json.array! @pessoas do |pessoa|
    json.partial! 'pessoas/pessoa', pessoa: pessoa
    json.url  "
              #{link_to 'Show', pessoa }
              #{link_to 'Edit', edit_pessoa_path(pessoa)}
              #{link_to 'Destroy', pessoa, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end