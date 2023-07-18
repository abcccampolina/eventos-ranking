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

ActiveRecord::Schema.define(version: 2020_07_09_161911) do

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

  create_table "bank_slips", force: :cascade do |t|
    t.string "status"
    t.string "cedente"
    t.string "documento_cedente"
    t.string "sacado"
    t.string "sacado_documento"
    t.float "valor"
    t.string "agencia"
    t.string "conta_corrente"
    t.string "convenio"
    t.string "nosso_numero"
    t.date "data_vencimento"
    t.date "data_documento"
    t.string "instrucao1"
    t.string "instrucao2"
    t.string "instrucao3"
    t.string "instrucao4"
    t.string "instrucao5"
    t.string "instrucao6"
    t.string "sacado_endereco"
    t.bigint "contract_id", null: false
    t.bigint "remittance_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "paid"
    t.index ["contract_id"], name: "index_bank_slips_on_contract_id"
    t.index ["remittance_id"], name: "index_bank_slips_on_remittance_id"
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

  create_table "contracts", force: :cascade do |t|
    t.string "status"
    t.string "payment_type"
    t.bigint "client_id", null: false
    t.date "recurrence_expiration"
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "card_token_id"
    t.jsonb "bank_slip_data", default: []
    t.bigint "remittance_id"
    t.bigint "organization_id"
    t.integer "bank_slip_sequence", default: 1
    t.integer "quantity_months", default: 12
    t.date "first_payment"
    t.string "uuid"
    t.index ["card_token_id"], name: "index_contracts_on_card_token_id"
    t.index ["client_id"], name: "index_contracts_on_client_id"
    t.index ["organization_id"], name: "index_contracts_on_organization_id"
    t.index ["remittance_id"], name: "index_contracts_on_remittance_id"
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

  create_table "payment_events", force: :cascade do |t|
    t.string "status"
    t.string "payment_type"
    t.bigint "client_id", null: false
    t.bigint "contract_id", null: false
    t.integer "card_token_id"
    t.date "processing_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "amount"
    t.integer "processed_count", default: 0
    t.string "last_message"
    t.boolean "retryable", default: true
    t.boolean "card_error", default: false
    t.jsonb "bank_slip_data", default: {}
    t.index ["card_token_id"], name: "index_payment_events_on_card_token_id"
    t.index ["client_id"], name: "index_payment_events_on_client_id"
    t.index ["contract_id"], name: "index_payment_events_on_contract_id"
  end

  create_table "payment_helpers", force: :cascade do |t|
    t.string "status"
    t.float "amount"
    t.bigint "payment_event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "data", default: {}
    t.index ["payment_event_id"], name: "index_payment_helpers_on_payment_event_id"
  end

  create_table "recurrences", force: :cascade do |t|
    t.string "status"
    t.string "type"
    t.string "amount"
    t.bigint "client_id", null: false
    t.date "processing_date"
    t.date "reprocessing_date"
    t.date "recurrence_validity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "card_token_id"
    t.jsonb "data", default: {}
    t.index ["card_token_id"], name: "index_recurrences_on_card_token_id"
    t.index ["client_id"], name: "index_recurrences_on_client_id"
  end

  create_table "remittances", force: :cascade do |t|
    t.string "remittance_type"
    t.bigint "organization_id", null: false
    t.integer "number"
    t.string "status"
    t.string "file_name"
    t.string "raw_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_remittances_on_organization_id"
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
    t.bigint "organization_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bank_slips", "contracts"
  add_foreign_key "bank_slips", "remittances"
  add_foreign_key "card_tokens", "clients"
  add_foreign_key "clients", "card_tokens"
  add_foreign_key "clients", "organizations"
  add_foreign_key "contracts", "card_tokens"
  add_foreign_key "contracts", "clients"
  add_foreign_key "contracts", "organizations"
  add_foreign_key "contracts", "remittances"
  add_foreign_key "payment_events", "card_tokens"
  add_foreign_key "payment_events", "clients"
  add_foreign_key "payment_events", "contracts"
  add_foreign_key "payment_helpers", "payment_events"
  add_foreign_key "recurrences", "card_tokens"
  add_foreign_key "recurrences", "clients"
  add_foreign_key "remittances", "organizations"
  add_foreign_key "users", "organizations"
end
