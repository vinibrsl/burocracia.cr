require "./sanitizer"
require "./generator"

module Burocracia
  # The CEP module offers methods to validate, generate and format Brazilian post codes.
  module CEP
    extend self
    extend Burocracia::Sanitizer

    FORMATTED_REGEX   = /^[0-9]{5}-[0-9]{3}$/i
    UNFORMATTED_REGEX = /^[0-9]{8}$/i
    BLACKLIST         = ["12345678", "87654321"]

    # Returns whether a CEP is valid or not.
    #
    # NOTE: This will not fetch the CEP in the Correios database to check the existance.
    def valid?(cep : String)
      sanitized = sanitize(cep)
      return false if BLACKLIST.includes? sanitized
      return false if sanitized.chars.uniq.size == 1
      return false if (sanitized =~ UNFORMATTED_REGEX).nil?
      true
    end

    # Generates a randomic valid CEP.
    #
    # If you want to get a formatted new CEP, you can pass an argument to the format
    # parameter.
    def generate(format : Bool = false)
      generated = Burocracia::Generator.random_numbers(size: 8)
      generated = generate(format) if !valid?(generated)
      format ? format(generated) : generated
    end

    # Checks whether a CEP is formatted correctly or not.
    def formatted?(cep : String)
      !(cep =~ FORMATTED_REGEX).nil?
    end

    # Formats a CEP using the pattern `XXXXX-XXX`.
    def format(cep : String)
      return cep if formatted?(cep)
      "#{cep[0..4]}-#{cep[5..7]}"
    end
  end
end
