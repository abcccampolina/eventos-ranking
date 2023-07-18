# module Brcobranca
#   module Remessa
#     module Cnab240
#       class Base < Brcobranca::Remessa::Base
#         def monta_segmento_q(pagamento, nro_lote, sequencial)
            
#             segmento_q = ''                                               # CAMPO                                TAMANHO
#             segmento_q << cod_banco                                       # codigo banco                         3
#             segmento_q << nro_lote.to_s.rjust(4, '0')                     # lote de servico                      4
#             segmento_q << '3'                                             # tipo de registro                     1
#             segmento_q << sequencial.to_s.rjust(5, '0')                   # num. sequencial do registro no lote  5
#             segmento_q << 'Q'                                             # cod. segmento                        1
#             segmento_q << ' '                                             # uso exclusivo                        1
#             segmento_q << pagamento.identificacao_ocorrencia              # cod. movimento remessa               2
#             segmento_q << pagamento.identificacao_sacado(false)           # tipo insc. sacado                    1
#             segmento_q << pagamento.documento_sacado.to_s.rjust(15, '0')  # documento sacado                     14
#             segmento_q << pagamento.nome_sacado.format_size(40)           # nome cliente                         40
#             segmento_q << pagamento.endereco_sacado.format_size(40)       # endereco cliente                     40
#             segmento_q << pagamento.bairro_sacado.format_size(15)         # bairro                               15
#             segmento_q << pagamento.cep_sacado[0..4]                      # cep                                  5
#             segmento_q << pagamento.cep_sacado[5..7]                      # sufixo cep                           3
#             segmento_q << pagamento.cidade_sacado.format_size(15)         # cidade                               15
#             segmento_q << pagamento.uf_sacado                             # uf                                   2
#             segmento_q << pagamento.identificacao_avalista(false)         # identificacao do sacador             1
#             segmento_q << pagamento.documento_avalista.to_s.rjust(15, '0')# documento sacador                    15
#             segmento_q << pagamento.nome_avalista.format_size(40)         # nome avalista                        40
#             segmento_q << ''.rjust(3, ' ')                                # cod. banco correspondente            3
#             segmento_q << ''.rjust(20, ' ')                               # nosso numero banco correspondente    20
#             segmento_q << ''.rjust(8, ' ')                                # uso exclusivo                        8
#             segmento_q
#         end
#       end
#     end
#   end
# end

# Brcobranca.configuration.gerador = :rghost_carne