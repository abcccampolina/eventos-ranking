class InscricaosCompeticao < ApplicationRecord
  belongs_to :inscricao
  belongs_to :competicao

  has_many :premios, dependent: :destroy

  attribute :campeao_anterior_json, :json, default: {}

  # has_many :memberships, dependent: :destroy
end
