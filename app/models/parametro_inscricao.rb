class ParametroInscricao < ApplicationRecord
  belongs_to :competicao
  belongs_to :fusao_competicao_antecessora, class_name: "Competicao", required: false
  #belongs_to :competicao_antecessora, :class_name => "Competicao"
  audited
  
  # Enum de com_or_table, caso de uso:
  #   @operador_fusao.comp?              #= true or false
  #   @operador_fusao.tabela?            #= true or false
  #   @operador_fusao.melhor_indicacao?  #= true or false
  #   @operador_fusao.tipo_marcha?       #= true or false
  has_enumeration_for :comp_or_table, with: TipoParametro, create_helpers: true

  # Enum de operador de fusão, caso de uso:
  #   @operador_fusao.operador_fusao_media? #= true or false
  #   @operador_fusao.operador_fusao_soma?  #= true or false
  has_enumeration_for :operador_fusao, with: OperadorFusao, create_helpers: { prefix: true }
  
end
