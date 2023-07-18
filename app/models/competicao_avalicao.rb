class CompeticaoAvalicao < ApplicationRecord
  belongs_to :competicao_juri
  belongs_to :criterios_competicao
  belongs_to :inscricao
  belongs_to :catalogo
  belongs_to :evento

  audited

  attr_accessor :competicao_id

  has_enumeration_for :ocorrencia, with: OcorrenciaCompeticao, create_helpers: true
end
