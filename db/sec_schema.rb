# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "View_Associados_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "AgendaID", limit: 1, null: false
    t.integer "Codigo", limit: 1, null: false
    t.integer "Nome", limit: 1, null: false
    t.integer "NomeFazenda", limit: 1, null: false
    t.integer "CidadeFazenda", limit: 1, null: false
    t.integer "Sigla", limit: 1, null: false
    t.integer "EnderecoCompleto", limit: 1, null: false
    t.integer "DataCadastro", limit: 1, null: false
    t.integer "DataInscricao", limit: 1, null: false
    t.integer "StatusAssociado", limit: 1, null: false
    t.integer "StatusAssociadoID", limit: 1, null: false
    t.integer "Email", limit: 1, null: false
    t.integer "EmDebido", limit: 1, null: false
    t.integer "LiberadoDebito", limit: 1, null: false
    t.integer "IsCondominio", limit: 1, null: false
    t.integer "TipoPessoa", limit: 1, null: false
  end

  create_table "attachments", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "key", limit: 256, null: false
    t.string "name", limit: 256
    t.string "type", limit: 100
    t.bigint "object_id", unsigned: true
    t.string "object_type", limit: 100
  end

  create_table "aux_animal_especie", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.string "nome", null: false, collation: "utf8_general_ci"
    t.string "nome_cientifico", collation: "utf8_general_ci"
  end

  create_table "aux_animal_raca", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "especie", null: false, unsigned: true
    t.string "nome", null: false, collation: "utf8_general_ci"
  end

  create_table "aux_attachment_types", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "key", limit: 100, null: false
    t.string "name", limit: 100, default: "", null: false
    t.index ["key"], name: "key", unique: true
  end

  create_table "aux_escolaridade", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "descricao", collation: "utf8_general_ci"
  end

  create_table "aux_estado", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nome", collation: "utf8_general_ci"
    t.string "sigla", collation: "utf8_general_ci"
    t.string "pais", collation: "utf8_general_ci"
  end

  create_table "aux_pelagem", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nome", null: false, collation: "utf8_general_ci"
    t.column "status", "enum('ativo','inativo')", collation: "utf8_general_ci"
  end

  create_table "aux_perfil_pessoa", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.column "perfil", "enum('associado','credenciado','fornecedor','funcionario')", null: false, collation: "utf8_general_ci"
    t.string "categoria", null: false, collation: "utf8_general_ci"
    t.column "manual", "enum('nao','sim')", collation: "utf8_general_ci"
    t.column "acesso_sistema", "enum('nao','sim')", collation: "utf8_general_ci"
  end

  create_table "aux_profissao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "descricao", collation: "utf8_general_ci"
  end

  create_table "aux_status_comunicacao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nome", null: false, collation: "utf8_general_ci"
  end

  create_table "bkp_srg_pessoa_perfil", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "id", default: 0, null: false, unsigned: true
    t.bigint "pessoa_id", null: false, unsigned: true
    t.bigint "perfil_id", null: false, unsigned: true
  end

  create_table "com_comunicacao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "numero_comunicacao", limit: 10, collation: "utf8_general_ci"
    t.bigint "protocolo", null: false, unsigned: true
    t.bigint "tipo_comunicacao", null: false, unsigned: true
    t.bigint "status_comunicacao", default: 1, null: false, unsigned: true
    t.datetime "data_aprovacao"
    t.datetime "data_pagamento"
    t.datetime "data_conclusao"
    t.bigint "diversos_conteudo", unsigned: true
    t.datetime "data_cancelamento"
    t.bigint "status_cancelamento"
    t.column "verificado", "enum('S','N')", default: "N", collation: "utf8_general_ci"
    t.datetime "data_verificacao"
    t.bigint "usuario_verificacao", unsigned: true
    t.index ["diversos_conteudo"], name: "diversos_conteudo"
    t.index ["protocolo"], name: "protocolo"
    t.index ["status_comunicacao"], name: "status_comunicacao"
    t.index ["tipo_comunicacao"], name: "tipo_comunicacao"
    t.index ["usuario_verificacao"], name: "usuario_verificacao"
  end

  create_table "com_comunicacao_alteracao_categoria", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "pessoa", unsigned: true
    t.integer "categoria_atual", unsigned: true
    t.integer "nova_categoria", unsigned: true
    t.index ["pessoa"], name: "com_comunicacao_alteracao_categoria_ibfk_2"
  end

  create_table "com_comunicacao_alteracao_dados_cadastrais", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "pessoa", unsigned: true
    t.date "data_nascimento"
    t.column "tipo_endereco", "enum('outro','fazenda','comercial','residencial')", collation: "utf8_general_ci"
    t.column "endereco_correspondencia", "enum('N','S')", collation: "utf8_general_ci"
    t.string "endereco", collation: "utf8_general_ci"
    t.string "complemento", collation: "utf8_general_ci"
    t.string "bairro", collation: "utf8_general_ci"
    t.string "cep", collation: "utf8_general_ci"
    t.string "cidade", collation: "utf8_general_ci"
    t.bigint "estado", unsigned: true
    t.string "telefone", collation: "utf8_general_ci"
    t.string "celular", collation: "utf8_general_ci"
    t.string "fax", collation: "utf8_general_ci"
    t.string "email", collation: "utf8_general_ci"
    t.string "senha", collation: "utf8_general_ci"
    t.text "observacoes", collation: "utf8_general_ci"
    t.column "tipo_pessoa", "enum('pf','pj')", collation: "utf8_general_ci"
    t.string "cpf", collation: "utf8_general_ci"
    t.string "rg", collation: "utf8_general_ci"
    t.string "cidade_nascimento", collation: "utf8_general_ci"
    t.string "conjuge_nome", collation: "utf8_general_ci"
    t.bigint "escolaridade", unsigned: true
    t.bigint "profissao", unsigned: true
    t.string "cnpj", collation: "utf8_general_ci"
    t.string "contato", collation: "utf8_general_ci"
    t.string "inscricao_estadual", collation: "utf8_general_ci"
    t.string "inscricao_municipal", collation: "utf8_general_ci"
    t.column "associado_tipo_afixo", "enum('prefixo','sufixo')", collation: "utf8_general_ci"
    t.string "associado_afixo", collation: "utf8_general_ci"
    t.string "associado_preposicao", collation: "utf8_general_ci"
    t.string "associado_nome_fazenda", collation: "utf8_general_ci"
    t.string "associado_cidade_fazenda", collation: "utf8_general_ci"
    t.bigint "associado_estado_fazenda", unsigned: true
    t.string "associado_numero_inscricao_produtor_rural", collation: "utf8_general_ci"
    t.string "credenciado_crea", collation: "utf8_general_ci"
    t.string "credenciado_crmv", collation: "utf8_general_ci"
    t.string "credenciado_area_atuacao", collation: "utf8_general_ci"
    t.index ["associado_estado_fazenda"], name: "associado_estado_fazenda"
    t.index ["estado"], name: "estado"
    t.index ["pessoa"], name: "pessoa"
  end

  create_table "com_comunicacao_animal", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "comunicacao_id", null: false, unsigned: true
    t.bigint "animal_id", null: false, unsigned: true
    t.index ["animal_id"], name: "animal_id"
    t.index ["comunicacao_id"], name: "comunicacao_id"
  end

  create_table "com_comunicacao_animal_nome", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "comunicacao_id", null: false, unsigned: true
    t.string "animais_nomes", collation: "utf8_general_ci"
    t.index ["comunicacao_id"], name: "comunicacao_id"
  end

  create_table "com_comunicacao_aprovacao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "comunicacao_id", null: false, unsigned: true
    t.bigint "remetente_id", null: false, unsigned: true
    t.bigint "aprovador_id", null: false, unsigned: true
    t.bigint "pendencia_id", null: false, unsigned: true
    t.column "tipo_aprovacao", "enum('veterinario_responsavel','proprietario_matriz_doadora','proprietario_reprodutor','proprietario_pai','proprietario_mae','proprietario_produto','tecnico_responsavel','comprador','vendedor','proprietario_animal','proprietario_matrizes')", null: false, collation: "utf8_general_ci"
    t.datetime "datahora_aprovacao"
    t.datetime "datahora_envio_email"
    t.string "ip_aprovacao", collation: "utf8_general_ci"
    t.column "status", "enum('aprovado','aguardando_aprovacao','email_nao_enviado','erro_no_envio')", null: false, collation: "utf8_general_ci"
    t.text "erro_detalhes", collation: "utf8_general_ci"
    t.index ["comunicacao_id"], name: "comunicacao_id"
  end

  create_table "com_comunicacao_baixa", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
  end

  create_table "com_comunicacao_baixa_animal", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "com_comunicacao_baixa_id", null: false, unsigned: true
    t.bigint "animal_id", null: false, unsigned: true
    t.date "data_baixa"
    t.text "descricao", collation: "utf8_general_ci"
    t.index ["animal_id"], name: "animal_id"
    t.index ["com_comunicacao_baixa_id"], name: "com_comunicacao_baixa_id"
  end

  create_table "com_comunicacao_baixa_cadastral", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "pessoa", unsigned: true
    t.column "motivo", "enum('jubilado','morte','nao_possui_animais','outros')", collation: "utf8_general_ci"
    t.text "descricao", collation: "utf8_general_ci"
    t.index ["pessoa"], name: "pessoa"
  end

  create_table "com_comunicacao_castracao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "animal", unsigned: true
    t.integer "numero_registro", unsigned: true
    t.bigint "livro", unsigned: true
    t.integer "livro_volume", unsigned: true
    t.integer "livro_pagina", unsigned: true
    t.date "data_castracao"
    t.date "data_recebimento_laudo"
    t.bigint "tecnico_responsavel", unsigned: true
    t.index ["animal"], name: "animal"
    t.index ["livro"], name: "livro"
    t.index ["tecnico_responsavel"], name: "tecnico_responsavel"
  end

  create_table "com_comunicacao_censo", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "ano", unsigned: true
    t.integer "quantidade_vivos", default: 0, null: false, unsigned: true
    t.integer "quantidade_mortos", default: 0, null: false, unsigned: true
    t.integer "quantidade_leilao_vendido", default: 0, null: false, unsigned: true
    t.integer "quantidade_inativos", default: 0, null: false, unsigned: true
  end

  create_table "com_comunicacao_clone", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "animal_origem", unsigned: true
    t.bigint "animal", unsigned: true
    t.bigint "proprietario_produto", unsigned: true
    t.string "nome", collation: "utf8_general_ci"
    t.date "data_nascimento"
    t.date "data_clone"
    t.bigint "laboratorio", unsigned: true
    t.bigint "livro", unsigned: true
    t.integer "livro_pagina", unsigned: true
    t.integer "livro_volume", unsigned: true
    t.integer "numero_registro", unsigned: true
    t.index ["animal"], name: "com_comunicacao_clone_ibfk_3"
    t.index ["animal_origem"], name: "animal_origem"
    t.index ["laboratorio"], name: "laboratorio"
    t.index ["proprietario_produto"], name: "com_comunicacao_clone_ibfk_4"
  end

  create_table "com_comunicacao_cobricao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "reprodutor", unsigned: true
    t.index ["reprodutor"], name: "reprodutor"
  end

  create_table "com_comunicacao_cobricao_matriz", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "com_comunicacao_cobricao_id", null: false, unsigned: true
    t.bigint "matriz_id", null: false, unsigned: true
    t.date "data_cobricao"
    t.column "tipo_monta", "enum('inseminacao_artificial','monta_natural')", collation: "utf8_general_ci"
    t.index ["com_comunicacao_cobricao_id"], name: "com_comunicacao_cobricao_id"
    t.index ["matriz_id"], name: "matriz_id"
  end

  create_table "com_comunicacao_credenciamento", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "pessoa", unsigned: true
    t.date "data_nascimento"
    t.column "tipo_endereco", "enum('outro','fazenda','comercial','residencial')", collation: "utf8_general_ci"
    t.column "endereco_correspondencia", "enum('N','S')", collation: "utf8_general_ci"
    t.string "endereco", collation: "utf8_general_ci"
    t.string "complemento", collation: "utf8_general_ci"
    t.string "bairro", collation: "utf8_general_ci"
    t.string "cep", collation: "utf8_general_ci"
    t.string "cidade", collation: "utf8_general_ci"
    t.bigint "estado", unsigned: true
    t.string "telefone", collation: "utf8_general_ci"
    t.string "celular", collation: "utf8_general_ci"
    t.string "fax", collation: "utf8_general_ci"
    t.string "email", collation: "utf8_general_ci"
    t.text "observacoes", collation: "utf8_general_ci"
    t.column "tipo_pessoa", "enum('pf','pj')", collation: "utf8_general_ci"
    t.string "cpf", collation: "utf8_general_ci"
    t.string "rg", collation: "utf8_general_ci"
    t.string "cidade_nascimento", collation: "utf8_general_ci"
    t.string "conjuge_nome", collation: "utf8_general_ci"
    t.bigint "escolaridade", unsigned: true
    t.bigint "profissao", unsigned: true
    t.string "cnpj", collation: "utf8_general_ci"
    t.string "contato", collation: "utf8_general_ci"
    t.string "inscricao_estadual", collation: "utf8_general_ci"
    t.string "inscricao_municipal", collation: "utf8_general_ci"
    t.string "credenciado_crmv", collation: "utf8_general_ci"
    t.string "credenciado_crea", collation: "utf8_general_ci"
    t.string "credenciado_area_atuacao", collation: "utf8_general_ci"
    t.bigint "credenciado_tipo", unsigned: true
    t.index ["credenciado_tipo"], name: "credenciado_tipo"
    t.index ["escolaridade"], name: "escolaridade"
    t.index ["estado"], name: "estado"
    t.index ["pessoa"], name: "pessoa"
    t.index ["profissao"], name: "profissao"
  end

  create_table "com_comunicacao_desbloqueio_matriz", id: :bigint, unsigned: true, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "tecnico_responsavel", unsigned: true
    t.bigint "matriz", unsigned: true
    t.index ["matriz"], name: "matriz"
  end

  create_table "com_comunicacao_descredenciamento", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "pessoa", unsigned: true
    t.bigint "tipo", unsigned: true
    t.column "motivo", "enum('tempo_inatividade','solicitacao_propria','outros')", collation: "utf8_general_ci"
    t.text "descricao", collation: "utf8_general_ci"
    t.index ["pessoa"], name: "pessoa"
  end

  create_table "com_comunicacao_diversos", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "animal", unsigned: true
    t.text "descricao", collation: "utf8_general_ci"
    t.index ["animal"], name: "animal"
  end

  create_table "com_comunicacao_exame_dna", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "animal", unsigned: true
    t.bigint "pai", unsigned: true
    t.bigint "mae", unsigned: true
    t.bigint "responsavel_coleta", unsigned: true
    t.date "dna_data_coleta"
    t.column "tipo_exame", "enum('dna','homozigose','exposicao')"
    t.column "dna_tipo", "enum('ap','vp','rp')", collation: "utf8_general_ci"
    t.column "homozigose_tipo", "enum('homozigoto_tobiano','heterozigoto','homozigoto_normal')"
    t.string "exposicao_nome"
    t.integer "exposicao_ano", unsigned: true
    t.date "dna_data_envio_laboratorio"
    t.column "dna_resultado", "enum('sem_resultado','nao_qualificado','pai_pendente','mae_pendente','qualificado')", collation: "utf8_general_ci"
    t.date "dna_data_exame"
    t.bigint "dna_laboratorio", unsigned: true
    t.text "observacoes", collation: "utf8_general_ci"
    t.index ["animal"], name: "animal"
    t.index ["dna_laboratorio"], name: "dna_laboratorio"
    t.index ["mae"], name: "mae"
    t.index ["pai"], name: "pai"
    t.index ["responsavel_coleta"], name: "com_comunicacao_exame_dna_ibfk_6"
  end

  create_table "com_comunicacao_inspecao_previa", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "animal", unsigned: true
    t.bigint "tecnico_responsavel", unsigned: true
    t.date "data_mensuracao"
    t.string "pontos", collation: "utf8_general_ci"
    t.bigint "pelagem_padrao", unsigned: true
    t.string "pelagem", collation: "utf8_general_ci"
    t.string "cabeca", collation: "utf8_general_ci"
    t.string "membro_anterior_esquerdo", collation: "utf8_general_ci"
    t.string "membro_anterior_direito", collation: "utf8_general_ci"
    t.string "membro_posterior_esquerdo", collation: "utf8_general_ci"
    t.string "membro_posterior_direito", collation: "utf8_general_ci"
    t.string "sinais", collation: "utf8_general_ci"
    t.text "observacoes", collation: "utf8_general_ci"
    t.decimal "altura_cernelha", precision: 4, scale: 2, unsigned: true
    t.decimal "altura_dorso", precision: 4, scale: 2, unsigned: true
    t.decimal "altura_garupa", precision: 4, scale: 2, unsigned: true
    t.decimal "altura_costados", precision: 4, scale: 2, unsigned: true
    t.decimal "largura_cabeca", precision: 4, scale: 2, unsigned: true
    t.decimal "largura_peito", precision: 4, scale: 2, unsigned: true
    t.decimal "largura_anca", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_cabeca", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_pescoco", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_dorso_lombo", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_garupa", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_espadua", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_corpo", precision: 4, scale: 2, unsigned: true
    t.decimal "perimetro_torax", precision: 4, scale: 2, unsigned: true
    t.decimal "perimetro_canela", precision: 4, scale: 2, unsigned: true
    t.decimal "pontuacao_altura", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_temperamento", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_qualidade", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_proporcoes", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_forma", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_orelhas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_fronte", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_ganachas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_olhos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_narinas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_boca", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_perfil", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_borda_superior", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_borda_inferior", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_ligacao", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_insercao", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_dimensoes", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_cernelha", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_peito", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_costelas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_dorso", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_lombo", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_flancos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_ventre", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_ancas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_garupa", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_cauda", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_espaduas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_bracos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_antebracos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_joelhos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_coxas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_pernas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_jarretes", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_canelas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_boletos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_quartelas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_cascos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_comodidade", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_estilo", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_regularidade", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_desenvolvimento", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_dissociacao", precision: 6, scale: 2, unsigned: true
    t.decimal "total_pontuacao", precision: 6, scale: 2, unsigned: true
    t.index ["animal"], name: "animal"
    t.index ["pelagem_padrao"], name: "pelagem_padrao"
    t.index ["tecnico_responsavel"], name: "tecnico_responsavel"
  end

  create_table "com_comunicacao_nascimento", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "animal", unsigned: true
    t.bigint "proprietario_produto", unsigned: true
    t.column "controlado_ao_pe", "enum('sim','nao')", collation: "utf8_general_ci"
    t.bigint "tecnico_responsavel", unsigned: true
    t.string "nome_opcao_1", collation: "utf8_general_ci"
    t.string "nome_opcao_2", collation: "utf8_general_ci"
    t.string "nome_opcao_3", collation: "utf8_general_ci"
    t.string "nome", collation: "utf8_general_ci"
    t.string "nome_completo", collation: "utf8_general_ci"
    t.string "numero_chip", collation: "utf8_general_ci"
    t.column "sexo", "enum('femea','macho')", collation: "utf8_general_ci"
    t.date "data_nascimento"
    t.string "fazenda_nascimento", collation: "utf8_general_ci"
    t.string "cidade_nascimento", collation: "utf8_general_ci"
    t.bigint "uf_nascimento", unsigned: true
    t.bigint "pai", unsigned: true
    t.bigint "mae", unsigned: true
    t.bigint "livro", unsigned: true
    t.integer "livro_volume", unsigned: true
    t.integer "livro_pagina", unsigned: true
    t.integer "numero_registro", unsigned: true
    t.bigint "com_comunicacao_origem_id", unsigned: true
    t.bigint "receptora_id", unsigned: true
    t.bigint "pelagem_padrao", unsigned: true
    t.string "pelagem", collation: "utf8_general_ci"
    t.string "cabeca", collation: "utf8_general_ci"
    t.string "membro_anterior_esquerdo", collation: "utf8_general_ci"
    t.string "membro_anterior_direito", collation: "utf8_general_ci"
    t.string "membro_posterior_esquerdo", collation: "utf8_general_ci"
    t.string "membro_posterior_direito", collation: "utf8_general_ci"
    t.string "sinais", collation: "utf8_general_ci"
    t.text "observacoes", collation: "utf8_general_ci"
    t.index ["animal"], name: "animal"
    t.index ["com_comunicacao_origem_id"], name: "com_comunicacao_origem_id"
    t.index ["livro"], name: "livro"
    t.index ["mae"], name: "mae"
    t.index ["pai"], name: "pai"
    t.index ["pelagem_padrao"], name: "pelagem_padrao"
    t.index ["uf_nascimento"], name: "uf_nascimento"
  end

  create_table "com_comunicacao_pessoa", primary_key: ["comunicacao_id", "pessoa_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "comunicacao_id", null: false, unsigned: true
    t.bigint "pessoa_id", null: false, unsigned: true
    t.index ["comunicacao_id"], name: "idx_comunicacao_id"
    t.index ["pessoa_id"], name: "idx_pessoa_id"
  end

  create_table "com_comunicacao_proposta_admissao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "pessoa", unsigned: true
    t.date "data_nascimento"
    t.bigint "pessoa_endereco_1", unsigned: true
    t.bigint "pessoa_endereco_2", unsigned: true
    t.column "tipo_endereco_1", "enum('outro','fazenda','comercial','residencial')", collation: "utf8_general_ci"
    t.column "endereco_correspondencia", "enum('1','2')", collation: "utf8_general_ci"
    t.string "endereco_1", collation: "utf8_general_ci"
    t.string "complemento_1", collation: "utf8_general_ci"
    t.string "bairro_1", collation: "utf8_general_ci"
    t.string "cep_1", collation: "utf8_general_ci"
    t.string "cidade_1", collation: "utf8_general_ci"
    t.bigint "estado_1", unsigned: true
    t.column "tipo_endereco_2", "enum('outro','fazenda','comercial','residencial')", collation: "utf8_general_ci"
    t.string "endereco_2", collation: "utf8_general_ci"
    t.string "complemento_2", collation: "utf8_general_ci"
    t.string "bairro_2", collation: "utf8_general_ci"
    t.string "cep_2", collation: "utf8_general_ci"
    t.string "cidade_2", collation: "utf8_general_ci"
    t.bigint "estado_2", unsigned: true
    t.string "telefone", collation: "utf8_general_ci"
    t.string "celular", collation: "utf8_general_ci"
    t.string "fax", collation: "utf8_general_ci"
    t.string "email", collation: "utf8_general_ci"
    t.string "indicacao_de", collation: "utf8_general_ci"
    t.text "observacoes", collation: "utf8_general_ci"
    t.column "tipo_pessoa", "enum('pf','pj')", collation: "utf8_general_ci"
    t.string "cpf", collation: "utf8_general_ci"
    t.string "rg", collation: "utf8_general_ci"
    t.string "cidade_nascimento", collation: "utf8_general_ci"
    t.string "conjuge_nome", collation: "utf8_general_ci"
    t.bigint "escolaridade", unsigned: true
    t.bigint "profissao", unsigned: true
    t.string "cnpj", collation: "utf8_general_ci"
    t.string "contato", collation: "utf8_general_ci"
    t.string "inscricao_estadual", collation: "utf8_general_ci"
    t.string "inscricao_municipal", collation: "utf8_general_ci"
    t.bigint "perfil", unsigned: true
    t.column "associado_tipo_afixo", "enum('prefixo','sufixo')", collation: "utf8_general_ci"
    t.string "associado_afixo", collation: "utf8_general_ci"
    t.string "associado_preposicao", collation: "utf8_general_ci"
    t.string "associado_nome_fazenda", collation: "utf8_general_ci"
    t.string "associado_cidade_fazenda", collation: "utf8_general_ci"
    t.bigint "associado_estado_fazenda", unsigned: true
    t.string "associado_numero_inscricao_produtor_rural", collation: "utf8_general_ci"
    t.index ["associado_estado_fazenda"], name: "associado_estado_fazenda"
    t.index ["estado_1"], name: "estado_1"
    t.index ["estado_2"], name: "estado_2"
    t.index ["perfil"], name: "perfil"
    t.index ["pessoa"], name: "pessoa"
    t.index ["pessoa_endereco_1"], name: "pessoa_endereco_1"
    t.index ["pessoa_endereco_2"], name: "pessoa_endereco_2"
  end

  create_table "com_comunicacao_reativacao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "animal", unsigned: true
    t.bigint "inspetor_responsavel", unsigned: true
    t.date "data_inspecao"
    t.date "data_reativacao"
    t.text "motivo", collation: "utf8_general_ci"
    t.index ["animal"], name: "animal"
    t.index ["inspetor_responsavel"], name: "inspetor_responsavel"
  end

  create_table "com_comunicacao_registro_definitivo", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "animal", unsigned: true
    t.bigint "tecnico_responsavel", unsigned: true
    t.date "data_mensuracao"
    t.string "numero_chip", collation: "utf8_general_ci"
    t.bigint "livro", unsigned: true
    t.integer "livro_pagina", unsigned: true
    t.integer "livro_volume", unsigned: true
    t.integer "numero_registro", unsigned: true
    t.column "castracao", "enum('sim','nao')", default: "nao", collation: "utf8_general_ci"
    t.bigint "pelagem_padrao", unsigned: true
    t.string "pelagem", collation: "utf8_general_ci"
    t.string "cabeca", collation: "utf8_general_ci"
    t.string "membro_anterior_esquerdo", collation: "utf8_general_ci"
    t.string "membro_anterior_direito", collation: "utf8_general_ci"
    t.string "membro_posterior_esquerdo", collation: "utf8_general_ci"
    t.string "membro_posterior_direito", collation: "utf8_general_ci"
    t.string "sinais", collation: "utf8_general_ci"
    t.text "observacoes", collation: "utf8_general_ci"
    t.decimal "altura_cernelha", precision: 4, scale: 2, unsigned: true
    t.decimal "altura_dorso", precision: 4, scale: 2, unsigned: true
    t.decimal "altura_garupa", precision: 4, scale: 2, unsigned: true
    t.decimal "altura_costados", precision: 4, scale: 2, unsigned: true
    t.decimal "largura_cabeca", precision: 4, scale: 2, unsigned: true
    t.decimal "largura_peito", precision: 4, scale: 2, unsigned: true
    t.decimal "largura_anca", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_cabeca", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_pescoco", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_dorso_lombo", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_garupa", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_espadua", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_corpo", precision: 4, scale: 2, unsigned: true
    t.decimal "perimetro_torax", precision: 4, scale: 2, unsigned: true
    t.decimal "perimetro_canela", precision: 4, scale: 2, unsigned: true
    t.decimal "pontuacao_altura", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_temperamento", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_qualidade", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_proporcoes", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_forma", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_orelhas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_fronte", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_ganachas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_olhos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_narinas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_boca", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_perfil", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_borda_superior", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_borda_inferior", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_ligacao", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_insercao", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_dimensoes", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_cernelha", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_peito", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_costelas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_dorso", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_lombo", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_flancos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_ventre", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_ancas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_garupa", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_cauda", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_espaduas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_bracos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_antebracos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_joelhos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_coxas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_pernas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_jarretes", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_canelas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_boletos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_quartelas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_cascos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_comodidade", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_estilo", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_regularidade", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_desenvolvimento", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_dissociacao", precision: 6, scale: 2, unsigned: true
    t.decimal "total_pontuacao", precision: 10, scale: 2, unsigned: true
    t.string "arcada_dentaria_compativel", limit: 10
    t.index ["animal"], name: "animal"
    t.index ["livro"], name: "livro"
    t.index ["pelagem_padrao"], name: "pelagem_padrao"
    t.index ["tecnico_responsavel"], name: "tecnico_responsavel"
  end

  create_table "com_comunicacao_retificacao_padreacao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "animal", unsigned: true
    t.bigint "pai", unsigned: true
    t.bigint "mae", unsigned: true
    t.index ["animal"], name: "animal"
    t.index ["mae"], name: "mae"
    t.index ["pai"], name: "pai"
  end

  create_table "com_comunicacao_retificacao_resenha", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "animal", unsigned: true
    t.bigint "inspetor_registro", unsigned: true
    t.bigint "pelagem_padrao", unsigned: true
    t.string "pelagem", collation: "utf8_general_ci"
    t.string "cabeca", collation: "utf8_general_ci"
    t.string "membro_anterior_esquerdo", collation: "utf8_general_ci"
    t.string "membro_anterior_direito", collation: "utf8_general_ci"
    t.string "membro_posterior_esquerdo", collation: "utf8_general_ci"
    t.string "membro_posterior_direito", collation: "utf8_general_ci"
    t.string "sinais", collation: "utf8_general_ci"
    t.text "observacoes", collation: "utf8_general_ci"
    t.index ["animal"], name: "animal"
    t.index ["inspetor_registro"], name: "com_comunicacao_retificacao_resenha_ibfk_4"
    t.index ["pelagem_padrao"], name: "pelagem_padrao"
  end

  create_table "com_comunicacao_segunda_via_registro", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "animal", unsigned: true
    t.column "tipo_registro", "enum('C','D','P')", collation: "utf8_general_ci"
    t.index ["animal"], name: "animal"
  end

  create_table "com_comunicacao_transferencia_embriao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "reprodutor", unsigned: true
    t.bigint "matriz_doadora", unsigned: true
    t.column "tipo_monta", "enum('inseminacao_artificial','monta_natural')", collation: "utf8_general_ci"
    t.date "data_inicial"
    t.date "data_final"
    t.bigint "proprietario_produto", unsigned: true
    t.bigint "veterinario_responsavel", unsigned: true
    t.index ["matriz_doadora"], name: "matriz_doadora"
    t.index ["proprietario_produto"], name: "proprietario_produto"
    t.index ["reprodutor"], name: "reprodutor"
    t.index ["veterinario_responsavel"], name: "veterinario_responsavel"
  end

  create_table "com_comunicacao_transferencia_embriao_matriz", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "com_comunicacao_transferencia_embriao_id", null: false, unsigned: true
    t.bigint "matriz_id", null: false, unsigned: true
    t.date "data_transferencia"
    t.index ["com_comunicacao_transferencia_embriao_id"], name: "com_comunicacao_transferencia_embriao_id"
    t.index ["matriz_id"], name: "matriz_id"
  end

  create_table "com_comunicacao_transferencia_propriedade", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "comprador", unsigned: true
    t.bigint "vendedor", unsigned: true
    t.column "tipo_transferencia", "enum('provisoria','definitiva')", default: "definitiva", collation: "utf8_general_ci"
    t.column "tipo_transacao", "enum('cessao','doacao','heranca','outros','troca','venda')", collation: "utf8_general_ci"
    t.date "data_transferencia"
    t.date "data_recebimento_documentos"
    t.date "data_vencimento_contrato"
    t.date "data_cancelamento_transferencia"
    t.text "motivo_cancelamento"
    t.index ["comprador"], name: "comprador"
    t.index ["vendedor"], name: "vendedor"
  end

  create_table "com_comunicacao_transferencia_propriedade_animal", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "com_comunicacao_transferencia_propriedade_id", null: false, unsigned: true
    t.bigint "animal_id", null: false, unsigned: true
    t.index ["animal_id"], name: "animal_id"
    t.index ["com_comunicacao_transferencia_propriedade_id"], name: "com_comunicacao_transferencia_propriedade_id"
  end

  create_table "com_pendencia", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.column "tipo", "enum('A','M')", default: "M", null: false, collation: "utf8_general_ci"
    t.string "descricao", null: false, collation: "utf8_general_ci"
    t.column "obrigatorio", "enum('N','S')", null: false, collation: "utf8_general_ci"
    t.bigint "tipo_comunicacao", unsigned: true
    t.bigint "status_comunicacao", unsigned: true
    t.index ["status_comunicacao"], name: "status_comunicacao"
    t.index ["tipo_comunicacao"], name: "tipo_comunicacao"
  end

  create_table "com_pendencia_comunicacao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "comunicacao", null: false, unsigned: true
    t.bigint "pendencia", unsigned: true
    t.bigint "animal_id", unsigned: true
    t.bigint "pessoa_id"
    t.string "pendencia_descricao", null: false, collation: "utf8_general_ci"
    t.column "pendencia_tipo", "enum('A','M')", default: "M", null: false, collation: "utf8_general_ci"
    t.column "pendencia_obrigatorio", "enum('N','S')", null: false, collation: "utf8_general_ci"
    t.bigint "status_comunicacao", unsigned: true
    t.datetime "data_cadastro", null: false
    t.column "status", "enum('nao_resolvida','resolvida','abonada')", default: "nao_resolvida", null: false, collation: "utf8_general_ci"
    t.datetime "data_resolucao"
    t.bigint "usuario_resolucao", unsigned: true
    t.datetime "data_abono"
    t.bigint "usuario_abono", unsigned: true
    t.text "motivo_abono", collation: "utf8_general_ci"
    t.index ["animal_id"], name: "animal_id"
    t.index ["comunicacao"], name: "comunicacao"
    t.index ["pendencia"], name: "pendencia"
    t.index ["pessoa_id"], name: "pessoa_id"
    t.index ["status_comunicacao"], name: "status_comunicacao"
    t.index ["usuario_resolucao"], name: "usuario_resolucao"
  end

  create_table "com_tipo_comunicacao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nome", null: false, collation: "utf8_general_ci"
    t.column "tipo", "enum('entrada','saida')", null: false, collation: "utf8_general_ci"
  end

  create_table "fin_anuidade", id: :integer, unsigned: true, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.integer "parcela", null: false, unsigned: true
    t.datetime "data_hora_inicio", null: false
    t.datetime "data_hora_alteracao"
    t.datetime "data_hora_fim"
    t.string "status", collation: "utf8_general_ci"
    t.string "andamento", collation: "utf8_general_ci"
    t.integer "qtde_criadores_pleno", default: 0, null: false, unsigned: true
    t.decimal "valor_criadores_pleno", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.integer "qtde_criadores_senior", default: 0, null: false
    t.decimal "valor_criadores_senior", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.integer "qtde_criadores_master", default: 0, null: false, unsigned: true
    t.decimal "valor_criadores_master", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.integer "qtde_criadores_socio_usuario", default: 0, null: false, unsigned: true
    t.decimal "valor_criadores_socio_usuario", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.text "detalhes", collation: "utf8_general_ci"
  end

  create_table "fin_boleto_lote", id: :bigint, unsigned: true, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.datetime "datahora_cadastro", null: false
    t.integer "quantidade_boleto", null: false, unsigned: true
    t.decimal "valor_total", precision: 10, scale: 2, null: false
    t.string "nome_remessa"
  end

  create_table "fin_centro_custos", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "numero", limit: 10, null: false, collation: "utf8_general_ci"
    t.string "nome", null: false, collation: "utf8_general_ci"
    t.bigint "pai", unsigned: true
  end

  create_table "fin_conta_corrente", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nome_banco", collation: "utf8_general_ci"
    t.string "numero_banco", collation: "utf8_general_ci"
    t.string "numero_agencia", collation: "utf8_general_ci"
    t.string "numero_conta", collation: "utf8_general_ci"
    t.string "codigo_cedente", collation: "utf8_general_ci"
    t.string "numero_contrato", collation: "utf8_general_ci"
    t.string "carteira", collation: "utf8_general_ci"
    t.decimal "valor_inicial", precision: 10, scale: 2
    t.decimal "valor_taxa_boleto", precision: 10, scale: 2
    t.text "observacoes", collation: "utf8_general_ci"
    t.column "padrao_boleto", "enum('S','N')", default: "N", collation: "utf8_general_ci"
    t.decimal "boleto_multa_padrao", precision: 10, scale: 2, unsigned: true
    t.decimal "boleto_juros_padrao", precision: 10, scale: 2, unsigned: true
  end

  create_table "fin_emolumento", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "codigo_servico_antigo", limit: 20, collation: "utf8_general_ci"
    t.string "descricao", collation: "utf8_general_ci"
    t.decimal "valor", precision: 10, scale: 2
    t.bigint "centro_custo"
    t.column "preco_variavel", "enum('S','N')", default: "S", collation: "utf8_general_ci"
  end

  create_table "fin_emolumento_padrao", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "servico_descricao"
    t.string "servico_tipo", null: false
    t.bigint "emolumento_id", null: false, unsigned: true
    t.index ["emolumento_id"], name: "emolumento_id"
    t.index ["servico_tipo"], name: "servico_tipo", unique: true
  end

  create_table "fin_lancamento_boleto", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.datetime "datahora_cadastro"
    t.date "data_vencimento"
    t.bigint "sacado", unsigned: true
    t.bigint "conta_corrente", unsigned: true
    t.decimal "valor_servico", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "valor_multa_atraso", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.decimal "valor_a_pagar", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.decimal "valor_desconto", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.decimal "valor_total", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.decimal "juros", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "multa", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "desconto", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "credito", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "valor_boleto", precision: 10, scale: 2, default: "0.0", null: false
    t.date "data_pagamento"
    t.decimal "valor_pago", precision: 10, scale: 2
    t.string "nosso_numero", limit: 20, collation: "utf8_general_ci"
    t.bigint "lote", unsigned: true
    t.column "status", "enum('cancelado','pago','pendente')", collation: "utf8_general_ci"
    t.index ["conta_corrente"], name: "fin_lancamento_boleto_ibfk_1"
    t.index ["lote"], name: "lote"
    t.index ["sacado"], name: "fin_lancamento_boleto_ibfk_2"
  end

  create_table "fin_lancamento_credito", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "data_credito"
    t.bigint "associado_id", unsigned: true
    t.bigint "usuario_id", unsigned: true
    t.decimal "valor", precision: 10, scale: 2, default: "0.0", null: false
    t.string "observacao", collation: "utf8_general_ci"
  end

  create_table "fin_lancamento_despesa", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.timestamp "datahora_cadastro", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "numero_documento", collation: "utf8_general_ci"
    t.bigint "favorecido", null: false, unsigned: true
    t.bigint "conta_corrente", unsigned: true
    t.bigint "centro_custos", unsigned: true
    t.text "descricao", collation: "utf8_general_ci"
    t.decimal "valor", precision: 10, scale: 2, null: false
    t.decimal "valor_pago", precision: 10, scale: 2, default: "0.0", null: false
    t.date "data_vencimento"
    t.date "data_quitacao"
    t.column "situacao", "enum('pendente','pago','cancelado')", default: "pendente", collation: "utf8_general_ci"
    t.index ["centro_custos"], name: "centro_custos"
    t.index ["conta_corrente"], name: "conta_corrente"
    t.index ["favorecido"], name: "favorecido"
  end

  create_table "fin_lancamento_receita", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "datahora_cadastro", null: false
    t.bigint "associado", null: false, unsigned: true
    t.bigint "emolumento", unsigned: true
    t.bigint "centro_custos", unsigned: true
    t.text "conteudo", collation: "utf8_general_ci"
    t.text "descricao", collation: "utf8_general_ci"
    t.decimal "valor", precision: 10, scale: 2, null: false
    t.decimal "valor_multa_atraso", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.decimal "valor_a_pagar", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.decimal "valor_desconto", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.decimal "valor_total", precision: 10, scale: 2, null: false
    t.decimal "valor_pago", precision: 10, scale: 2, default: "0.0", null: false, unsigned: true
    t.column "tipo", "enum('comunicacao','avulso')", default: "avulso", collation: "utf8_general_ci"
    t.bigint "comunicacao", unsigned: true
    t.date "data_vencimento"
    t.date "data_quitacao"
    t.column "situacao", "enum('pendente','pago','cancelado')", default: "pendente", collation: "utf8_general_ci"
    t.decimal "valor_pagamento_cartao", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "valor_pagamento_boleto", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "valor_pagamento_deposito", precision: 10, scale: 2, default: "0.0", null: false
    t.bigint "pagamento_deposito_conta_corrente", unsigned: true
    t.decimal "valor_pagamento_dinheiro", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "valor_pagamento_cheque", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "valor_pagamento_credito", precision: 10, scale: 2, default: "0.0", null: false
    t.text "observacoes", collation: "utf8_general_ci"
    t.integer "numero_recibo", unsigned: true
    t.bigint "boleto", unsigned: true
    t.column "importado", "enum('S','N')", default: "N", collation: "utf8_general_ci"
    t.datetime "datahora_cancelamento"
    t.bigint "usuario_cancelamento", unsigned: true
    t.text "motivo_cancelamento", collation: "utf8_general_ci"
    t.index ["associado"], name: "fin_lancamento_receita_ibfk_2"
    t.index ["boleto"], name: "boleto"
    t.index ["comunicacao"], name: "comunicacao"
    t.index ["emolumento"], name: "emolumento"
    t.index ["pagamento_deposito_conta_corrente"], name: "fin_lancamento_receita_ibfk_5"
    t.index ["usuario_cancelamento"], name: "usuario_cancelamento"
  end

  create_table "fin_lancamento_recibo", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.datetime "datahora_cadastro"
    t.bigint "pessoa"
    t.decimal "valor_total", precision: 10, scale: 2
  end

  create_table "fin_lancamento_recibo_receita", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "recibo", null: false, unsigned: true
    t.bigint "receita", null: false, unsigned: true
    t.index ["receita"], name: "receita"
    t.index ["recibo"], name: "recibo"
  end

  create_table "gen_imagens", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "modulo", null: false, collation: "utf8_general_ci"
    t.string "submodulo", null: false, collation: "utf8_general_ci"
    t.string "tipo_imagem", null: false, collation: "utf8_general_ci"
    t.bigint "id_modulo", null: false, unsigned: true
    t.binary "imagem", size: :medium
    t.column "importado_aws", "enum('S','N')", default: "N", null: false, collation: "utf8_general_ci"
    t.index ["id_modulo"], name: "id_modulo"
    t.index ["modulo", "submodulo", "tipo_imagem", "id_modulo"], name: "modulo", unique: true
    t.index ["modulo", "submodulo"], name: "modulo_2"
    t.index ["modulo"], name: "modulo_3"
  end

  create_table "log", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.column "nivel", "enum('alert','critical','debug','emergency','error','info','notice','warning')", null: false, collation: "utf8_general_ci"
    t.column "tipo", "enum('animal','comunicacao','financeiro_receita','login','pessoa','configuracao','registro','protocolo')", null: false, collation: "utf8_general_ci"
    t.integer "tipo_id", unsigned: true
    t.bigint "usuario", unsigned: true
    t.text "descricao", null: false, collation: "utf8_general_ci"
    t.datetime "datahora", null: false
    t.index ["tipo", "tipo_id"], name: "tipo"
    t.index ["usuario"], name: "usuario"
  end

  create_table "prot_conteudo_protocolo", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nome", null: false, collation: "utf8_general_ci"
    t.column "tipo", "enum('entrada','saida')", null: false, collation: "utf8_general_ci"
    t.column "comunicacao", "enum('N','S')", default: "N", null: false, collation: "utf8_general_ci"
  end

  create_table "prot_protocolo", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "numero", limit: 20, null: false, collation: "utf8_general_ci"
    t.datetime "datahora_cadastro", null: false
    t.column "forma_envio", "enum('fax','internet','correio','email','interno','online','maos')", null: false, collation: "utf8_general_ci"
    t.date "data_envio", null: false
    t.date "data_recebimento"
    t.bigint "pessoa", null: false, unsigned: true
    t.bigint "conteudo", null: false, unsigned: true
    t.column "tipo", "enum('entrada','saida')", null: false, collation: "utf8_general_ci"
    t.string "ar_sedex", collation: "utf8_general_ci"
    t.column "carta", "enum('sim','nao')", collation: "utf8_general_ci"
    t.text "observacoes", collation: "utf8_general_ci"
    t.index ["conteudo"], name: "conteudo"
    t.index ["datahora_cadastro"], name: "datahora_cadastro"
    t.index ["numero"], name: "numero"
    t.index ["pessoa"], name: "pessoa"
  end

  create_table "srg_animal", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nome", collation: "utf8_general_ci"
    t.string "nome_completo", collation: "utf8_general_ci"
    t.string "numero_chip", collation: "utf8_general_ci"
    t.column "sexo", "enum('castrado','femea','macho')", collation: "utf8_general_ci"
    t.bigint "pai", unsigned: true
    t.bigint "mae", unsigned: true
    t.date "data_nascimento"
    t.string "fazenda_nascimento", collation: "utf8_general_ci"
    t.string "cidade_nascimento", collation: "utf8_general_ci"
    t.bigint "uf_nascimento", unsigned: true
    t.bigint "criador", unsigned: true
    t.bigint "proprietario", unsigned: true
    t.bigint "pelagem_padrao", unsigned: true
    t.string "pelagem", collation: "utf8_general_ci"
    t.column "dna_tipo", "enum('ap','vp','sem_dna')", default: "sem_dna", null: false, collation: "utf8_general_ci"
    t.date "dna_data_exame"
    t.bigint "dna_laboratorio", unsigned: true
    t.column "homozigose_tipo", "enum('-','homozigoto_tobiano','heterozigoto','homozigoto_normal')", default: "-", null: false, collation: "utf8_general_ci"
    t.date "homozigose_data_exame"
    t.bigint "homozigose_laboratorio", unsigned: true
    t.string "dna_exposicao_nome"
    t.integer "dna_exposicao_ano", unsigned: true
    t.column "clone", "enum('S','N')", default: "N", null: false, collation: "utf8_general_ci"
    t.date "data_clone"
    t.bigint "laboratorio_clone", unsigned: true
    t.bigint "animal_origem", unsigned: true
    t.date "data_castracao"
    t.date "data_baixa"
    t.column "motivo_baixa", "enum('anulacao_registro','baixa','morte_natural','paradeiro_desconhecido','outros')", collation: "utf8_general_ci"
    t.column "status", "enum('ativo','morto','baixado','leiloado_vendido','suspenso','inativo','excluido','em_analise','bloqueado')", default: "ativo", null: false, collation: "utf8_general_ci"
    t.date "data_desbloqueio"
    t.text "observacoes", collation: "utf8_general_ci"
    t.string "arcada_dentaria_compativel", limit: 10
    t.index ["animal_origem"], name: "animal_origem"
    t.index ["criador"], name: "criador"
    t.index ["dna_laboratorio"], name: "dna_laboratorio"
    t.index ["homozigose_laboratorio"], name: "homozigose_laboratorio"
    t.index ["laboratorio_clone"], name: "laboratorio_clone"
    t.index ["mae"], name: "mae"
    t.index ["pai"], name: "pai"
    t.index ["pelagem_padrao"], name: "pelagem_padrao"
    t.index ["proprietario"], name: "proprietario"
    t.index ["uf_nascimento"], name: "uf_nascimento"
  end

  create_table "srg_animal_socio", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "srg_animal_id", null: false, unsigned: true
    t.bigint "srg_pessoa_id", null: false, unsigned: true
    t.decimal "porcentagem", precision: 4, scale: 2
    t.index ["srg_animal_id"], name: "srg_animal_id"
    t.index ["srg_pessoa_id"], name: "srg_pessoa_id"
  end

  create_table "srg_censo_animal", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "srg_censo_associado_id", null: false, unsigned: true
    t.bigint "srg_animal_id", null: false, unsigned: true
    t.column "status", "enum('V','M','LV','PD','I')", collation: "utf8_general_ci"
    t.index ["srg_animal_id"], name: "srg_animal_id"
    t.index ["srg_censo_associado_id"], name: "srg_censo_associado_id"
  end

  create_table "srg_censo_ano", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "data_geracao"
  end

  create_table "srg_censo_associado", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "ano", null: false, unsigned: true
    t.bigint "associado_id", null: false, unsigned: true
    t.datetime "datahora_cadastro"
    t.datetime "data_resposta"
    t.datetime "data_cancelamento"
    t.index ["ano"], name: "ano"
  end

  create_table "srg_pessoa", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nome", collation: "utf8_general_ci"
    t.string "codigo", limit: 10, collation: "utf8_general_ci"
    t.datetime "datahora_cadastro"
    t.date "data_nascimento"
    t.column "sexo", "enum('F','M')", collation: "utf8_general_ci"
    t.column "estado_civil", "enum('casado','desquitado','divorciado','outros','separado','solteiro','viuvo')", collation: "utf8_general_ci"
    t.string "telefone", collation: "utf8_general_ci"
    t.string "celular", collation: "utf8_general_ci"
    t.string "fax", collation: "utf8_general_ci"
    t.string "email", collation: "utf8_general_ci"
    t.string "login", collation: "utf8_general_ci"
    t.string "senha", limit: 32, collation: "utf8_general_ci"
    t.datetime "datahora_ultimo_login"
    t.text "observacoes", collation: "utf8_general_ci"
    t.column "tipo_pessoa", "enum('pf','pj')", collation: "utf8_general_ci"
    t.string "cpf", collation: "utf8_general_ci"
    t.string "rg", collation: "utf8_general_ci"
    t.string "cidade_nascimento", collation: "utf8_general_ci"
    t.string "conjuge_nome", collation: "utf8_general_ci"
    t.bigint "escolaridade", unsigned: true
    t.bigint "profissao", unsigned: true
    t.string "cnpj", collation: "utf8_general_ci"
    t.string "contato", collation: "utf8_general_ci"
    t.string "indicacao_de", collation: "utf8_general_ci"
    t.string "inscricao_estadual", collation: "utf8_general_ci"
    t.string "inscricao_municipal", collation: "utf8_general_ci"
    t.date "credenciado_data_inscricao"
    t.string "credenciado_crmv", collation: "utf8_general_ci"
    t.string "credenciado_crea", collation: "utf8_general_ci"
    t.string "credenciado_area_atuacao", collation: "utf8_general_ci"
    t.date "credenciado_data_baixa"
    t.date "associado_data_inscricao"
    t.column "associado_tipo_afixo", "enum('prefixo','sufixo')", collation: "utf8_general_ci"
    t.string "associado_afixo", collation: "utf8_general_ci"
    t.string "associado_preposicao", collation: "utf8_general_ci"
    t.bigint "associado_endereco_fazenda", unsigned: true
    t.string "associado_nome_fazenda", collation: "utf8_general_ci"
    t.string "associado_cidade_fazenda", collation: "utf8_general_ci"
    t.bigint "associado_estado_fazenda", unsigned: true
    t.date "associado_data_baixa"
    t.string "associado_numero_inscricao_produtor_rural", collation: "utf8_general_ci"
    t.column "status", "enum('ativo','inativo')", default: "ativo", collation: "utf8_general_ci"
    t.integer "qtd_animais"
  end

  create_table "srg_pessoa_endereco", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "pessoa", unsigned: true
    t.string "endereco", collation: "utf8_general_ci"
    t.string "complemento", collation: "utf8_general_ci"
    t.string "bairro", collation: "utf8_general_ci"
    t.string "cep", collation: "utf8_general_ci"
    t.string "cidade", collation: "utf8_general_ci"
    t.bigint "estado", unsigned: true
    t.column "tipo", "enum('outro','fazenda','comercial','residencial')", collation: "utf8_general_ci"
    t.column "correspondencia", "enum('N','S')", collation: "utf8_general_ci"
    t.index ["estado"], name: "srg_pessoa_endereco_ibfk_2"
    t.index ["pessoa"], name: "pessoa"
  end

  create_table "srg_pessoa_fazenda", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "pessoa", unsigned: true
    t.string "nome", collation: "utf8_general_ci"
    t.string "cidade", collation: "utf8_general_ci"
    t.bigint "estado", unsigned: true
    t.column "principal", "enum('N','S')", collation: "utf8_general_ci"
    t.index ["estado"], name: "estado"
    t.index ["pessoa"], name: "pessoa"
  end

  create_table "srg_pessoa_perfil", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "pessoa_id", null: false, unsigned: true
    t.bigint "perfil_id", null: false, unsigned: true
    t.index ["perfil_id"], name: "perfil_id"
    t.index ["pessoa_id"], name: "pessoa_id"
  end

  create_table "srg_pessoa_procurador_socio", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "srg_pessoa_id", null: false, unsigned: true
    t.string "nome", collation: "utf8_general_ci"
    t.string "cpf", collation: "utf8_general_ci"
    t.string "telefone", collation: "utf8_general_ci"
    t.column "tipo", "enum('socio','procurador')", collation: "utf8_general_ci"
    t.date "data_vencimento"
    t.index ["srg_pessoa_id"], name: "srg_pessoa_id"
  end

  create_table "srg_pessoa_representante", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "srg_pessoa_id", null: false, unsigned: true
    t.bigint "srg_representante_id", null: false, unsigned: true
    t.index ["srg_pessoa_id"], name: "srg_pessoa_id"
    t.index ["srg_representante_id"], name: "srg_pessoa_representante_ibfk_2"
  end

  create_table "srg_registro", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "animal", null: false, unsigned: true
    t.date "data_registro"
    t.bigint "comunicacao", unsigned: true
    t.column "tipo", "enum('C','D','P')", collation: "utf8_general_ci"
    t.column "controlado_ao_pe", "enum('sim','nao')", collation: "utf8_general_ci"
    t.bigint "tecnico_responsavel", unsigned: true
    t.date "data_mensuracao"
    t.bigint "livro", unsigned: true
    t.integer "livro_volume", unsigned: true
    t.integer "livro_pagina", unsigned: true
    t.integer "numero_registro", unsigned: true
    t.bigint "pelagem_padrao", unsigned: true
    t.string "pelagem", collation: "utf8_general_ci"
    t.string "cabeca", collation: "utf8_general_ci"
    t.string "membro_anterior_esquerdo", collation: "utf8_general_ci"
    t.string "membro_anterior_direito", collation: "utf8_general_ci"
    t.string "membro_posterior_esquerdo", collation: "utf8_general_ci"
    t.string "membro_posterior_direito", collation: "utf8_general_ci"
    t.string "sinais", collation: "utf8_general_ci"
    t.text "observacoes", collation: "utf8_general_ci"
    t.decimal "altura_cernelha", precision: 4, scale: 2, unsigned: true
    t.decimal "altura_dorso", precision: 4, scale: 2, unsigned: true
    t.decimal "altura_garupa", precision: 4, scale: 2, unsigned: true
    t.decimal "altura_costados", precision: 4, scale: 2, unsigned: true
    t.decimal "largura_cabeca", precision: 4, scale: 2, unsigned: true
    t.decimal "largura_peito", precision: 4, scale: 2, unsigned: true
    t.decimal "largura_anca", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_cabeca", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_pescoco", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_dorso_lombo", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_garupa", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_espadua", precision: 4, scale: 2, unsigned: true
    t.decimal "comprimento_corpo", precision: 4, scale: 2, unsigned: true
    t.decimal "perimetro_torax", precision: 4, scale: 2, unsigned: true
    t.decimal "perimetro_canela", precision: 4, scale: 2, unsigned: true
    t.decimal "pontuacao_altura", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_temperamento", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_qualidade", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_proporcoes", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_forma", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_orelhas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_fronte", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_ganachas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_olhos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_narinas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_boca", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_perfil", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_borda_superior", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_borda_inferior", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_ligacao", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_insercao", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_dimensoes", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_cernelha", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_peito", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_costelas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_dorso", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_lombo", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_flancos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_ventre", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_ancas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_garupa", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_cauda", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_espaduas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_bracos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_antebracos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_joelhos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_coxas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_pernas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_jarretes", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_canelas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_boletos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_quartelas", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_cascos", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_comodidade", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_estilo", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_regularidade", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_desenvolvimento", precision: 6, scale: 2, unsigned: true
    t.decimal "pontuacao_dissociacao", precision: 6, scale: 2, unsigned: true
    t.index ["animal"], name: "animal"
    t.index ["livro"], name: "livro"
    t.index ["pelagem_padrao"], name: "pelagem_padrao"
  end

  create_table "srg_registro_livro", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nome", null: false, collation: "utf8_general_ci"
    t.string "sigla", null: false, collation: "utf8_general_ci"
    t.column "sexo", "enum('C','F','M')", null: false, collation: "utf8_general_ci"
    t.column "tipo_registro", "enum('P','D','C','A','E')", null: false, collation: "utf8_general_ci"
    t.integer "maximo_paginas", null: false
    t.integer "registros_por_pagina", null: false
  end

  create_table "srg_transferencia_propriedade", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "comunicacao_id", null: false, unsigned: true
    t.bigint "animal_id", null: false, unsigned: true
    t.bigint "comprador_id", null: false, unsigned: true
    t.bigint "vendedor_id", null: false, unsigned: true
    t.column "tipo_transferencia", "enum('retorno_provisoria','provisoria','definitiva')", null: false, collation: "utf8_general_ci"
    t.date "data_transferencia", null: false
    t.index ["animal_id"], name: "animal_id"
    t.index ["comprador_id"], name: "comprador_id"
    t.index ["comunicacao_id"], name: "comunicacao_id"
    t.index ["vendedor_id"], name: "vendedor_id"
  end

  create_table "sys_configuracao", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nome_fantasia", collation: "utf8_general_ci"
    t.string "razao_social", collation: "utf8_general_ci"
    t.string "cnpj", collation: "utf8_general_ci"
    t.string "inscricao_estadual", collation: "utf8_general_ci"
    t.string "inscricao_municipal", collation: "utf8_general_ci"
    t.string "endereco", collation: "utf8_general_ci"
    t.string "numero", collation: "utf8_general_ci"
    t.string "complemento", collation: "utf8_general_ci"
    t.string "cep", collation: "utf8_general_ci"
    t.string "bairro", collation: "utf8_general_ci"
    t.string "cidade", collation: "utf8_general_ci"
    t.bigint "estado"
    t.string "telefone_1", collation: "utf8_general_ci"
    t.string "telefone_2", collation: "utf8_general_ci"
    t.string "fax", collation: "utf8_general_ci"
    t.string "email_principal", collation: "utf8_general_ci"
    t.string "site", collation: "utf8_general_ci"
    t.string "responsavel_srg", collation: "utf8_general_ci"
    t.string "registro_mapa", collation: "utf8_general_ci"
    t.text "texto_carta_cobranca"
  end

  create_table "sys_senha_token", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT", force: :cascade do |t|
    t.bigint "srg_pessoa_id", null: false, unsigned: true
    t.string "token", limit: 40, null: false, collation: "utf8_general_ci"
    t.datetime "datahora_cadastro", null: false
  end

  create_table "temp_boletos_vencidos", id: :bigint, default: 0, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
  end

  create_table "temp_invalid_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.bigint "id", unsigned: true
    t.string "message"
  end

  create_table "temp_proprietario_errado", id: :integer, unsigned: true, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "proprietario", null: false, unsigned: true
    t.integer "proprietario_antigo", null: false, unsigned: true
  end

  create_table "temp_status_leilao_vendido", id: :integer, unsigned: true, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
  end

  create_table "temp_users_billets", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "code", collation: "utf8_general_ci"
    t.string "file", collation: "utf8_general_ci"
  end

  create_table "temp_users_option3", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "code", collation: "utf8_general_ci"
    t.string "name", collation: "utf8_general_ci"
    t.string "login", collation: "utf8_general_ci"
    t.string "update", limit: 2, collation: "utf8_general_ci"
    t.bigint "id", unsigned: true
    t.string "invalid", limit: 2, collation: "utf8_general_ci"
    t.string "billet", collation: "utf8_general_ci"
    t.string "send", limit: 2, collation: "utf8_general_ci"
    t.string "sent", limit: 2, collation: "utf8_general_ci"
    t.text "sent_error", collation: "utf8_general_ci"
  end

  create_table "view_categorias_associados_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "id", limit: 1, null: false
    t.integer "codigo", limit: 1, null: false
    t.integer "nome", limit: 1, null: false
    t.integer "data_nascimento", limit: 1, null: false
    t.integer "idade", limit: 1, null: false
    t.integer "qtde_animais", limit: 1, null: false
    t.integer "categoria_atual", limit: 1, null: false
    t.integer "categoria_correta", limit: 1, null: false
    t.integer "categoria_correta_id", limit: 1, null: false
    t.integer "categoria_atual_igual_correta", limit: 1, null: false
  end

  create_table "view_com_animais_relacionados_nomes_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "comunicacao_id", limit: 1, null: false
    t.integer "animais_nomes", limit: 1, null: false
  end

  create_table "view_com_animais_relacionados_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "comunicacao_id", limit: 1, null: false
    t.integer "animal_id", limit: 1, null: false
    t.integer "tipo", limit: 1, null: false
  end

  create_table "view_com_pessoas_relacionadas_2_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "comunicacao_id", limit: 1, null: false
    t.integer "pessoa_id", limit: 1, null: false
    t.integer "tipo", limit: 1, null: false
  end

  create_table "view_com_pessoas_relacionadas_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "comunicacao_id", limit: 1, null: false
    t.integer "pessoa_id", limit: 1, null: false
    t.integer "tipo", limit: 1, null: false
  end

  create_table "view_comunicacoes_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "id", limit: 1, null: false
    t.integer "numero_comunicacao", limit: 1, null: false
    t.integer "quantidade_pendencias", limit: 1, null: false
    t.integer "protocolo", limit: 1, null: false
    t.integer "data_protocolo", limit: 1, null: false
    t.integer "tipo_comunicacao", limit: 1, null: false
    t.integer "status_comunicacao_id", limit: 1, null: false
    t.integer "status_comunicacao", limit: 1, null: false
    t.integer "remetente", limit: 1, null: false
  end

  create_table "view_faturamento_anual_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "faturamento", limit: 1, null: false
    t.integer "ano", limit: 1, null: false
  end

  create_table "view_fin_creditos_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "pessoa", limit: 1, null: false
    t.integer "tipo_id", limit: 1, null: false
    t.integer "tipo", limit: 1, null: false
    t.integer "datahora", limit: 1, null: false
    t.integer "credito", limit: 1, null: false
  end

  create_table "view_listagem_associados_categoria_plantel_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "id", limit: 1, null: false
    t.integer "nome", limit: 1, null: false
    t.integer "codigo", limit: 1, null: false
    t.integer "categoria_atual", limit: 1, null: false
    t.integer "qtde_animais", limit: 1, null: false
    t.integer "datahora_cadastro", limit: 1, null: false
    t.integer "data_nascimento", limit: 1, null: false
    t.integer "sexo", limit: 1, null: false
    t.integer "estado_civil", limit: 1, null: false
    t.integer "telefone", limit: 1, null: false
    t.integer "celular", limit: 1, null: false
    t.integer "fax", limit: 1, null: false
    t.integer "email", limit: 1, null: false
    t.integer "observacoes", limit: 1, null: false
    t.integer "tipo_pessoa", limit: 1, null: false
    t.integer "cpf", limit: 1, null: false
    t.integer "rg", limit: 1, null: false
    t.integer "cidade_nascimento", limit: 1, null: false
    t.integer "conjuge_nome", limit: 1, null: false
    t.integer "escolaridade", limit: 1, null: false
    t.integer "profissao", limit: 1, null: false
    t.integer "cnpj", limit: 1, null: false
    t.integer "contato", limit: 1, null: false
    t.integer "associado_data_inscricao", limit: 1, null: false
    t.integer "associado_cidade_fazenda", limit: 1, null: false
    t.integer "estado_fazenda", limit: 1, null: false
  end

  create_table "view_srg_animal_completo_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "id", limit: 1, null: false
    t.integer "nome_completo", limit: 1, null: false
    t.integer "sexo", limit: 1, null: false
    t.integer "tipo_registro", limit: 1, null: false
    t.integer "registro_animal", limit: 1, null: false
    t.integer "ano_registro", limit: 1, null: false
    t.integer "status", limit: 1, null: false
    t.integer "pelagem_padrao_animal", limit: 1, null: false
    t.integer "pelagem_animal", limit: 1, null: false
    t.integer "data_nascimento", limit: 1, null: false
    t.integer "ano_nascimento", limit: 1, null: false
    t.integer "cidade_nascimento", limit: 1, null: false
    t.integer "uf_nascimento", limit: 1, null: false
    t.integer "registro_provisorio", limit: 1, null: false
    t.integer "registro_definitivo", limit: 1, null: false
    t.integer "registro_castrado", limit: 1, null: false
    t.integer "proprietario_id", limit: 1, null: false
    t.integer "proprietario_nome", limit: 1, null: false
    t.integer "proprietario_codigo", limit: 1, null: false
    t.integer "nome_pai", limit: 1, null: false
    t.integer "registro_pai", limit: 1, null: false
    t.integer "pelagem_padrao_pai", limit: 1, null: false
    t.integer "pelagem_pai", limit: 1, null: false
    t.integer "nome_mae", limit: 1, null: false
    t.integer "registro_mae", limit: 1, null: false
    t.integer "pelagem_padrao_mae", limit: 1, null: false
    t.integer "pelagem_mae", limit: 1, null: false
  end

  create_table "view_srg_animal_completo_resenhas_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "id", limit: 1, null: false
    t.integer "nome_completo", limit: 1, null: false
    t.integer "sexo", limit: 1, null: false
    t.integer "tipo_registro", limit: 1, null: false
    t.integer "registro_animal", limit: 1, null: false
    t.integer "ano_registro", limit: 1, null: false
    t.integer "status", limit: 1, null: false
    t.integer "pelagem_padrao_animal", limit: 1, null: false
    t.integer "pelagem_animal", limit: 1, null: false
    t.integer "data_nascimento", limit: 1, null: false
    t.integer "ano_nascimento", limit: 1, null: false
    t.integer "cidade_nascimento", limit: 1, null: false
    t.integer "uf_nascimento", limit: 1, null: false
    t.integer "registro_provisorio", limit: 1, null: false
    t.integer "registro_definitivo", limit: 1, null: false
    t.integer "registro_castrado", limit: 1, null: false
    t.integer "proprietario_id", limit: 1, null: false
    t.integer "proprietario_nome", limit: 1, null: false
    t.integer "proprietario_codigo", limit: 1, null: false
    t.integer "nome_pai", limit: 1, null: false
    t.integer "registro_pai", limit: 1, null: false
    t.integer "pelagem_padrao_pai", limit: 1, null: false
    t.integer "pelagem_pai", limit: 1, null: false
    t.integer "nome_mae", limit: 1, null: false
    t.integer "registro_mae", limit: 1, null: false
    t.integer "pelagem_padrao_mae", limit: 1, null: false
    t.integer "pelagem_mae", limit: 1, null: false
    t.integer "animal", limit: 1, null: false
    t.integer "data_registro", limit: 1, null: false
    t.integer "comunicacao", limit: 1, null: false
    t.integer "tipo", limit: 1, null: false
    t.integer "controlado_ao_pe", limit: 1, null: false
    t.integer "tecnico_responsavel", limit: 1, null: false
    t.integer "tecnico_responsavel_nome", limit: 1, null: false
    t.integer "data_mensuracao", limit: 1, null: false
    t.integer "livro", limit: 1, null: false
    t.integer "livro_volume", limit: 1, null: false
    t.integer "livro_pagina", limit: 1, null: false
    t.integer "numero_registro", limit: 1, null: false
    t.integer "pelagem_padrao", limit: 1, null: false
    t.integer "pelagem", limit: 1, null: false
    t.integer "cabeca", limit: 1, null: false
    t.integer "membro_anterior_esquerdo", limit: 1, null: false
    t.integer "membro_anterior_direito", limit: 1, null: false
    t.integer "membro_posterior_esquerdo", limit: 1, null: false
    t.integer "membro_posterior_direito", limit: 1, null: false
    t.integer "sinais", limit: 1, null: false
    t.integer "observacoes", limit: 1, null: false
    t.integer "altura_cernelha", limit: 1, null: false
    t.integer "altura_dorso", limit: 1, null: false
    t.integer "altura_garupa", limit: 1, null: false
    t.integer "altura_costados", limit: 1, null: false
    t.integer "largura_cabeca", limit: 1, null: false
    t.integer "largura_peito", limit: 1, null: false
    t.integer "largura_anca", limit: 1, null: false
    t.integer "comprimento_cabeca", limit: 1, null: false
    t.integer "comprimento_pescoco", limit: 1, null: false
    t.integer "comprimento_dorso_lombo", limit: 1, null: false
    t.integer "comprimento_garupa", limit: 1, null: false
    t.integer "comprimento_espadua", limit: 1, null: false
    t.integer "comprimento_corpo", limit: 1, null: false
    t.integer "perimetro_torax", limit: 1, null: false
    t.integer "perimetro_canela", limit: 1, null: false
    t.integer "pontuacao_altura", limit: 1, null: false
    t.integer "pontuacao_temperamento", limit: 1, null: false
    t.integer "pontuacao_qualidade", limit: 1, null: false
    t.integer "pontuacao_proporcoes", limit: 1, null: false
    t.integer "pontuacao_forma", limit: 1, null: false
    t.integer "pontuacao_orelhas", limit: 1, null: false
    t.integer "pontuacao_fronte", limit: 1, null: false
    t.integer "pontuacao_ganachas", limit: 1, null: false
    t.integer "pontuacao_olhos", limit: 1, null: false
    t.integer "pontuacao_narinas", limit: 1, null: false
    t.integer "pontuacao_boca", limit: 1, null: false
    t.integer "pontuacao_perfil", limit: 1, null: false
    t.integer "pontuacao_borda_superior", limit: 1, null: false
    t.integer "pontuacao_borda_inferior", limit: 1, null: false
    t.integer "pontuacao_ligacao", limit: 1, null: false
    t.integer "pontuacao_insercao", limit: 1, null: false
    t.integer "pontuacao_dimensoes", limit: 1, null: false
    t.integer "pontuacao_cernelha", limit: 1, null: false
    t.integer "pontuacao_peito", limit: 1, null: false
    t.integer "pontuacao_costelas", limit: 1, null: false
    t.integer "pontuacao_dorso", limit: 1, null: false
    t.integer "pontuacao_lombo", limit: 1, null: false
    t.integer "pontuacao_flancos", limit: 1, null: false
    t.integer "pontuacao_ventre", limit: 1, null: false
    t.integer "pontuacao_ancas", limit: 1, null: false
    t.integer "pontuacao_garupa", limit: 1, null: false
    t.integer "pontuacao_cauda", limit: 1, null: false
    t.integer "pontuacao_espaduas", limit: 1, null: false
    t.integer "pontuacao_bracos", limit: 1, null: false
    t.integer "pontuacao_antebracos", limit: 1, null: false
    t.integer "pontuacao_joelhos", limit: 1, null: false
    t.integer "pontuacao_coxas", limit: 1, null: false
    t.integer "pontuacao_pernas", limit: 1, null: false
    t.integer "pontuacao_jarretes", limit: 1, null: false
    t.integer "pontuacao_canelas", limit: 1, null: false
    t.integer "pontuacao_boletos", limit: 1, null: false
    t.integer "pontuacao_quartelas", limit: 1, null: false
    t.integer "pontuacao_cascos", limit: 1, null: false
    t.integer "pontuacao_comodidade", limit: 1, null: false
    t.integer "pontuacao_estilo", limit: 1, null: false
    t.integer "pontuacao_regularidade", limit: 1, null: false
    t.integer "pontuacao_desenvolvimento", limit: 1, null: false
    t.integer "pontuacao_dissociacao", limit: 1, null: false
  end

  create_table "view_srg_registros_animais_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "animal", limit: 1, null: false
    t.integer "data_registro", limit: 1, null: false
    t.integer "numero", limit: 1, null: false
    t.integer "tipo", limit: 1, null: false
    t.integer "livro", limit: 1, null: false
    t.integer "livro_volume", limit: 1, null: false
    t.integer "livro_pagina", limit: 1, null: false
    t.integer "numero_registro", limit: 1, null: false
    t.integer "registro_id", limit: 1, null: false
    t.integer "pelagem_padrao", limit: 1, null: false
    t.integer "pelagem", limit: 1, null: false
  end

  create_table "view_srg_registros_animais_resenhas_old", id: false, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "id", limit: 1, null: false
    t.integer "animal", limit: 1, null: false
    t.integer "data_registro", limit: 1, null: false
    t.integer "comunicacao", limit: 1, null: false
    t.integer "tipo", limit: 1, null: false
    t.integer "controlado_ao_pe", limit: 1, null: false
    t.integer "tecnico_responsavel", limit: 1, null: false
    t.integer "tecnico_responsavel_nome", limit: 1, null: false
    t.integer "data_mensuracao", limit: 1, null: false
    t.integer "livro", limit: 1, null: false
    t.integer "livro_volume", limit: 1, null: false
    t.integer "livro_pagina", limit: 1, null: false
    t.integer "numero_registro", limit: 1, null: false
    t.integer "pelagem_padrao", limit: 1, null: false
    t.integer "pelagem", limit: 1, null: false
    t.integer "cabeca", limit: 1, null: false
    t.integer "membro_anterior_esquerdo", limit: 1, null: false
    t.integer "membro_anterior_direito", limit: 1, null: false
    t.integer "membro_posterior_esquerdo", limit: 1, null: false
    t.integer "membro_posterior_direito", limit: 1, null: false
    t.integer "sinais", limit: 1, null: false
    t.integer "observacoes", limit: 1, null: false
    t.integer "altura_cernelha", limit: 1, null: false
    t.integer "altura_dorso", limit: 1, null: false
    t.integer "altura_garupa", limit: 1, null: false
    t.integer "altura_costados", limit: 1, null: false
    t.integer "largura_cabeca", limit: 1, null: false
    t.integer "largura_peito", limit: 1, null: false
    t.integer "largura_anca", limit: 1, null: false
    t.integer "comprimento_cabeca", limit: 1, null: false
    t.integer "comprimento_pescoco", limit: 1, null: false
    t.integer "comprimento_dorso_lombo", limit: 1, null: false
    t.integer "comprimento_garupa", limit: 1, null: false
    t.integer "comprimento_espadua", limit: 1, null: false
    t.integer "comprimento_corpo", limit: 1, null: false
    t.integer "perimetro_torax", limit: 1, null: false
    t.integer "perimetro_canela", limit: 1, null: false
    t.integer "pontuacao_altura", limit: 1, null: false
    t.integer "pontuacao_temperamento", limit: 1, null: false
    t.integer "pontuacao_qualidade", limit: 1, null: false
    t.integer "pontuacao_proporcoes", limit: 1, null: false
    t.integer "pontuacao_forma", limit: 1, null: false
    t.integer "pontuacao_orelhas", limit: 1, null: false
    t.integer "pontuacao_fronte", limit: 1, null: false
    t.integer "pontuacao_ganachas", limit: 1, null: false
    t.integer "pontuacao_olhos", limit: 1, null: false
    t.integer "pontuacao_narinas", limit: 1, null: false
    t.integer "pontuacao_boca", limit: 1, null: false
    t.integer "pontuacao_perfil", limit: 1, null: false
    t.integer "pontuacao_borda_superior", limit: 1, null: false
    t.integer "pontuacao_borda_inferior", limit: 1, null: false
    t.integer "pontuacao_ligacao", limit: 1, null: false
    t.integer "pontuacao_insercao", limit: 1, null: false
    t.integer "pontuacao_dimensoes", limit: 1, null: false
    t.integer "pontuacao_cernelha", limit: 1, null: false
    t.integer "pontuacao_peito", limit: 1, null: false
    t.integer "pontuacao_costelas", limit: 1, null: false
    t.integer "pontuacao_dorso", limit: 1, null: false
    t.integer "pontuacao_lombo", limit: 1, null: false
    t.integer "pontuacao_flancos", limit: 1, null: false
    t.integer "pontuacao_ventre", limit: 1, null: false
    t.integer "pontuacao_ancas", limit: 1, null: false
    t.integer "pontuacao_garupa", limit: 1, null: false
    t.integer "pontuacao_cauda", limit: 1, null: false
    t.integer "pontuacao_espaduas", limit: 1, null: false
    t.integer "pontuacao_bracos", limit: 1, null: false
    t.integer "pontuacao_antebracos", limit: 1, null: false
    t.integer "pontuacao_joelhos", limit: 1, null: false
    t.integer "pontuacao_coxas", limit: 1, null: false
    t.integer "pontuacao_pernas", limit: 1, null: false
    t.integer "pontuacao_jarretes", limit: 1, null: false
    t.integer "pontuacao_canelas", limit: 1, null: false
    t.integer "pontuacao_boletos", limit: 1, null: false
    t.integer "pontuacao_quartelas", limit: 1, null: false
    t.integer "pontuacao_cascos", limit: 1, null: false
    t.integer "pontuacao_comodidade", limit: 1, null: false
    t.integer "pontuacao_estilo", limit: 1, null: false
    t.integer "pontuacao_regularidade", limit: 1, null: false
    t.integer "pontuacao_desenvolvimento", limit: 1, null: false
    t.integer "pontuacao_dissociacao", limit: 1, null: false
  end

  add_foreign_key "com_comunicacao", "aux_status_comunicacao", column: "status_comunicacao", name: "com_comunicacao_ibfk_6", on_update: :cascade
  add_foreign_key "com_comunicacao", "com_tipo_comunicacao", column: "tipo_comunicacao", name: "com_comunicacao_ibfk_5", on_update: :cascade
  add_foreign_key "com_comunicacao", "prot_conteudo_protocolo", column: "diversos_conteudo", name: "com_comunicacao_ibfk_7", on_update: :cascade
  add_foreign_key "com_comunicacao", "prot_protocolo", column: "protocolo", name: "com_comunicacao_ibfk_4", on_update: :cascade
  add_foreign_key "com_comunicacao", "srg_pessoa", column: "usuario_verificacao", name: "com_comunicacao_ibfk_8", on_update: :cascade
  add_foreign_key "com_comunicacao_alteracao_categoria", "com_comunicacao", column: "id", name: "com_comunicacao_alteracao_categoria_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_alteracao_categoria", "srg_pessoa", column: "pessoa", name: "com_comunicacao_alteracao_categoria_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_alteracao_dados_cadastrais", "aux_estado", column: "associado_estado_fazenda", name: "com_comunicacao_alteracao_dados_cadastrais_ibfk_3", on_update: :cascade
  add_foreign_key "com_comunicacao_alteracao_dados_cadastrais", "aux_estado", column: "estado", name: "com_comunicacao_alteracao_dados_cadastrais_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_alteracao_dados_cadastrais", "com_comunicacao", column: "id", name: "com_comunicacao_alteracao_dados_cadastrais_ibfk_4", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_alteracao_dados_cadastrais", "srg_pessoa", column: "pessoa", name: "com_comunicacao_alteracao_dados_cadastrais_ibfk_1", on_update: :cascade
  add_foreign_key "com_comunicacao_animal", "com_comunicacao", column: "comunicacao_id", name: "com_comunicacao_animal_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_animal", "srg_animal", column: "animal_id", name: "com_comunicacao_animal_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_animal_nome", "com_comunicacao", column: "comunicacao_id", name: "com_comunicacao_animal_nome_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_aprovacao", "com_comunicacao", column: "comunicacao_id", name: "com_comunicacao_aprovacao_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_baixa", "com_comunicacao", column: "id", name: "com_comunicacao_baixa_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_baixa_animal", "com_comunicacao_baixa", name: "com_comunicacao_baixa_animal_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_baixa_animal", "srg_animal", column: "animal_id", name: "com_comunicacao_baixa_animal_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_baixa_cadastral", "com_comunicacao", column: "id", name: "com_comunicacao_baixa_cadastral_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_baixa_cadastral", "srg_pessoa", column: "pessoa", name: "com_comunicacao_baixa_cadastral_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_castracao", "com_comunicacao", column: "id", name: "com_comunicacao_castracao_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_castracao", "srg_animal", column: "animal", name: "com_comunicacao_castracao_ibfk_4", on_update: :cascade
  add_foreign_key "com_comunicacao_castracao", "srg_registro_livro", column: "livro", name: "com_comunicacao_castracao_ibfk_3", on_update: :cascade
  add_foreign_key "com_comunicacao_censo", "com_comunicacao", column: "id", name: "com_comunicacao_censo_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_clone", "com_comunicacao", column: "id", name: "com_comunicacao_clone_ibfk_1", on_update: :cascade
  add_foreign_key "com_comunicacao_clone", "srg_animal", column: "animal", name: "com_comunicacao_clone_ibfk_3", on_update: :cascade
  add_foreign_key "com_comunicacao_clone", "srg_animal", column: "animal_origem", name: "com_comunicacao_clone_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_clone", "srg_pessoa", column: "laboratorio", name: "com_comunicacao_clone_ibfk_5", on_update: :cascade
  add_foreign_key "com_comunicacao_clone", "srg_pessoa", column: "proprietario_produto", name: "com_comunicacao_clone_ibfk_4", on_update: :cascade
  add_foreign_key "com_comunicacao_cobricao", "com_comunicacao", column: "id", name: "com_comunicacao_cobricao_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_cobricao", "srg_animal", column: "reprodutor", name: "com_comunicacao_cobricao_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_cobricao_matriz", "com_comunicacao_cobricao", name: "com_comunicacao_cobricao_matriz_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_cobricao_matriz", "srg_animal", column: "matriz_id", name: "com_comunicacao_cobricao_matriz_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_credenciamento", "aux_escolaridade", column: "escolaridade", name: "com_comunicacao_credenciamento_ibfk_4", on_update: :cascade
  add_foreign_key "com_comunicacao_credenciamento", "aux_estado", column: "estado", name: "com_comunicacao_credenciamento_ibfk_3", on_update: :cascade
  add_foreign_key "com_comunicacao_credenciamento", "aux_perfil_pessoa", column: "credenciado_tipo", name: "com_comunicacao_credenciamento_ibfk_6", on_update: :cascade
  add_foreign_key "com_comunicacao_credenciamento", "aux_profissao", column: "profissao", name: "com_comunicacao_credenciamento_ibfk_5", on_update: :cascade
  add_foreign_key "com_comunicacao_credenciamento", "com_comunicacao", column: "id", name: "com_comunicacao_credenciamento_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_credenciamento", "srg_pessoa", column: "pessoa", name: "com_comunicacao_credenciamento_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_desbloqueio_matriz", "com_comunicacao", column: "id", name: "com_comunicacao_desbloqueio_matriz_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_desbloqueio_matriz", "srg_animal", column: "matriz", name: "com_comunicacao_desbloqueio_matriz_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_descredenciamento", "com_comunicacao", column: "id", name: "com_comunicacao_descredenciamento_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_descredenciamento", "srg_pessoa", column: "pessoa", name: "com_comunicacao_descredenciamento_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_diversos", "com_comunicacao", column: "id", name: "com_comunicacao_diversos_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_diversos", "srg_animal", column: "animal", name: "com_comunicacao_diversos_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_exame_dna", "com_comunicacao", column: "id", name: "com_comunicacao_exame_dna_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_exame_dna", "srg_animal", column: "animal", name: "com_comunicacao_exame_dna_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_exame_dna", "srg_animal", column: "mae", name: "com_comunicacao_exame_dna_ibfk_4", on_update: :cascade
  add_foreign_key "com_comunicacao_exame_dna", "srg_animal", column: "pai", name: "com_comunicacao_exame_dna_ibfk_3", on_update: :cascade
  add_foreign_key "com_comunicacao_exame_dna", "srg_pessoa", column: "dna_laboratorio", name: "com_comunicacao_exame_dna_ibfk_5", on_update: :cascade
  add_foreign_key "com_comunicacao_exame_dna", "srg_pessoa", column: "responsavel_coleta", name: "com_comunicacao_exame_dna_ibfk_6", on_update: :cascade
  add_foreign_key "com_comunicacao_inspecao_previa", "aux_pelagem", column: "pelagem_padrao", name: "com_comunicacao_inspecao_previa_ibfk_4", on_update: :cascade
  add_foreign_key "com_comunicacao_inspecao_previa", "com_comunicacao", column: "id", name: "com_comunicacao_inspecao_previa_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_inspecao_previa", "srg_animal", column: "animal", name: "com_comunicacao_inspecao_previa_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_inspecao_previa", "srg_pessoa", column: "tecnico_responsavel", name: "com_comunicacao_inspecao_previa_ibfk_5", on_update: :cascade
  add_foreign_key "com_comunicacao_nascimento", "aux_estado", column: "uf_nascimento", name: "com_comunicacao_nascimento_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_nascimento", "aux_pelagem", column: "pelagem_padrao", name: "com_comunicacao_nascimento_ibfk_5", on_update: :cascade
  add_foreign_key "com_comunicacao_nascimento", "com_comunicacao", column: "com_comunicacao_origem_id", name: "com_comunicacao_nascimento_ibfk_6", on_update: :cascade
  add_foreign_key "com_comunicacao_nascimento", "com_comunicacao", column: "id", name: "com_comunicacao_nascimento_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_nascimento", "srg_animal", column: "animal", name: "com_comunicacao_nascimento_ibfk_7", on_update: :cascade
  add_foreign_key "com_comunicacao_nascimento", "srg_registro_livro", column: "livro", name: "com_comunicacao_nascimento_ibfk_3", on_update: :cascade
  add_foreign_key "com_comunicacao_pessoa", "com_comunicacao", column: "comunicacao_id", name: "com_comunicacao_pessoa_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_pessoa", "srg_pessoa", column: "pessoa_id", name: "com_comunicacao_pessoa_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_proposta_admissao", "aux_estado", column: "associado_estado_fazenda", name: "com_comunicacao_proposta_admissao_ibfk_4", on_update: :cascade
  add_foreign_key "com_comunicacao_proposta_admissao", "aux_estado", column: "estado_1", name: "com_comunicacao_proposta_admissao_ibfk_5", on_update: :cascade
  add_foreign_key "com_comunicacao_proposta_admissao", "aux_estado", column: "estado_2", name: "com_comunicacao_proposta_admissao_ibfk_6", on_update: :cascade
  add_foreign_key "com_comunicacao_proposta_admissao", "com_comunicacao", column: "id", name: "com_comunicacao_proposta_admissao_ibfk_3", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_proposta_admissao", "srg_pessoa", column: "pessoa", name: "com_comunicacao_proposta_admissao_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_proposta_admissao", "srg_pessoa_endereco", column: "pessoa_endereco_1", name: "com_comunicacao_proposta_admissao_ibfk_7", on_update: :cascade
  add_foreign_key "com_comunicacao_proposta_admissao", "srg_pessoa_endereco", column: "pessoa_endereco_2", name: "com_comunicacao_proposta_admissao_ibfk_8", on_update: :cascade
  add_foreign_key "com_comunicacao_reativacao", "com_comunicacao", column: "id", name: "com_comunicacao_reativacao_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_reativacao", "srg_animal", column: "animal", name: "com_comunicacao_reativacao_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_reativacao", "srg_pessoa", column: "inspetor_responsavel", name: "com_comunicacao_reativacao_ibfk_3", on_update: :cascade
  add_foreign_key "com_comunicacao_registro_definitivo", "aux_pelagem", column: "pelagem_padrao", name: "com_comunicacao_registro_definitivo_ibfk_4", on_update: :cascade
  add_foreign_key "com_comunicacao_registro_definitivo", "com_comunicacao", column: "id", name: "com_comunicacao_registro_definitivo_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_registro_definitivo", "srg_animal", column: "animal", name: "com_comunicacao_registro_definitivo_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_registro_definitivo", "srg_pessoa", column: "tecnico_responsavel", name: "com_comunicacao_registro_definitivo_ibfk_5", on_update: :cascade
  add_foreign_key "com_comunicacao_registro_definitivo", "srg_registro_livro", column: "livro", name: "com_comunicacao_registro_definitivo_ibfk_3", on_update: :cascade
  add_foreign_key "com_comunicacao_retificacao_padreacao", "com_comunicacao", column: "id", name: "com_comunicacao_retificacao_padreacao_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_retificacao_padreacao", "srg_animal", column: "animal", name: "com_comunicacao_retificacao_padreacao_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_retificacao_padreacao", "srg_animal", column: "mae", name: "com_comunicacao_retificacao_padreacao_ibfk_4", on_update: :cascade
  add_foreign_key "com_comunicacao_retificacao_padreacao", "srg_animal", column: "pai", name: "com_comunicacao_retificacao_padreacao_ibfk_3", on_update: :cascade
  add_foreign_key "com_comunicacao_retificacao_resenha", "aux_pelagem", column: "pelagem_padrao", name: "com_comunicacao_retificacao_resenha_ibfk_3", on_update: :cascade
  add_foreign_key "com_comunicacao_retificacao_resenha", "com_comunicacao", column: "id", name: "com_comunicacao_retificacao_resenha_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_retificacao_resenha", "srg_animal", column: "animal", name: "com_comunicacao_retificacao_resenha_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_retificacao_resenha", "srg_pessoa", column: "inspetor_registro", name: "com_comunicacao_retificacao_resenha_ibfk_4", on_update: :cascade
  add_foreign_key "com_comunicacao_segunda_via_registro", "com_comunicacao", column: "id", name: "com_comunicacao_segunda_via_registro_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_segunda_via_registro", "srg_animal", column: "animal", name: "com_comunicacao_segunda_via_registro_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_transferencia_embriao", "com_comunicacao", column: "id", name: "com_comunicacao_transferencia_embriao_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_transferencia_embriao", "srg_animal", column: "matriz_doadora", name: "com_comunicacao_transferencia_embriao_ibfk_6", on_update: :cascade
  add_foreign_key "com_comunicacao_transferencia_embriao", "srg_animal", column: "reprodutor", name: "com_comunicacao_transferencia_embriao_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_transferencia_embriao", "srg_pessoa", column: "proprietario_produto", name: "com_comunicacao_transferencia_embriao_ibfk_4", on_update: :cascade
  add_foreign_key "com_comunicacao_transferencia_embriao", "srg_pessoa", column: "veterinario_responsavel", name: "com_comunicacao_transferencia_embriao_ibfk_5", on_update: :cascade
  add_foreign_key "com_comunicacao_transferencia_embriao_matriz", "com_comunicacao_transferencia_embriao", name: "com_comunicacao_transferencia_embriao_matriz_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_transferencia_embriao_matriz", "srg_animal", column: "matriz_id", name: "com_comunicacao_transferencia_embriao_matriz_ibfk_3", on_update: :cascade
  add_foreign_key "com_comunicacao_transferencia_propriedade", "com_comunicacao", column: "id", name: "com_comunicacao_transferencia_propriedade_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_transferencia_propriedade", "srg_pessoa", column: "comprador", name: "com_comunicacao_transferencia_propriedade_ibfk_2", on_update: :cascade
  add_foreign_key "com_comunicacao_transferencia_propriedade", "srg_pessoa", column: "vendedor", name: "com_comunicacao_transferencia_propriedade_ibfk_3", on_update: :cascade
  add_foreign_key "com_comunicacao_transferencia_propriedade_animal", "com_comunicacao_transferencia_propriedade", name: "com_comunicacao_transferencia_propriedade_animal_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_comunicacao_transferencia_propriedade_animal", "srg_animal", column: "animal_id", name: "com_comunicacao_transferencia_propriedade_animal_ibfk_2", on_update: :cascade
  add_foreign_key "com_pendencia", "aux_status_comunicacao", column: "status_comunicacao", name: "com_pendencia_ibfk_1", on_update: :cascade
  add_foreign_key "com_pendencia", "com_tipo_comunicacao", column: "tipo_comunicacao", name: "com_pendencia_ibfk_2", on_update: :cascade
  add_foreign_key "com_pendencia_comunicacao", "aux_status_comunicacao", column: "status_comunicacao", name: "com_pendencia_comunicacao_ibfk_3", on_update: :cascade
  add_foreign_key "com_pendencia_comunicacao", "com_comunicacao", column: "comunicacao", name: "com_pendencia_comunicacao_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "com_pendencia_comunicacao", "com_pendencia", column: "pendencia", name: "com_pendencia_comunicacao_ibfk_1", on_update: :cascade
  add_foreign_key "fin_emolumento_padrao", "fin_emolumento", column: "emolumento_id", name: "fin_emolumento_padrao_ibfk_1", on_update: :cascade
  add_foreign_key "fin_lancamento_boleto", "fin_boleto_lote", column: "lote", name: "fin_lancamento_boleto_ibfk_3", on_update: :cascade
  add_foreign_key "fin_lancamento_boleto", "fin_conta_corrente", column: "conta_corrente", name: "fin_lancamento_boleto_ibfk_1", on_update: :cascade
  add_foreign_key "fin_lancamento_boleto", "srg_pessoa", column: "sacado", name: "fin_lancamento_boleto_ibfk_2", on_update: :cascade
  add_foreign_key "fin_lancamento_despesa", "fin_centro_custos", column: "centro_custos", name: "fin_lancamento_despesa_ibfk_3", on_update: :cascade
  add_foreign_key "fin_lancamento_despesa", "fin_conta_corrente", column: "conta_corrente", name: "fin_lancamento_despesa_ibfk_2", on_update: :cascade
  add_foreign_key "fin_lancamento_despesa", "srg_pessoa", column: "favorecido", name: "fin_lancamento_despesa_ibfk_1", on_update: :cascade
  add_foreign_key "fin_lancamento_receita", "com_comunicacao", column: "comunicacao", name: "fin_lancamento_receita_ibfk_3", on_update: :cascade
  add_foreign_key "fin_lancamento_receita", "fin_conta_corrente", column: "pagamento_deposito_conta_corrente", name: "fin_lancamento_receita_ibfk_5", on_update: :cascade
  add_foreign_key "fin_lancamento_receita", "fin_emolumento", column: "emolumento", name: "fin_lancamento_receita_ibfk_1", on_update: :cascade
  add_foreign_key "fin_lancamento_receita", "fin_lancamento_boleto", column: "boleto", name: "fin_lancamento_receita_ibfk_6", on_update: :cascade
  add_foreign_key "fin_lancamento_receita", "srg_pessoa", column: "associado", name: "fin_lancamento_receita_ibfk_2", on_update: :cascade
  add_foreign_key "fin_lancamento_receita", "srg_pessoa", column: "usuario_cancelamento", name: "fin_lancamento_receita_ibfk_7", on_update: :cascade
  add_foreign_key "fin_lancamento_recibo_receita", "fin_lancamento_receita", column: "receita", name: "fin_lancamento_recibo_receita_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "fin_lancamento_recibo_receita", "fin_lancamento_recibo", column: "recibo", name: "fin_lancamento_recibo_receita_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "log", "srg_pessoa", column: "usuario", name: "log_ibfk_1", on_update: :cascade
  add_foreign_key "prot_protocolo", "prot_conteudo_protocolo", column: "conteudo", name: "prot_protocolo_ibfk_1", on_update: :cascade
  add_foreign_key "prot_protocolo", "srg_pessoa", column: "pessoa", name: "prot_protocolo_ibfk_3", on_update: :cascade
  add_foreign_key "srg_animal", "aux_estado", column: "uf_nascimento", name: "srg_animal_ibfk_3", on_update: :cascade
  add_foreign_key "srg_animal", "aux_pelagem", column: "pelagem_padrao", name: "srg_animal_ibfk_6", on_update: :cascade
  add_foreign_key "srg_animal", "srg_animal", column: "animal_origem", name: "srg_animal_ibfk_9", on_update: :cascade
  add_foreign_key "srg_animal", "srg_animal", column: "mae", name: "srg_animal_ibfk_2", on_update: :cascade
  add_foreign_key "srg_animal", "srg_animal", column: "pai", name: "srg_animal_ibfk_1", on_update: :cascade
  add_foreign_key "srg_animal", "srg_pessoa", column: "criador", name: "srg_animal_ibfk_4", on_update: :cascade
  add_foreign_key "srg_animal", "srg_pessoa", column: "dna_laboratorio", name: "srg_animal_ibfk_7", on_update: :cascade
  add_foreign_key "srg_animal", "srg_pessoa", column: "homozigose_laboratorio", name: "srg_animal_ibfk_8", on_update: :cascade
  add_foreign_key "srg_animal", "srg_pessoa", column: "laboratorio_clone", name: "srg_animal_ibfk_10", on_update: :cascade
  add_foreign_key "srg_animal", "srg_pessoa", column: "proprietario", name: "srg_animal_ibfk_5", on_update: :cascade
  add_foreign_key "srg_animal_socio", "srg_animal", name: "srg_animal_socio_ibfk_1", on_update: :cascade
  add_foreign_key "srg_animal_socio", "srg_pessoa", name: "srg_animal_socio_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "srg_censo_animal", "srg_animal", name: "srg_censo_animal_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "srg_censo_animal", "srg_censo_associado", name: "srg_censo_animal_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "srg_censo_associado", "srg_censo_ano", column: "ano", name: "srg_censo_associado_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "srg_pessoa_endereco", "aux_estado", column: "estado", name: "srg_pessoa_endereco_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "srg_pessoa_endereco", "srg_pessoa", column: "pessoa", name: "srg_pessoa_endereco_ibfk_1", on_update: :cascade
  add_foreign_key "srg_pessoa_fazenda", "aux_estado", column: "estado", name: "srg_pessoa_fazenda_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "srg_pessoa_fazenda", "srg_pessoa", column: "pessoa", name: "srg_pessoa_fazenda_ibfk_1", on_update: :cascade
  add_foreign_key "srg_pessoa_perfil", "aux_perfil_pessoa", column: "perfil_id", name: "srg_pessoa_perfil_ibfk_2", on_update: :cascade
  add_foreign_key "srg_pessoa_perfil", "srg_pessoa", column: "pessoa_id", name: "srg_pessoa_perfil_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "srg_pessoa_procurador_socio", "srg_pessoa", name: "srg_pessoa_procurador_socio_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "srg_pessoa_representante", "srg_pessoa", column: "srg_representante_id", name: "srg_pessoa_representante_ibfk_2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "srg_pessoa_representante", "srg_pessoa", name: "srg_pessoa_representante_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "srg_registro", "aux_pelagem", column: "pelagem_padrao", name: "srg_registro_ibfk_2", on_update: :cascade
  add_foreign_key "srg_registro", "srg_animal", column: "animal", name: "srg_registro_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "srg_registro", "srg_registro_livro", column: "livro", name: "srg_registro_ibfk_3", on_update: :cascade
  add_foreign_key "srg_transferencia_propriedade", "com_comunicacao", column: "comunicacao_id", name: "srg_transferencia_propriedade_ibfk_1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "srg_transferencia_propriedade", "srg_animal", column: "animal_id", name: "srg_transferencia_propriedade_ibfk_2", on_update: :cascade
  add_foreign_key "srg_transferencia_propriedade", "srg_pessoa", column: "comprador_id", name: "srg_transferencia_propriedade_ibfk_3", on_update: :cascade
  add_foreign_key "srg_transferencia_propriedade", "srg_pessoa", column: "vendedor_id", name: "srg_transferencia_propriedade_ibfk_4", on_update: :cascade
end
