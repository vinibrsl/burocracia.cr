require "./service"
require "./sanitizer"
require "json"

module Burocracia
  module CEP
    struct Address
      extend Sanitizer
      extend Service

      JSON.mapping(
        cep: {key: "cep", type: String},
        neighborhood: {key: "bairro", type: String},
        city: {key: "cidade", type: String},
        street: {key: "logradouro", type: String},
        state: {key: "estado", type: String},
      )

      def self.find(cep)
        sanitize cep
        response = get cep
        Address.from_json response
      end
    end
  end
end
