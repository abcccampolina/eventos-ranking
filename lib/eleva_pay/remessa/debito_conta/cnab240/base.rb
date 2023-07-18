module ElevaPay
  module Remessa
    module DebitoConta
      module Cnab240
        class Base

          include ElevaPay::Validations
          # include Brcobranca::Validations
          # include ActiveModel::Validations
          # extend ElevaPay::Validations::ClassMethods

          attr_accessor :convenio
          attr_accessor :agencia
          attr_accessor :conta
          attr_accessor :pagamentos
          attr_accessor :documento_cedente
          attr_accessor :parametro_transmissao

          
          attr_accessor :sequencial_remessa
          
          attr_accessor :nome_empresa

          attr_accessor :codigo_compromisso    # Header de lote - verificar a origem do código
          attr_accessor :parametro_transmissao # Header de lote - verificar a origem do código
          attr_accessor :mensagem_1

          # Entender quais os casos devem ser aplicados:
          #   - #R01


          validates_presence_of :pagamentos, :convenio, :nome_empresa,
                                :message => 'não pode estar em branco.'
          validates_length_of :parametro_transmissao, is: 2, message: 'tamanho não aceito'
          # validates_length_of :ambiente_cliente, is: 1, message: 'tamanho não aceito'
          


          def initialize(campos = {})
            campos = {
              pagamentos: []
            }.merge!(campos)
            campos.each {|k,v| self.send("#{k}=", v)}
          end


          # Retorna o Dígito Verificador
          # @return [String] header do arquivo
          def header_arquivo
            raise(ElevaPay::RemessaInvalida, "Parâmetros inválidos: #{self.errors.full_messages.join("\n")}") if self.invalid?
            header_arquivo = ""
            header_arquivo << codigo_banco                                     # Código do Banco
            header_arquivo << "0000"                                           # Lote de serviço
            header_arquivo << "0"                                              # Código de Registro
            header_arquivo << "".rjust(9)                                      # Filer
            header_arquivo << tipo_inscricao(numero_inscricao)                 # Tipo de inscrição
            header_arquivo << f_numero_inscricao(numero_inscricao)             # Número de inscrição
            # header_arquivo << convenio.to_s.rjust(6, '0')                      # Código convênio no Banco
            header_arquivo << codigo_convenio                           # codigo do convenio no banco
            header_arquivo << ambiente_cliente                                 # Ambiente Cliente
            # header_arquivo << " "                                              # Ambiente Banco
            header_arquivo << "".rjust(3, ' ')                                 # Origem Aplicativo
            header_arquivo << "0000"                                           # Número de Versão
            header_arquivo << "  "                                             # Filler
            header_arquivo << agencia.to_s.rjust(5, '0')                       # Agencia da conta corrente
            header_arquivo << calcular_dv(agencia.to_s)                        # DV da Agência
            header_arquivo << conta.to_s.rjust(12, '0')                        # Número da conta
            header_arquivo << calcular_dv(conta.to_s)                          # DV Número da conta
            header_arquivo << " "                                              # DV da Agência/Conta
            header_arquivo << nome_empresa.normalize.upcase.rjust(30)          # Nome da empresa
            header_arquivo << nome_banco.normalize.upcase.rjust(30)            # Nome do banco
            header_arquivo << "".rjust(10)                                     # Filler
            header_arquivo << "1"                                              # Tipo de Arquivo | 1- Empresa \ 2 - Banco
            header_arquivo << data_geracao()                                   # Data geração do arquivo
            header_arquivo << hora_geracao()                                   # Hora geração do arquivo
            header_arquivo << sequencial_remessa.to_s.rjust(6)                 # NSA
            header_arquivo << versao_layout_arquivo                            # Versão leiaute do arquivo
            header_arquivo << densidade_gravacao                               # Densidade de gravação
            header_arquivo << "".rjust(20)                                     # Reservado do Banco
            header_arquivo << "".rjust(20)                                     # Reservado da Empresa
            header_arquivo << "".rjust(11)                                     # Uso exclusivo FEBRABAN
            header_arquivo << "".rjust(3)                                      # Ident. Cobrança
            
            header_arquivo << "".rjust(3, '0')                                 # Uso exclusivo das VAN
            header_arquivo << "".rjust(10)                                      # Ocorrência Cob. Sem papel
          end


          # Monta o registro header do lote
          #
          # @param numero_lote [Integer]
          #   numero do lote no arquivo (iterar a cada novo lote)
          #
          # @return [String]
          #
          def header_lote(numero_lote: , logradouro: , cidade: , uf: , cep: , numero_residencia: , mensagem: "")
            cep = cep.split('-')
            header_lote = ''                                              # CAMPO                   TAMANHO  DESCRIÇÃO
            header_lote << codigo_banco                                   # codigo banco            3
            header_lote << numero_lote.to_s.rjust(4, '0')                 # lote servico            4
            header_lote << '1'                                            # codigo de registro      1
            header_lote << 'D'                                            # Tipo de Operação        1
            header_lote << '05'                                           # Tipo de Serviço         2
            header_lote << '50'                                           # Forma de Lançamento     2         50 =  Débito em conta corrente – recebimento
            header_lote << versao_layout_lote                             # V. layout do lote       3
            header_lote << ' '                                            # Filter                  1
            header_lote << tipo_inscricao(numero_inscricao)               # Tipo de inscrição       1
            header_lote << documento_cedente.to_s.rjust(14, '0')          # Número da inscrição     14
            header_lote << convenio_lote                                  # Código convênio Lote    6
            header_lote << '11'                                           # Tipo de Compromisso     2          11 = Débito em Conta
            header_lote << codigo_compromisso.to_s.rjust(4, '0')          # Código do Compromisso   4
            header_lote << parametro_transmissao.to_s.rjust(2, ' ')       # Prm transmissão         2
            header_lote << ''.rjust(6, ' ')                               # Filter                  6
            header_lote << agencia.to_s.rjust(5, '0')                     # AG Conta Corrente       5
            header_lote << calcular_dv(agencia.to_s)                      # DV da Agência           1
            header_lote << conta.to_s.rjust(12, '0')                      # Número da conta         12
            header_lote << calcular_dv(conta.to_s)                        # DV Número da conta      1
            header_lote << ' '                                            # Dígito da Ag/Conta      1
            header_lote << normalizar_texto(empresa_mae, 30)              # Nome da Empresa         30
            header_lote << normalizar_texto(mensagem, 40)                 # Mensagem                40
            header_lote << normalizar_texto(logradouro, 30)               # Logradouro              30
            header_lote << numero_residencia.to_s.rjust(5, '0')           # Número no local         5
            header_lote << normalizar_texto(complemento, 15)              # Complemento             15
            header_lote << normalizar_texto(cidade, 20)                   # Cidade                  20
            header_lote << cep.first.rjust(5, '0')                        # CEP                     5
            header_lote << cep.last.rjust(3, '0')                         # CEP Complemento         3
            header_lote << uf.rjust(2, ' ')                               # UF Estado               2
            header_lote << uf.format_size(18)                             # FEBRABAN - Ocorrências  18
            header_lote
          end

          # Monta o registro A do lote
          #
          # @param numero_lote [Integer]
          #   numero do lote no arquivo (iterar a cada novo lote)
          # @param nsr [Integer]
          #   numero sequencial do registro (iterar a cada novo registro)
          # @param numero_documento [Integer]
          #    Número do Documento(sequencial) (iterar a cada novo registro)
          #
          # @return [String]
          #
          def registro_a(
            numero_lote: , nsr: , banco_destino: , agencia_destino: , dv_agencia_destino: ,
            conta_destino: , dv_conta_destino: , nome_favorecido: , numero_documento: ,
            vencimento: , valor: , qtd_parcelas: , dia_vencimento: , numero_parcela: )
            
            registro_a = ''                                              # CAMPO                                      TAMANHO  DESCRIÇÃO  ORIGEM
            registro_a << codigo_banco                                   # codigo banco                               3        A.01
            registro_a << formata_numero(numero_lote, 4)                 # Lote de Serviço                            4        A.02
            registro_a << '3'                                            # Código do registro                         1        A.03
            registro_a << formata_numero(nsr, 3)                         # NSR                                        5        A.04
            registro_a << 'A'                                            # Cód. Segmento                              1        A.05
            registro_a << tipo_movimento                                 # Tipo Movimento                             1        A.06
            registro_a << '00'                                           # Código Instrução Movimento                 2        A.07
            registro_a << camara_compensacao                             # Câmara compensação                         3        A.08
            registro_a << formata_numero(banco_destino, 3)               # Código Banco Destino                       3        A.09
            registro_a << formata_numero(agencia_destino, 5)             # Código Agencia Destino                     5        A.10
            registro_a << formata_numero(dv_agencia_destino, 1)          # DV Agência Destino                         1        A.11
            registro_a << formata_numero(conta_destino, 12)              # Conta Corrente Destino                     12       A.12
            registro_a << formata_numero(dv_conta_destino, 1)            # DV Conta Destino                           1        A.13
            registro_a << ' '                                            # DV Agência/Conta Destino                   1        A.14
            registro_a << normalizar_texto(nome_favorecido, 30)          # Nome do Terceiro                           30       A.15
            registro_a << formata_numero(numero_documento, 6)            # N. Documento atribuído pela Empresa        6        A.16
            registro_a << ''.format_size(13)                             # Filter                                     13       A.17
            registro_a << tipo_conta_ra                                  # Tipo de conta – Finalidade TED             1        A.18
            registro_a << converter_data(vencimento)                     # Data Vencimento                            8        A.19
            registro_a << 'BRL'                                          # Tipo da moeda                              3        A.20
            registro_a << formata_numero(0, 10)                          # Quantidade de moeda                        10       A.21
            registro_a << formata_numero(valor, 13)                      # Valor Lançamento                           13       A.22
            registro_a << formata_numero(0, 9)                           # Número Documento Banco                     9        A.23
            registro_a << ''.format_size(3)                              # Filter                                     3        A.24
            registro_a << formata_numero(qtd_parcelas, 2)                # Quantidade de Parcelas                     2        A.25
            registro_a << indicador_bloqueio                             # Indicador de bloqueio                      1        A.26
            registro_a << '1'                                            # Indicador forma parcelamento               1        A.27
            registro_a << formata_numero(dia_vencimento, 2)              # Período ou dia vencimento                  2        A.28
            registro_a << formata_numero(numero_parcela, 2)              # Número Parcela                             2        A.29
            registro_a << formata_numero(0, 8)                           # Data da Efetivação                         8        A.30       Arquivo Retorno
            registro_a << formata_numero(0, 13)                          # Valor Real Efetivado                       13       A.31       Arquivo Retorno
            registro_a << ''.format_size(40)                             # Informação 2                               40       A.32
            registro_a << '00'                                           # Finalidade DOC                             2        A.33
            registro_a << ''.format_size(21)                             # FEBRABAN - Av. ao Favo. - Ocorrências      21       A.34-35-36
            registro_a
          end

          # Monta o Registro B do lote
          #
          # @param numero_lote [Integer]
          #   numero do lote no arquivo (iterar a cada novo lote)
          # @param nsr [Integer]
          #   numero sequencial do registro (iterar a cada novo registro)
          # @param documento [String]
          #    Documento(CPF/CNPJ)
          # @param numero_documento [Integer]
          #    Número do Documento(sequencial) (iterar a cada novo registro)
          #
          # @return [String]
          #
          def registro_b(
            numero_lote: , nsr: , documento: , logradouro: , numero: , complemento: , bairro: ,
            cidade: , cep: , uf: , vencimento: )
            _cep, _cep_c = cep.split('-')
            registro_b = ''                                              # CAMPO                                      TAMANHO  DESCRIÇÃO  ORIGEM
            registro_b << codigo_banco                                   # codigo banco                               3        B.01
            registro_b << formata_numero(numero_lote, 4)                 # Lote de Serviço                            4        B.02
            registro_b << '3'                                            # Código do registro                         1        B.03
            registro_b << formata_numero(nsr, 3)                         # NSR                                        5        B.04
            registro_b << 'B'                                            # Cód. Segmento                              1        B.05
            registro_b << ''.format_size(3)                              # Uso FEBRABAN                               3        B.06
            registro_b << tipo_inscricao(documento)                      # Tipo Inscrição                             1        B.07
            registro_b << f_numero_inscricao(numero_inscricao)           # Número Inscrição                           14       B.08
            registro_b << normalizar_texto(logradouro, 30)               # Logradouro                                 30       B.09
            registro_b << formata_numero(nsr, 5)                         # Número no local                            5        B.10
            registro_b << normalizar_texto(complemento, 15)              # Complemento                                15       B.11
            registro_b << normalizar_texto(bairro, 15)                   # Bairro                                     15       B.12
            registro_b << normalizar_texto(cidade, 15)                   # Cidade                                     20       B.13
            registro_b << formata_numero(_cep, 5)                        # CEP                                        5        B.14
            registro_b << formata_numero(_cep_c, 5)                      # Complemento CEP                            3        B.15
            registro_b << normalizar_texto(uf, 2)                        # UF                                         2        B.16
            registro_b << converter_data(vencimento)                     # Data Vencimento                            8        B.17
              registro_b << formata_numero(0, 13)                          # Valor do Documento                         13       B.18
            registro_b << formata_numero(0, 13)                          # Valor do Abatimento                        13       B.19
            registro_b << formata_numero(0, 13)                          # Valor do Desconto                          13       B.20
            registro_b << formata_numero(0, 13)                          # Valor da Mora                              13       B.21
            registro_b << formata_numero(0, 13)                          # Valor da Multa                             13       B.22
            registro_b << normalizar_texto(nil, 15)                      # Código Documento Favorecido                15       B.23
            registro_b << ''.format_size(15)                             # Uso da FEBRABAN                            15       B.24
            registro_b
          end



          def trailer_lote(numero_lote: , quantidade_reg_lote: , somatoria_valores: )
            trailer = ''                                              # CAMPO                                      TAMANHO  DESCRIÇÃO  ORIGEM
            trailer << codigo_banco                                   # codigo banco                               3        5.01
            trailer << formata_numero(numero_lote, 4)                 # Lote de Serviço                            4        5.02
            trailer << '5'                                            # Código do registro                         1        5.03
            trailer << ''.format_size(9)                              # Uso exclusivo FEBRABAN                     9        5.04
            trailer << formata_numero(quantidade_reg_lote, 6)         # Quantidade de Registros no Lote            6        5.05
            trailer << formata_numero(somatoria_valores, 16)          # Somatória dos Valores                      16       5.06
            trailer << formata_numero(0, 13)                          # Somatório Qtde Moeda                       13       5.07
            trailer << formata_numero(0, 6)                           # Número Aviso Débito                        6        5.08
            trailer << ''.format_size(175)                            # Uso exclusivo FEBRABAN-2 | Ocorrencias     175      5.09 | 5.10
            trailer
          end


          def trailer_arquivo(numero_lote: , quantidade_lote_arquivo: , quantidade_reg_arquivo: )
            trailer = ''                                              # CAMPO                                      TAMANHO  DESCRIÇÃO  ORIGEM
            trailer << codigo_banco                                   # Código do Banco                            3        9.01
            trailer << formata_numero(numero_lote, 4)                 # Lote de Serviço                            4        9.02
            trailer << '5'                                            # Código do registro                         1        9.03
            trailer << ''.format_size(9)                              # Uso exclusivo FEBRABAN                     9        9.04
            trailer << formata_numero(quantidade_lote_arquivo, 6)     # Quantidade de Lotes no Arquivo             6        9.05
            trailer << formata_numero(quantidade_reg_arquivo,  6)     # Quantidade de Registro do Arquivo          6        9.06
            trailer << formata_numero(0, 6)                           # Quantidade de Contas para Conciliação      6        9.07
            trailer << ''.format_size(206)                            # Uso exclusivo FEBRABAN                     205      9.09

            trailer
          end
          
          
          
          def tipo_movimento
            # "0" faz inclusão e "9" a exclusão.
            # - Serve nesse caso para adicionar ou excluir
            "0"
          end

          def camara_compensacao
            # _-_- Entender qual caso Aplicar #R01 -_-_
            # "018" – Finalidade TED 
            # "700" – Finalidade DOC e OP 
            # "000" – Crédito em Conta 
            # "888" – Boleted/ISPB
            "000"
          end

          
          
          def montar_arquivo()
            # header_arquivo
            # Header Lotes N
            # header_lote(nro_lote: , logradouro: , cidade: , uf: , cep: , numero_residencia: , mensagem: "")
          end
          
          # Método deve ser sobreescrito na clase
          def codigo_banco
            raise ElevaPay::NaoImplementado, 'Sobreescreva este método na classe referente ao banco que você esta criando'
          end
          
          # Método deve ser sobreescrito na clase
          def ambiente_cliente
            raise ElevaPay::NaoImplementado, 'Sobreescreva este método na classe referente ao banco que você esta criando'
          end
          
          # Método deve ser sobreescrito na clase
          def nome_banco
            raise ElevaPay::NaoImplementado, 'Sobreescreva este método na classe referente ao banco que você esta criando'
          end
          
          # Método deve ser sobreescrito na clase
          def codigo_convenio
            raise ElevaPay::NaoImplementado, 'Sobreescreva este método na classe referente ao banco que você esta criando'
          end
          
          # Método deve ser sobreescrito na clase
          def convenio_lote
            raise ElevaPay::NaoImplementado, 'Sobreescreva este método na classe referente ao banco que você esta criando'
          end
          
          # Método deve ser sobreescrito na clase
          def tipo_conta_ra
            raise ElevaPay::NaoImplementado, 'Sobreescreva este método na classe referente ao banco que você esta criando'
          end
          
          # Método deve ser sobreescrito na clase
          def indicador_bloqueio
            raise ElevaPay::NaoImplementado, 'Sobreescreva este método na classe referente ao banco que você esta criando'
          end

          def data_geracao
            converter_data(Date.current)
          end

          def hora_geracao
            converter_data(DateTime.current, "%H%M%S")
          end

          def versao_layout_lote
            '041'
          end

          def versao_layout_arquivo
            '080'
          end

          # Densidade de gravacao do arquivo
          def densidade_gravacao
            '01600'
          end
          
          
          
          
          protected
          
            def normalizar_texto(text, size)
              (text.to_s.normalize || "").format_size(size).upcase
            end


            def converter_data(data, formato="%d%m%Y")
              data.strftime("%d%m%Y")
            end
          
            # Retorna número formatado
            # @return [String] 1 caractere numérico.
            def formata_numero(numero, tamanho)
              numero.to_s.rjust(tamanho, '0')
            end


            # Retorna tipo inscrição
            # @return [String] 1 caractere numérico.
            def tipo_inscricao(_inscricao)
              _inscricao.remove(/[-\/\\.]/).size <= 11 ? '1' : '2'
            end
            
            # Retorna número inscrição adaptado
            # @return [String] 1 caracteres numéricos.
            def f_numero_inscricao(_inscricao)
              numero_inscricao.remove(/[-\/\\.]/).rjust(14, '0')
            end

            # Retorna o Dígito Verificador
            # @return [String] 1 caractere numérico.
            def calcular_dv(number, size=12)
              number = number.rjust(size, "0")
              vetor = (1..4).map{|i| (2..9).to_a}.flatten[0..number.size - 1].reverse
              resutado = 0
              number.split('').each_with_index do |n, i|
                resutado += n.to_i * vetor[i]
              end
              resto = resutado % 10
              r = 11 - resto
              r > 9 ? "0" : r.to_s
            end

        end
      end
    end
  end
end