class CompeticaoJuri < ApplicationRecord
  belongs_to :competicaos_evento
  belongs_to :user
  belongs_to :cluster_criterios_avaliacao, required: false
  

  attribute :juri_desempate, default: false
  has_many :competicao_avalicaos
end
