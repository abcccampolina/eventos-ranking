class CompeticaoDesempate < ApplicationRecord
  belongs_to :competicaos_evento
  belongs_to :inscricao
  belongs_to :competicao_juri
  belongs_to :criterios_competicao

end
