class DatabaseSync
  # QUERY_PESSOA_MYSQL = <<-SQL
  #   CREATE TABLE "srg_pessoa" (
  #     "id" bigserial primary key,
  #     "nome" character varying,
  #     "codigo" character varying,
  #     "datahora_cadastro" timestamp,
  #     "data_nascimento" date,
  #     "sexo" character varying,
  #     "estado_civil" character varying,
  #     "telefone" character varying,
  #     "celular" character varying,
  #     "fax" character varying,
  #     "email" character varying,
  #     "login" character varying,
  #     "senha" character varying,
  #     "datahora_ultimo_login" timestamp,
  #     "observacoes" text,
  #     "tipo_pessoa" character varying,
  #     "cpf" character varying,
  #     "rg" character varying,
  #     "cidade_nascimento" character varying,
  #     "conjuge_nome" character varying,
  #     "escolaridade" integer,
  #     "profissao" integer,
  #     "cnpj" character varying,
  #     "contato" character varying,
  #     "indicacao_de" character varying,
  #     "inscricao_estadual" character varying,
  #     "inscricao_municipal" character varying,
  #     "credenciado_data_inscricao" date,
  #     "credenciado_crmv" character varying,
  #     "credenciado_crea" character varying,
  #     "credenciado_area_atuacao" character varying,
  #     "credenciado_data_baixa" date,
  #     "associado_data_inscricao" date,
  #     "associado_tipo_afixo" character varying,
  #     "associado_afixo" character varying,
  #     "associado_preposicao" character varying,
  #     "associado_endereco_fazenda" integer,
  #     "associado_nome_fazenda" character varying,
  #     "associado_cidade_fazenda" character varying,
  #     "associado_estado_fazenda" integer,
  #     "associado_data_baixa" date,
  #     "associado_numero_inscricao_produtor_rural" character varying,
  #     "status" character varying,
  #     "qtd_animais" integer
  #   );
  # SQL

  # QUERY_ANIMAL_MYSQL = <<-SQL
  #   CREATE TABLE "srg_animal" (
  #     "id" bigserial primary key,
  #     "nome" character varying,
  #     "nome_completo" character varying,
  #     "numero_chip" character varying,
  #     "sexo" character varying,
  #     "pai" integer,
  #     "mae" integer,
  #     "data_nascimento" date,
  #     "fazenda_nascimento" character varying,
  #     "cidade_nascimento" character varying,
  #     "uf_nascimento" integer,
  #     "criador" integer,
  #     "proprietario" integer,
  #     "pelagem_padrao" integer,
  #     "pelagem" character varying,
  #     "dna_tipo" character varying,
  #     "dna_data_exame" date,
  #     "dna_laboratorio" integer,
  #     "homozigose_tipo" character varying,
  #     "homozigose_data_exame" date,
  #     "homozigose_laboratorio" integer,
  #     "dna_exposicao_nome" character varying,
  #     "dna_exposicao_ano" integer,
  #     "clone" character varying,
  #     "data_clone" date,
  #     "laboratorio_clone" integer,
  #     "animal_origem" integer,
  #     "data_castracao" date,
  #     "data_baixa" date,
  #     "motivo_baixa" character varying,
  #     "status" character varying,
  #     "data_desbloqueio" date,
  #     "observacoes" text
  #   );
  # SQL
  
  def initialize
    @db2 = SQLite3::Database.open "db/mysql_dev2.sqlite3"
    @db = SQLite3::Database.open "db/postgres_dev2.sqlite3"

    # @db2.execute(QUERY_PESSOA_MYSQL) if !(@db2.execute "select * from srg_pessoa" rescue nil)
    # @db2.execute(QUERY_ANIMAL_MYSQL) if !(@db2.execute "select * from srg_animal" rescue nil)

    @models = YAML.load_file('db/sync.yml')
  end

  def clear
    @models[:mysql].each do |i|
      model_obj = i.classify.constantize
      puts "Limpando Tabela '#{i}'"
      @db2.execute("DELETE FROM #{model_obj.table_name};")
    end

    @models[:pg].each do |i|
      model_obj = i.classify.constantize
      puts "Limpando tabelas internas:' #{i}'"
      @db.execute("DELETE FROM #{model_obj.table_name};")
    end
  end
  
  def perform
    @total_data = get_count_db(@models[:pg], @db) + get_count_db(@models[:mysql], @db2)
    @processed = 0
    puts "Sincronizando dados\n\n"
    perform_sync(@models[:mysql], @db2)    
    perform_sync(@models[:pg], @db)
  end

  private
    def get_count_db(models, db)
      models.map do |i|
        model_obj = i.classify.constantize
        model_obj.count
        # db.execute("SELECT COUNT(*) FROM #{model_obj.table_name};").first&.first || 0
      end.sum
    end
    def perform_sync(database, db)
      database.each do |i|
        model_obj = i.classify.constantize
        query =  data_to_sql_query(model_obj)
        query&.each do |q|
          @processed += 1
          delta = (100.0 / (@total_data+1)) * @processed
          delta = [0, delta - 1].max.to_i
          print "\r #{@processed}/#{@total_data} [#{'=' * delta}#{' ' * ([0, 100 - delta].max)}] #{delta}%", ""
          db.execute(q)
        end
      end
    end

    def data_to_sql_query(model)
      # model.columns.map(&:name)
      datas = model.all
      if datas.present?
        datas = datas.map { |i| accert_values(i.attributes) }
        query = datas.map do |data|
          <<-SQL
            INSERT INTO "#{model.table_name}" (#{data.keys.map {|i| "\"#{i}\"" }.join(',')}) VALUES (#{data.values.join(',')})
          SQL
        end
        query.unshift("DELETE FROM #{model.table_name};")
      else
        return nil
      end
      # INSERT INTO "users" ("name","email","encrypted_password", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5)
    end
    
    def accert_values(values)
      values.map do |key, value|
        v = if value.is_a?(ActiveSupport::TimeWithZone)
          "\"#{value.to_s(:iso8601)}\""
        elsif value.is_a?(Date)
          "\"#{value.to_s(:db)}\""
        elsif value.is_a?(String)
          "\"#{value.to_s.gsub('"', )}\""
        elsif value.nil?
          "null"
        elsif value.is_a?(Array) || value.is_a?(Hash)
          "'#{value.to_json}'"
        else
          value
        end
        [key, v]
      end.to_h
    end
end
