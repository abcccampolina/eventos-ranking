json.set! :data do
  json.array! @parametro_inscricaos do |parametro_inscricao|
    json.partial! 'parametro_inscricaos/parametro_inscricao', parametro_inscricao: parametro_inscricao
    json.url  "
              #{link_to 'Show', parametro_inscricao }
              #{link_to 'Edit', edit_parametro_inscricao_path(parametro_inscricao)}
              #{link_to 'Destroy', parametro_inscricao, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end