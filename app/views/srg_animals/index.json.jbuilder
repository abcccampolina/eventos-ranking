json.array! @srg_animals do |srg_animal|
  json.id srg_animal.nome_completo
  json.nome_completo srg_animal.nome_completo
  json.nome_pai srg_animal.animal_pai&.nome_completo || "-"
  json.nome_mae srg_animal.animal_mae&.nome_completo || "-"
end
