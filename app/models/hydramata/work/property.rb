require 'active_support/core_ext/array/wrap'
module Hydramata
  module Work
    # The responsibility of a Property is to be a collection of values for
    # a given predicate. In other words, this represents the Predicate/Object
    # components of an RDF Triple.
    #
    # Why not use RDF? Because not everything we are working with is in RDF.
    class Property
      attr_reader :predicate, :values
      def initialize(options = {})
        @predicate = options.fetch(:predicate)
        @values = []
        push(options[:values])
        push(options[:value])
      end

      def <<(value)
        Array.wrap(value).each do |v|
          @values << v
        end
        self
      end
      alias_method :push, :<<

      alias_method :value, :values

      def ==(other)
        super ||
          other.instance_of?(self.class) &&
          other.predicate == predicate &&
          other.values == values
      end
    end
  end
end