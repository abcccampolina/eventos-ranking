json.set! :data do
  json.array! @catalogo_nomes do |catalogo_nome|
    json.partial! 'catalogo_nomes/catalogo_nome', catalogo_nome: catalogo_nome
    json.url  "
              #{link_to 'Show', catalogo_nome }
              #{link_to 'Edit', edit_catalogo_nome_path(catalogo_nome)}
              #{link_to 'Destroy', catalogo_nome, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end