module Burocracia
  module CEP
    extend self

    FORMATTED_REGEX   = /^[0-9]{5}-[0-9]{3}$/i
    UNFORMATTED_REGEX = /^[0-9]{8}$/i

    def valid?(cep)
      return false if cep.chars.uniq.size == 1
      return false if (cep =~ FORMATTED_REGEX + UNFORMATTED_REGEX).nil?
      true
    end

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

    def formatted?(cep)
      return false if (cep =~ FORMATTED_REGEX).nil?
      true
    end

    def format(cep)
      return cep if formatted?(cep)
      "#{cep[0..4]}-#{cep[5..7]}"
    end
  end
end
