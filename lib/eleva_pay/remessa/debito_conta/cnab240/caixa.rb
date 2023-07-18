module ElevaPay
  module Remessa
    module DebitoConta
      module Cnab240
        class Caixa < ElevaPay::Remessa::DebitoConta::Cnab240::Base

          # include ElevaPay::Validation

          # attr_accessor :convenio
          # attr_accessor :pagamentos
          # validates_presence_of :pagamentos, :convenio, message: 'não pode estar em branco.'
          
          # def is_valid?
          #   # self.presences
          #   self.valid?
          #   # valid? ? true : false
          # end
          


          def codigo_banco()
            "104"
          end

          def ambiente_cliente
            ' '
          end
          

          def nome_banco
            "Caixa"
          end

          def codigo_convenio
            ''.rjust(20, '0')
          end

          def convenio_lote
            ''.rjust(6, '0')
          end

          # Tipo de Conta Registo A
          def tipo_conta_ra
            # "0" – Sem conta; 
            # "1" – Conta corrente; 
            # "2" – Poupança; 
            "0"
          end

          def indicador_bloqueio
            # "S" - Bloqueia as demais parcelas; 
            # "N" - Não bloqueia as demais parcelas;  
            'N'
          end
          
          

        end
      end
    end
  end
end