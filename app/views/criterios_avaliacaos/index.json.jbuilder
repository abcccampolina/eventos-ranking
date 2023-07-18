json.set! :data do
  json.array! @criterios_avaliacaos do |criterios_avaliacao|
    json.partial! 'criterios_avaliacaos/criterios_avaliacao', criterios_avaliacao: criterios_avaliacao
    json.url  "
              #{link_to 'Show', criterios_avaliacao }
              #{link_to 'Edit', edit_criterios_avaliacao_path(criterios_avaliacao)}
              #{link_to 'Destroy', criterios_avaliacao, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end