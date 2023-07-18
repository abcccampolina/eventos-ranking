require 'eleva_pay/validations'

module ElevaPay

  class NaoImplementado < RuntimeError
  end

  class RemessaInvalida < RuntimeError
  end

  class ValorInvalido < StandardError
  end
  
  module DebitoConta
    module Remessa
      module Cnab240
        autoload :Base,          'eleva_pay/debito_conta/remessa/cnab240/base'
        autoload :Caixa,         'eleva_pay/debito_conta/remessa/cnab240/caixa'
      end
    end
  end
end