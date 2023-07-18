class OcorrenciaCompeticao < EnumerateIt::Base
  associate_values(
    :asterisco,
    :desclassificado,
    :nep,
    :ncp,
    :cla
  )
end
