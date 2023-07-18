class TipoParametro < EnumerateIt::Base
  associate_values(
    :comp,
    :tabela,
    :melhor_indicacao,
    :tipo_marcha
  )
end
