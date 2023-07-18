json.set! :data do
  json.array! @catalogos do |catalogo|
    json.partial! 'catalogos/catalogo', catalogo: catalogo
    json.url  "
              #{link_to 'Show', catalogo }
              #{link_to 'Edit', edit_catalogo_path(catalogo)}
              #{link_to 'Destroy', catalogo, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end