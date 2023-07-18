json.set! :data do
  json.array! @cluster_criterios_avaliacaos do |cluster_criterios_avaliacao|
    json.partial! 'cluster_criterios_avaliacaos/cluster_criterios_avaliacao', cluster_criterios_avaliacao: cluster_criterios_avaliacao
    json.url  "
              #{link_to 'Show', cluster_criterios_avaliacao }
              #{link_to 'Edit', edit_cluster_criterios_avaliacao_path(cluster_criterios_avaliacao)}
              #{link_to 'Destroy', cluster_criterios_avaliacao, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end