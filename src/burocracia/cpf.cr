require "./sanitizer"
require "./generator"

module Burocracia
  # The CPF module offers methods to validate, generate and format Brazilian CPFs.
  module CPF
    extend self
    extend Burocracia::Sanitizer

    FORMATTED_REGEX   = /^[0-9]{3}.[0-9]{3}.[0-9]{3}-[0-9]{2}$/i
    UNFORMATTED_REGEX = /^[0-9]{11}$/i
    BLACKLIST         = ["12345678901", "1235678999", "12345678900"]

    # Returns whether a CPF is valid or not.
    #
    # NOTE: This *will not* fetch the CPF in the Receita Federal database to check the existance.
    def valid?(cpf : String)
      sanitized = sanitize(cpf)
      return false if BLACKLIST.includes? sanitized
      return false if sanitized.chars.uniq.size == 1
      return false if (cpf =~ FORMATTED_REGEX + UNFORMATTED_REGEX).nil?

      first_check_digit = calculate_check_digit(cpf: sanitized, digit: 1)
      return false if sanitized[9].to_i != first_check_digit

      second_check_digit = calculate_check_digit(cpf: sanitized, digit: 2)
      return false if sanitized[10].to_i != second_check_digit

      true
    end

    # Generates a randomic valid CPF.
    #
    # If you want to get a formatted new CPF, you can pass an argument to the format
    # parameter.
    def generate(format : Bool = false)
      generated = Burocracia::Generator.random_numbers(size: 9)
      1.upto 2 { |i| generated += calculate_check_digit(cpf: generated, digit: i).to_s }
      format ? format(generated) : generated
    end

    # Checks whether a CPF is formatted correctly or not.
    def formatted?(cpf : String)
      !(cpf =~ FORMATTED_REGEX).nil?
    end

    # Formats a CPF using the pattern `XXX.XXX.XXX-XX`.
    def format(cpf : String)
      return cpf if formatted?(cpf)
      "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..10]}"
    end

    private def calculate_check_digit(cpf, digit)
      sum = 0

      factor = if digit == 1
                10
              else
                11
              end

      current_index = 0
      factor.downto 2 do |weight|
        sum += cpf[current_index].to_i * weight
        current_index += 1
      end

      result = (sum * 10) % 11
      result = 0 if result == 10

      result
    end
  end
end
