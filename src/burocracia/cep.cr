module Burocracia
  # The CEP module offers methods to validate, generate and format Brazilian post codes.
  module CEP
    extend self

    FORMATTED_REGEX   = /^[0-9]{5}-[0-9]{3}$/i
    UNFORMATTED_REGEX = /^[0-9]{8}$/i

    # Returns whether a CEP is valid or not.
    #
    # NOTE: This will not fetch the CEP in the Correios database to check the existance.
    def valid?(cep)
      return false if cep.chars.uniq.size == 1
      return false if (cep =~ FORMATTED_REGEX + UNFORMATTED_REGEX).nil?
      true
    end

    # Generates a randomic valid CEP.
    #
    # If you want to get a formatted new CEP, you can pass an argument to the format
    # parameter.
    def generate(format = false)
      generated = ""

      loop do
        generated += Random.new.rand(0..9).to_s
        break if generated.size == 8
      end

      generated = generate(format) if !valid?(generated)
      generated = format(generated) if format

      generated
    end

    # Checks whether a CEP is formatted correctly or not.
    def formatted?(cep)
      return false if (cep =~ FORMATTED_REGEX).nil?
      true
    end

    # Formats a CEP using the pattern `XXXXX-XXX`.
    def format(cep)
      return cep if formatted?(cep)
      "#{cep[0..4]}-#{cep[5..7]}"
    end
  end
end
