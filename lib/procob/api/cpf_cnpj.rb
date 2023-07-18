module Procob
  module Api

    class CpfCnpj
      
      def initialize(login, senha)
        @auth = auth64(login, senha)
      end

      def pesquisar(documento, struct: true)
        url = URI("https://api.procob.com/consultas/L0001/#{documento}")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request["authorization"] = "Basic #{@auth}"

        response = http.request(request)
        struct ? JSON.parse(response.read_body, object_class: OpenStruct) : JSON.parse(response.read_body, symbolize_names: true)
      end

      def auth64(login, senha)
        Base64.encode64("#{login}:#{senha}").strip
      end
      
      
    end

  end
end