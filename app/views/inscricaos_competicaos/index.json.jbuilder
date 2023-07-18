json.set! :data do
  json.array! @inscricaos_competicaos do |inscricaos_competicao|
    json.partial! 'inscricaos_competicaos/inscricaos_competicao', inscricaos_competicao: inscricaos_competicao
    json.url  "
              #{link_to 'Show', inscricaos_competicao }
              #{link_to 'Edit', edit_inscricaos_competicao_path(inscricaos_competicao)}
              #{link_to 'Destroy', inscricaos_competicao, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end