class CriteriosCompeticao < ApplicationRecord
  belongs_to :competicao
  belongs_to :criterios_avaliacao

  scope :criterio_sem_prova_funcional, -> do
    joins(criterios_avaliacao: :cluster_criterios_avaliacao)
    .where(
      ClusterCriteriosAvaliacao.arel_table[:nome].not_eq('Prova Funcional')
    )
  end
  audited
end
