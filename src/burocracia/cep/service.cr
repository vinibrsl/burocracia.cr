require "http/client"
require "json"
require "./exceptions"

module Burocracia
  module CEP
    module Service
      BASE_URL = "http://api.postmon.com.br"

      def get(cep)
        response = HTTP::Client.get("#{BASE_URL}/v1/cep/#{cep}")

        return JSON.parse(response.body).to_json if response.status_code == 200
        raise CEP::ApiRequestError.new("The API responded with #{response.status_code}")
      end
    end
  end
end
