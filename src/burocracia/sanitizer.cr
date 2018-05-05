module Burocracia
  # Module resposible to normalize string inputs.
  module Sanitizer
    extend self

    # Normalizes and sanitizes a string input, removing anything
    # but numbers.
    #
    # ```crystal
    # CEP::Sanitizer.sanitize("108.291.921-23")
    # => "10829192123"
    # ```
    def sanitize(str : String)
      str.delete("^0-9")
    end
  end
end
