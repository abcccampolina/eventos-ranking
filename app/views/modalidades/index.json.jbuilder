json.set! :data do
  json.array! @modalidades do |modalidade|
    json.partial! 'modalidades/modalidade', modalidade: modalidade
    json.url  "
              #{link_to 'Show', modalidade }
              #{link_to 'Edit', edit_modalidade_path(modalidade)}
              #{link_to 'Destroy', modalidade, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end