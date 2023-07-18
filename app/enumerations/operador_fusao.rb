class OperadorFusao < EnumerateIt::Base
  associate_values(
    :soma,
    :media
  )
end
