class Inscricao < ApplicationRecord
  include ApplicationHelper
  belongs_to :srg_animal
  belongs_to :evento
  belongs_to :criador, :class_name => "Pessoa"
  belongs_to :expositor, :class_name => "Pessoa"
  has_many :competicao_avaliacaos, class_name: "CompeticaoAvalicao",  dependent: :destroy
  # has_and_belongs_to_many :competicaos, dependent: :destroy, join_table: :inscricaos_competicaos
  has_many :catalogos, dependent: :destroy 
  has_many :premios, dependent: :destroy
  has_many :inscricaos_competicaos, dependent: :destroy# , through: :inscricaos_competicaos

  before_validation on: [:create] do
    etaria, etaria_dia = distance_months_and_days(self.srg_animal&.data_nascimento, self.evento&.data_avaliacao)
    self.faixa_etaria = etaria
    self.faixa_etaria_dia = etaria_dia
    self.srg_nome_animal = self.srg_animal&.nome_completo
    self.ano_hipico = self.evento.anoHipico
  end

  attr_accessor :nome_pessoa

  def nome_pessoa
    expositor.nome
  end
end
