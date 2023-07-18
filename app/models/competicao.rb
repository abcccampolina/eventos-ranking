class Competicao < ApplicationRecord
  belongs_to :modalidade
  has_many :criterios_competicaos
end
