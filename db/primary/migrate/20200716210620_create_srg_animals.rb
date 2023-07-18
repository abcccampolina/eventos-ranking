class CreateSrgAnimals < ActiveRecord::Migration[6.0]
  def change
    create_table :srg_animals do |t|
      t.string :nome
      t.string :nome_completo
      t.string :numero_chip
      t.string :sexo
      t.string :pai
      t.string :mae
      t.date :data_nascimento
      t.string :fazenda_nascimento
      t.string :cidade_nascimento
      t.string :uf_nascimento
      t.string :criador
      t.string :proprietario
      t.string :pelagem_padrao
      t.string :pelagem
      t.string :dna_tipo
      t.date :dna_data_exame
      t.string :dna_laboratorio
      t.string :homozigose_tipo
      t.date :homozigose_data_exame
      t.string :homozigose_laboratorio
      t.string :dna_exposicao_nome
      t.date :dna_exposicao_ano
      t.string :clone
      t.date :data_clone
      t.string :laboratorio_clone
      t.string :animal_origem
      t.date :data_castracao
      t.date :data_baixa
      t.string :motivo_baixa
      t.string :status
      t.date :data_desbloqueio
      t.string :observacoes

      t.timestamps
    end
  end
end
