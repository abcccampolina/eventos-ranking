class SrgAnimal < ApplicationRecord
    connects_to database: { writing: :sec, reading: :sec_replica }
    self.table_name = "srg_animal"
  
    belongs_to :animal_pai, class_name: "SrgAnimal", foreign_key: :pai, required: false
    belongs_to :animal_mae, class_name: "SrgAnimal", foreign_key: :mae, required: false
    belongs_to :animal_criador, class_name: "SrgPessoa", foreign_key: :criador, required: false
  
    def self.get_valid_columns_with_translations
      rejecteds = %W{mae pai status fazenda_nascimento cidade_nascimento data_castracao uf_nascimento id nome nome_completo numero_chip criador proprietario data_baixa motivo_baixa pelagem_padrao observacoes data_desbloqueio animal_origem laboratorio_clone data_clone clone dna_exposicao_ano dna_exposicao_nome homozigose_laboratorio homozigose_data_exame homozigose_tipo dna_laboratorio dna_data_exame dna_tipo data_nascimento}
      self.columns.map(&:name).reject { |i| rejecteds.include?(i) }.map { |i| [I18n.t("srg_animals.column.#{i}"), i] }
    end
end
