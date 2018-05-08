require "./sanitizer"
require "./generator"

module Burocracia
  # The CNPJ module offers methods to validate, generate and format Brazilian CNPJs.
  module CNPJ
    extend self
    extend Burocracia::Sanitizer

    FORMATTED_REGEX   = /^\d{2}.\d{3}.\d{3}\/\d{4}-\d{2}$/i
    UNFORMATTED_REGEX = /^[0-9]{14}$/i
    BLACKLIST         = ["12345678912345", "12345678900000", "12345678999999", "12345678911111"]

    # Returns whether a CNPJ is valid or not.
    #
    # NOTE: This *will not* fetch the CNPJ in the Receita Federal database to check the existance.
    def valid?(cnpj : String) : Bool
      sanitized = sanitize(cnpj)
      return false if BLACKLIST.includes? sanitized
      return false if sanitized.chars.uniq.size == 1
      return false if (sanitized =~ UNFORMATTED_REGEX).nil?

      first_check_digit = calculate_check_digit(cnpj: sanitized, digit: 1)
      return false if sanitized[12].to_i != first_check_digit

      second_check_digit = calculate_check_digit(cnpj: sanitized, digit: 2)
      return false if sanitized[13].to_i != second_check_digit

      true
    end

    # Generates a randomic valid CNPJ.
    #
    # If you want to get a formatted new CNPJ, you can pass an argument to the format
    # parameter.
    def generate(format : Bool = false) : String
      generated = Burocracia::Generator.random_numbers(size: 12)
      1.upto 2 { |i| generated += calculate_check_digit(cnpj: generated, digit: i).to_s }
      format ? format(generated) : generated
    end

    # Checks whether a CNPJ is formatted correctly or not.
    def formatted?(cnpj : String) : Bool
      !(cnpj =~ FORMATTED_REGEX).nil?
    end

    # Formats a CNPJ using the pattern `XX.XXX.XXX/XXXX-XX`.
    def format(cnpj : String) : String
      return cnpj if formatted?(cnpj)
      "#{cnpj[0..1]}.#{cnpj[2..4]}.#{cnpj[5..7]}/#{cnpj[8..11]}-#{cnpj[12..13]}"
    end

    private def calculate_check_digit(cnpj, digit)
      sum = 0

      weights = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
      weights.insert(index: 0, object: 6) if digit == 2
      weights.each_with_index { |weight, i| sum += cnpj[i].to_i * weight }

      result = 11 - (sum % 11)
      result >= 10 ? 0 : result
    end
  end
end

