require "http/client"
require "json"
require "./exceptions"

module Burocracia
  module CEP
    # This module is responsible for fetching the Postmon API
    module Service
      BASE_URL = "://api.postmon.com.br"

      def get(cep, secure = true)
        if secure
          protocol = "https"
        else
          protocol = "http"
        end
        response = HTTP::Client.get("#{protocol}#{BASE_URL}/v1/cep/#{cep}")

        return JSON.parse(response.body).to_json if response.status_code == 200
        raise CEP::ApiRequestError.new("The API responded with #{response.status_code}")
      end
    end
  end
end
