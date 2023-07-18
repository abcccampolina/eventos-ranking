class CriteriosAvaliacao < ApplicationRecord
  belongs_to :cluster_criterios_avaliacao
  has_many :criterios_competicaos
  # has_many :clusters

  audited
end
