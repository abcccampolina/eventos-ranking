class CompeticaosEvento < ApplicationRecord
  belongs_to :competicao
  belongs_to :evento

  has_many :criterios_competicaos, through: :competicao
  has_many :criterios_avaliacaos, through: :criterios_competicaos
  has_many :cluster_criterios_avaliacaos, through: :criterios_avaliacaos
  


  has_many :catalogos, dependent: :destroy
  has_many :catalogo_nomes, dependent: :destroy
  has_many :competicao_desempates, dependent: :destroy
  has_many :competicao_juris, dependent: :destroy
  has_many :inscricaos_competicaos, dependent: :destroy
  has_many :catalogo_competicaos, dependent: :destroy

  accepts_nested_attributes_for :competicao
  accepts_nested_attributes_for :catalogo_nomes
  accepts_nested_attributes_for :competicao_juris  
  
  audited
end