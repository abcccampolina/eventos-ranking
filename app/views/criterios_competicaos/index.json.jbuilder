json.set! :data do
  json.array! @criterios_competicaos do |criterios_competicao|
    json.partial! 'criterios_competicaos/criterios_competicao', criterios_competicao: criterios_competicao
    json.url  "
              #{link_to 'Show', criterios_competicao }
              #{link_to 'Edit', edit_criterios_competicao_path(criterios_competicao)}
              #{link_to 'Destroy', criterios_competicao, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end