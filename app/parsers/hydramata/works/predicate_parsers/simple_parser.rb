module Hydramata
  module Works
    module PredicateParsers
      # A comically simple parser. You get what you give.
      module SimpleParser
        module_function
        def call(object, &block)
          block.call(value: object)
        end
      end
    end
  end
end
