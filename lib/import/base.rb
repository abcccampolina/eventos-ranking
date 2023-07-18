module Import
  

  class Base
    include Import::ClassMethods

    def initialize(file)
      @file = file
    end

    # Passado em cada interação do dado válido
    def valid_record(data, total_rows, processed); end

    # Passado em cada interação do dado inválido
    def invalid_record(ret, total_rows, processed); end

    # Evento callback que é acionado antes de executar a ação 'execute!'
    def before_execute; end

    # Evento callback que é acionado depois de executar a ação 'execute!'
    def after_execute; end

    def execute!
      before_execute()
      process_data()
      after_execute()
    end
  end
end
