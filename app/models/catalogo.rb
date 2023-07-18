class Catalogo < ApplicationRecord
  belongs_to :inscricao
  belongs_to :competicaos_evento

  has_many :competicao_avalicaos, dependent: :destroy
  has_many :dim_pdf_grande_campeaos, dependent: :destroy

  # has_many :criterios_competicaos
  has_many :criterios_competicaos, through: :competicaos_evento

  scope :include_and_group_sumula, -> do
    includes(criterios_competicaos: {criterios_avaliacao: :cluster_criterios_avaliacao})
    &.group_by {|c| c&.nome_catalogo&.parameterize }
  end

  scope :dev_limit, -> { Rails.env.development? ? limit(80) : self }
end
