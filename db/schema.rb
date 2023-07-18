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

ActiveRecord::Schema.define(version: 2022_12_05_114820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "card_tokens", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "token"
    t.string "status"
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "brand"
    t.integer "security_code"
    t.string "holder"
    t.index ["client_id"], name: "index_card_tokens_on_client_id"
  end

  create_table "catalogo_competicaos", force: :cascade do |t|
    t.integer "qtd_inscritos"
    t.string "qtd_catalogos"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "qtd_inscritos_fim"
    t.bigint "competicaos_evento_id", null: false
    t.index ["competicaos_evento_id"], name: "index_catalogo_competicaos_on_competicaos_evento_id"
  end

  create_table "catalogo_nomes", force: :cascade do |t|
    t.string "nome"
    t.integer "ordem_nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "competicaos_evento_id", null: false
    t.index ["competicaos_evento_id"], name: "index_catalogo_nomes_on_competicaos_evento_id"
  end

  create_table "catalogos", force: :cascade do |t|
    t.string "nome_catalogo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "competicaos_evento_id", null: false
    t.bigint "inscricao_id", null: false
    t.bigint "catalogo_nome_id"
    t.integer "numero_colete"
    t.integer "numero_colete_progenie"
    t.index ["catalogo_nome_id"], name: "index_catalogos_on_catalogo_nome_id"
    t.index ["competicaos_evento_id"], name: "index_catalogos_on_competicaos_evento_id"
    t.index ["inscricao_id"], name: "index_catalogos_on_inscricao_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "cpf"
    t.string "email"
    t.string "phone"
    t.string "telephone"
    t.date "birthday"
    t.string "cep"
    t.string "address"
    t.string "number"
    t.string "complement"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "card_token_id"
    t.index ["card_token_id"], name: "index_clients_on_card_token_id"
    t.index ["organization_id"], name: "index_clients_on_organization_id"
  end

  create_table "cluster_criterios_avaliacaos", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "metodo"
    t.boolean "funcional", default: false
  end

  create_table "competicao_avalicaos", force: :cascade do |t|
    t.bigint "competicao_juri_id", null: false
    t.bigint "criterios_competicao_id", null: false
    t.bigint "inscricao_id", null: false
    t.float "nota"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "catalogo_id"
    t.string "ocorrencia"
    t.boolean "melhor_cabeca", default: false
    t.boolean "aprumacao", default: false
    t.float "tempo_executado"
    t.float "tempo_final"
    t.integer "classificacao"
    t.bigint "evento_id"
    t.float "nota_juri_desempate"
    t.index ["catalogo_id"], name: "index_competicao_avalicaos_on_catalogo_id"
    t.index ["competicao_juri_id"], name: "index_competicao_avalicaos_on_competicao_juri_id"
    t.index ["criterios_competicao_id"], name: "index_competicao_avalicaos_on_criterios_competicao_id"
    t.index ["evento_id"], name: "index_competicao_avalicaos_on_evento_id"
    t.index ["inscricao_id"], name: "index_competicao_avalicaos_on_inscricao_id"
  end

  create_table "competicao_desempates", force: :cascade do |t|
    t.bigint "competicaos_evento_id", null: false
    t.bigint "inscricao_id", null: false
    t.bigint "competicao_juri_id", null: false
    t.float "nota"
    t.bigint "criterios_competicao_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["competicao_juri_id"], name: "index_competicao_desempates_on_competicao_juri_id"
    t.index ["competicaos_evento_id"], name: "index_competicao_desempates_on_competicaos_evento_id"
    t.index ["criterios_competicao_id"], name: "index_competicao_desempates_on_criterios_competicao_id"
    t.index ["inscricao_id"], name: "index_competicao_desempates_on_inscricao_id"
  end

  create_table "competicao_juris", force: :cascade do |t|
    t.bigint "competicaos_evento_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "cluster_criterios_avaliacao_id"
    t.jsonb "store_cluster_criterio_avaliacao_id", default: []
    t.boolean "juri_desempate", default: false
    t.index ["cluster_criterios_avaliacao_id"], name: "index_competicao_juris_on_cluster_criterios_avaliacao_id"
    t.index ["competicaos_evento_id"], name: "index_competicao_juris_on_competicaos_evento_id"
    t.index ["user_id"], name: "index_competicao_juris_on_user_id"
  end

  create_table "competicaos", force: :cascade do |t|
    t.string "nome"
    t.bigint "modalidade_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "competicao_desempate"
    t.boolean "ajuste_nota"
    t.string "desempate_em"
    t.boolean "ajuste_nota_marchador", default: false
    t.boolean "categoria_unica", default: false
    t.index ["competicao_desempate"], name: "index_competicaos_on_competicao_desempate"
    t.index ["modalidade_id"], name: "index_competicaos_on_modalidade_id"
  end

  create_table "competicaos_eventos", force: :cascade do |t|
    t.bigint "competicao_id", null: false
    t.bigint "evento_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "metodo"
    t.boolean "catalogo_gerado"
    t.integer "ordem"
    t.index ["competicao_id"], name: "index_competicaos_eventos_on_competicao_id"
    t.index ["evento_id"], name: "index_competicaos_eventos_on_evento_id"
  end

  create_table "criterios_avaliacaos", force: :cascade do |t|
    t.string "nome"
    t.bigint "cluster_criterios_avaliacao_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cluster_criterios_avaliacao_id"], name: "index_criterios_avaliacaos_on_cluster_criterios_avaliacao_id"
  end

  create_table "criterios_competicaos", force: :cascade do |t|
    t.bigint "competicao_id", null: false
    t.bigint "criterios_avaliacao_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "peso"
    t.string "metodo"
    t.index ["competicao_id"], name: "index_criterios_competicaos_on_competicao_id"
    t.index ["criterios_avaliacao_id"], name: "index_criterios_competicaos_on_criterios_avaliacao_id"
  end

  create_table "dim_pdf_grande_campeaos", force: :cascade do |t|
    t.bigint "competicaos_evento_id"
    t.float "nota"
    t.integer "classificacao"
    t.string "animal"
    t.integer "colete"
    t.bigint "catalogo_id"
    t.bigint "criterios_competicao_id"
    t.string "posto_competicao"
    t.string "posto_final"
    t.integer "classificacao_final"
    t.float "nota_juri_desempate"
    t.index ["catalogo_id"], name: "index_dim_pdf_grande_campeaos_on_catalogo_id"
    t.index ["competicaos_evento_id"], name: "index_dim_pdf_grande_campeaos_on_competicaos_evento_id"
    t.index ["criterios_competicao_id"], name: "index_dim_pdf_grande_campeaos_on_criterios_competicao_id"
  end

  create_table "dim_pdf_marchas", force: :cascade do |t|
    t.bigint "competicaos_evento_id"
    t.string "posto_anterior"
    t.float "nota"
    t.integer "classificacao"
    t.string "animal"
    t.string "colete"
    t.bigint "catalogo_id"
    t.bigint "criterios_competicao_id"
    t.string "posto_competicao"
    t.integer "nota_juri_desempate"
    t.string "posto_final"
    t.integer "classificacao_final"
    t.index ["catalogo_id"], name: "index_dim_pdf_marchas_on_catalogo_id"
    t.index ["competicaos_evento_id"], name: "index_dim_pdf_marchas_on_competicaos_evento_id"
    t.index ["criterios_competicao_id"], name: "index_dim_pdf_marchas_on_criterios_competicao_id"
  end

  create_table "dim_pdf_morfologia", force: :cascade do |t|
    t.bigint "competicaos_evento_id"
    t.string "posto_anterior"
    t.float "nota"
    t.integer "classificacao"
    t.string "animal"
    t.string "colete"
    t.bigint "catalogo_id"
    t.bigint "criterios_competicao_id"
    t.string "posto_competicao"
    t.integer "nota_juri_desempate"
    t.string "posto_final"
    t.integer "classificacao_final"
    t.index ["catalogo_id"], name: "index_dim_pdf_morfologia_on_catalogo_id"
    t.index ["competicaos_evento_id"], name: "index_dim_pdf_morfologia_on_competicaos_evento_id"
    t.index ["criterios_competicao_id"], name: "index_dim_pdf_morfologia_on_criterios_competicao_id"
  end

  create_table "eventos", force: :cascade do |t|
    t.string "nome"
    t.date "dataInicio"
    t.date "dataFim"
    t.string "anoHipico"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ativo"
    t.date "data_avaliacao"
    t.string "aceitar_inadiplentes"
    t.bigint "user_id"
    t.integer "max_animais_categoria"
    t.integer "min_animais_categoria"
    t.integer "range_1_1"
    t.integer "range_2_1"
    t.integer "range_1_2"
    t.integer "range_2_2"
    t.integer "range_3_1"
    t.integer "range_3_2"
    t.integer "range_4_2"
    t.integer "range_4_1"
    t.integer "range_5_1"
    t.integer "range_5_2"
    t.integer "range_6_2"
    t.integer "range_6_1"
    t.integer "range_7_1"
    t.integer "range_7_2"
    t.integer "range_8_2"
    t.integer "range_8_1"
    t.integer "range_9_1"
    t.integer "range_9_2"
    t.integer "range_10_1"
    t.integer "range_10_2"
    t.integer "range_valor_1"
    t.integer "range_valor_2"
    t.integer "range_valor_3"
    t.integer "range_valor_4"
    t.integer "range_valor_5"
    t.integer "range_valor_6"
    t.integer "range_valor_7"
    t.integer "range_valor_8"
    t.integer "range_valor_9"
    t.integer "range_valor_10"
    t.index ["user_id"], name: "index_eventos_on_user_id"
  end

  create_table "eventos_users", id: false, force: :cascade do |t|
    t.bigint "evento_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "inscricaos", force: :cascade do |t|
    t.bigint "criador_id"
    t.bigint "expositor_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "evento_id", null: false
    t.string "pelagem"
    t.string "marcha"
    t.string "ano_hipico"
    t.string "srg_animal_id"
    t.string "srg_nome_animal"
    t.string "srg_registro_animal"
    t.boolean "so_marcha"
    t.integer "faixa_etaria"
    t.string "nome_animal"
    t.integer "pai_animal_id"
    t.integer "mae_animal_id"
    t.integer "faixa_etaria_dia"
    t.integer "num_registro_pai"
    t.integer "num_registro_mae"
    t.string "presenca_evento"
    t.string "sexo"
    t.index ["criador_id"], name: "index_inscricaos_on_criador_id"
    t.index ["evento_id"], name: "index_inscricaos_on_evento_id"
    t.index ["expositor_id"], name: "index_inscricaos_on_expositor_id"
  end

  create_table "inscricaos_competicaos", force: :cascade do |t|
    t.bigint "inscricao_id", null: false
    t.bigint "competicao_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "evento_id"
    t.float "nota_final"
    t.bigint "competicaos_evento_id"
    t.boolean "empate"
    t.float "nota_desempate"
    t.boolean "nota_final_melhor_cabeca"
    t.boolean "nota_final_melhor_aprumo"
    t.string "posto"
    t.float "nota_final_sem_ajuste"
    t.string "observacao_final"
    t.string "posto_anterior"
    t.integer "campeao"
    t.integer "campeao_anterior"
    t.integer "progenie_id"
    t.integer "acasalamento_mae_id"
    t.integer "acasalamento_pai_id"
    t.integer "grupo_progenie"
    t.float "nota_final_ajustada"
    t.string "responsavel_expositor"
    t.jsonb "campeao_anterior_json", default: []
    t.index ["competicao_id"], name: "index_inscricaos_competicaos_on_competicao_id"
    t.index ["competicaos_evento_id"], name: "index_inscricaos_competicaos_on_competicaos_eventos_id"
    t.index ["evento_id"], name: "index_inscricaos_competicaos_on_evento_id"
    t.index ["inscricao_id"], name: "index_inscricaos_competicaos_on_inscricao_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "url"
    t.string "slug"
    t.integer "clicked", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "modalidades", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "company_name"
    t.string "trading_name"
    t.string "name"
    t.string "cnpj"
    t.string "statutory_registration"
    t.string "cielo_merchant_id"
    t.string "cielo_merchant_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "config", default: {}
    t.integer "bank_slip_sequency", default: 1
    t.string "uuid"
  end

  create_table "parametro_inscricaos", force: :cascade do |t|
    t.string "nome"
    t.bigint "competicao_id", null: false
    t.string "coluna_parametro"
    t.string "operador_parametro"
    t.string "valor_parametro"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "comp_or_table"
    t.integer "comp_posicao_inicio"
    t.integer "comp_posicao_fim"
    t.integer "competicao_antecessora"
    t.string "melhor_indicacao_select"
    t.string "tipo_marcha_select"
    t.string "operador_fusao"
    t.integer "fusao_competicao_antecessora_id"
    t.integer "criterio_competicao_antecessora"
    t.index ["competicao_id"], name: "index_parametro_inscricaos_on_competicao_id"
    t.index ["fusao_competicao_antecessora_id"], name: "index_parametro_inscricaos_on_fusao_competicao_antecessora_id"
  end

  create_table "pessoas", force: :cascade do |t|
    t.string "nome"
    t.string "email"
    t.string "status"
    t.string "cpf"
    t.string "cep"
    t.string "endereco"
    t.string "numero"
    t.string "bairro"
    t.string "cidade"
    t.string "uf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "fazenda"
  end

  create_table "podios", force: :cascade do |t|
    t.string "descricao"
    t.integer "posicao"
    t.boolean "exibir_home"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "pontuacao"
    t.float "pontuacao_expositor"
    t.float "pontuacao_criador"
    t.bigint "catalogo_nome_id"
    t.boolean "exibir_relatorio"
    t.index ["catalogo_nome_id"], name: "index_podios_on_catalogo_nome_id"
  end

  create_table "premios", force: :cascade do |t|
    t.bigint "inscricaos_competicao_id"
    t.integer "inscricao_id"
    t.integer "numero_colete"
    t.string "posto"
    t.integer "inscricao_campeao_id"
    t.bigint "competicaos_evento_id"
    t.float "pontuacao"
    t.string "expositor"
    t.float "pontuacao_expositor"
    t.string "criador"
    t.string "pontuacao_criador"
    t.string "nome_catalogo"
    t.integer "animais_julgados"
    t.string "nome_animal"
    t.index ["competicaos_evento_id"], name: "index_premios_on_competicaos_evento_id"
    t.index ["inscricaos_competicao_id"], name: "index_premios_on_inscricaos_competicao_id"
  end

  create_table "rankings", force: :cascade do |t|
    t.string "tipo"
    t.integer "identificacao"
    t.string "nome"
    t.integer "pontuacao"
    t.integer "ano_hipico"
  end

  create_table "srg_animals", force: :cascade do |t|
    t.string "nome"
    t.string "nome_completo"
    t.string "numero_chip"
    t.string "sexo"
    t.string "pai"
    t.string "mae"
    t.date "data_nascimento"
    t.string "fazenda_nascimento"
    t.string "cidade_nascimento"
    t.string "uf_nascimento"
    t.string "criador"
    t.string "proprietario"
    t.string "pelagem_padrao"
    t.string "pelagem"
    t.string "dna_tipo"
    t.date "dna_data_exame"
    t.string "dna_laboratorio"
    t.string "homozigose_tipo"
    t.date "homozigose_data_exame"
    t.string "homozigose_laboratorio"
    t.string "dna_exposicao_nome"
    t.date "dna_exposicao_ano"
    t.string "clone"
    t.date "data_clone"
    t.string "laboratorio_clone"
    t.string "animal_origem"
    t.date "data_castracao"
    t.date "data_baixa"
    t.string "motivo_baixa"
    t.string "status"
    t.date "data_desbloqueio"
    t.string "observacoes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "srg_pessoas", force: :cascade do |t|
    t.string "nome"
    t.string "codigo"
    t.string "telefone"
    t.string "celular"
    t.string "email"
    t.string "tipo_pessoa"
    t.string "cpf"
    t.string "cnpj"
    t.string "rg"
    t.string "cidade_nascimento"
    t.string "contato"
    t.integer "associado_endereco_fazenda"
    t.string "associado_nome_fazenda"
    t.string "associado_cidade_fazenda"
    t.integer "associado_estado_fazenda"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tipo_usuario"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "card_tokens", "clients"
  add_foreign_key "catalogo_competicaos", "competicaos_eventos"
  add_foreign_key "catalogo_nomes", "competicaos_eventos"
  add_foreign_key "catalogos", "catalogo_nomes"
  add_foreign_key "catalogos", "competicaos_eventos"
  add_foreign_key "catalogos", "inscricaos"
  add_foreign_key "clients", "card_tokens"
  add_foreign_key "clients", "organizations"
  add_foreign_key "competicao_avalicaos", "catalogos"
  add_foreign_key "competicao_avalicaos", "competicao_juris"
  add_foreign_key "competicao_avalicaos", "criterios_competicaos"
  add_foreign_key "competicao_avalicaos", "eventos"
  add_foreign_key "competicao_avalicaos", "inscricaos"
  add_foreign_key "competicao_desempates", "competicao_juris"
  add_foreign_key "competicao_desempates", "competicaos_eventos"
  add_foreign_key "competicao_desempates", "criterios_competicaos"
  add_foreign_key "competicao_desempates", "inscricaos"
  add_foreign_key "competicao_juris", "cluster_criterios_avaliacaos"
  add_foreign_key "competicao_juris", "competicaos_eventos"
  add_foreign_key "competicao_juris", "users"
  add_foreign_key "competicaos", "competicaos", column: "competicao_desempate"
  add_foreign_key "competicaos", "modalidades"
  add_foreign_key "competicaos_eventos", "competicaos"
  add_foreign_key "competicaos_eventos", "eventos"
  add_foreign_key "criterios_avaliacaos", "cluster_criterios_avaliacaos"
  add_foreign_key "criterios_competicaos", "competicaos"
  add_foreign_key "criterios_competicaos", "criterios_avaliacaos"
  add_foreign_key "dim_pdf_grande_campeaos", "catalogos"
  add_foreign_key "dim_pdf_grande_campeaos", "competicaos_eventos"
  add_foreign_key "dim_pdf_grande_campeaos", "criterios_competicaos"
  add_foreign_key "dim_pdf_marchas", "catalogos"
  add_foreign_key "dim_pdf_marchas", "competicaos_eventos"
  add_foreign_key "dim_pdf_marchas", "criterios_competicaos"
  add_foreign_key "dim_pdf_morfologia", "catalogos"
  add_foreign_key "dim_pdf_morfologia", "competicaos_eventos"
  add_foreign_key "dim_pdf_morfologia", "criterios_competicaos"
  add_foreign_key "eventos", "users"
  add_foreign_key "inscricaos", "eventos"
  add_foreign_key "inscricaos", "pessoas", column: "criador_id"
  add_foreign_key "inscricaos", "pessoas", column: "expositor_id"
  add_foreign_key "inscricaos_competicaos", "competicaos"
  add_foreign_key "inscricaos_competicaos", "competicaos_eventos"
  add_foreign_key "inscricaos_competicaos", "eventos"
  add_foreign_key "inscricaos_competicaos", "inscricaos"
  add_foreign_key "parametro_inscricaos", "competicaos"
  add_foreign_key "podios", "catalogo_nomes"
  add_foreign_key "premios", "competicaos_eventos"
  add_foreign_key "premios", "inscricaos_competicaos"
end
