module Burocracia
  # Module responsible for generating randomic low-level information
  module Generator
    extend self

    # Generates a string with random numbers.
    #
    # ```crystal
    # Burocracia::Generator.random_numbers(size: 3)
    # => "139"
    # ```
    #
    # If needed, you can pass your own `Random` instance:
    #
    # ```crystal
    # Burocracia::Generator.random_numbers(size: 5, randomifier: MyRandomClass)
    # => "002"
    # ```
    #
    # NOTE: The randomifier class or module must implement a function called `rand`
    # that accepts a `Range` and returns an `Object` with a `to_s` method.
    def random_numbers(size, randomifier = Random)
      generated = ""

      loop do
        generated += randomifier.rand(0..9).to_s
        break if generated.size == size
      end

      generated
    end
  end
end
