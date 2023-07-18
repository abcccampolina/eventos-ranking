json.set! :data do
  json.array! @catalogo_competicaos do |catalogo_competicao|
    json.partial! 'catalogo_competicaos/catalogo_competicao', catalogo_competicao: catalogo_competicao
    json.url  "
              #{link_to 'Show', catalogo_competicao }
              #{link_to 'Edit', edit_catalogo_competicao_path(catalogo_competicao)}
              #{link_to 'Destroy', catalogo_competicao, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end