module Burocracia
  module CEP
    module Sanitizer
      def sanitize(cep)
        cep.to_s.delete("^0-9")[0..7]
      end
    end
  end
end
