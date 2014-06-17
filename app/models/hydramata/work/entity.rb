require 'hydramata/work/conversions'
module Hydramata
  module Work
    # Responsible for being the in ruby representation of a set of Properties.
    #
    # Unlike the [ActiveRecord pattern](http://www.martinfowler.com/eaaCatalog/activeRecord.html),
    # there is no direct connection to a data storage. This is instead analogous
    # to the Entity of the [DataMapper pattern](http://www.martinfowler.com/eaaCatalog/dataMapper.html)
    # as implemented in [Lotus::Models](https://github.com/lotus/model#entities).
    #
    # Unlike a Lotus::Model, the Work is an arbitrary collection of Property
    # objects, as defined in the PropertySet.
    class Entity
      include Conversions

      def initialize(collaborators = {}, &block)
        @properties = collaborators.fetch(:properties_container) { default_properties_container }
        block.call(self) if block_given?
      end

      def work_type=(value)
        @work_type = WorkType(value)
      end

      attr_reader :properties, :work_type

      private

      def default_properties_container
        require 'hydramata/work/property_set'
        PropertySet.new(entity: self)
      end
    end
  end
end
