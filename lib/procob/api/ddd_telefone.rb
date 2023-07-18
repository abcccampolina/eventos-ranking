require 'uri'
require 'net/http'
require 'base64'

module Procob
  module Api


    class DddTelefone
      
      def initialize(login, senha)
        @auth = auth64(login, senha)
      end

      def pesquisar(ddd, telefone)
        url = URI("https://api.procob.com/consultas/L0003/#{ddd}/#{telefone}")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request["authorization"] = "Basic #{@auth}"

        response = http.request(request)
        JSON.parse(response.read_body, object_class: OpenStruct)
      end

      def auth64(login, senha)
        Base64.encode64("#{login}:#{senha}").strip
      end
      
      
    end

  end
end