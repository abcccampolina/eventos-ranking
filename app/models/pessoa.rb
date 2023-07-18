class Pessoa < ApplicationRecord
  has_many :criadores, :class_name => "Inscricao", :foreign_key => "criador_id"
  has_many :expositores, :class_name => "Inscricao", :foreign_key => "expositor_id"
end
