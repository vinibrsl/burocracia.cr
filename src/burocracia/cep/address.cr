require "./service"
require "./sanitizer"
require "json"

module Burocracia
  module CEP
    # The `Address` struct provides API to fetch addresses using
    # an external serivce, the Postmon API.
    #
    # ```crystal
    # Burocracia::CEP::Address.find("80210130")
    # => Burocracia::CEP::Address(@cep="80210130", @neighborhood="Jardim Botânico", @city="Curitiba", @street="Rua José Ananias Mauad", @state="PR")
    # ```
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
