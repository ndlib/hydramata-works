require 'hydramata/works/conversions/work_type'
require 'active_support/core_ext/module/delegation'

module Hydramata
  module Works
    # Responsible for being the in ruby representation of a set of Properties.
    #
    # Unlike the [ActiveRecord pattern](http://www.martinfowler.com/eaaCatalog/activeRecord.html),
    # there is no direct connection to a data storage. This is instead analogous
    # to the Work of the [DataMapper pattern](http://www.martinfowler.com/eaaCatalog/dataMapper.html)
    # as implemented in [Lotus::Models](https://github.com/lotus/model#entities).
    #
    # Unlike a Lotus::Model, the Work is an arbitrary collection of Property
    # objects, as defined in the PropertySet.
    class Work
      include Conversions

      def initialize(collaborators = {}, &block)
        self.work_type = collaborators[:work_type] if collaborators.key?(:work_type)
        self.identity = collaborators[:identity] if collaborators.key?(:identity)
        @state = collaborators.fetch(:state) { default_state }
        @property_value_strategy = collaborators.fetch(:property_value_strategy) { default_property_value_strategy }
        @properties = collaborators.fetch(:properties_container) { default_properties_container }
        @presenter_builder = collaborators.fetch(:presenter_builder) { default_presenter_builder }
        block.call(self) if block_given?
      end

      def work_type=(value)
        @work_type = WorkType(value)
      end

      def work_type
        @work_type ||= WorkType()
      end

      def to_param
        identity.to_s
      end

      def identity=(value)
        @identity = value
      end

      def has_property?(predicate)
        properties.key?(predicate)
      end

      attr_reader :property_value_strategy
      attr_reader :properties, :identity
      attr_reader :state

      delegate(
        :to_translation_key_fragment,
        :to_view_path_fragment,
        :name_for_application_usage,
        :itemtype_schema_dot_org,
        to: :work_type
      )

      attr_reader :presenter_builder
      private :presenter_builder

      def to_presenter
        presenter_builder.call(self)
      end

      private

      def default_property_value_strategy
        :append_values
      end

      def default_properties_container
        require 'hydramata/works/property_set'
        PropertySet.new(work: self, property_value_strategy: property_value_strategy)
      end

      def default_presenter_builder
        require 'hydramata/works/work_presenter'
        ->(work) { WorkPresenter.new(work: work) }
      end

      def default_state
        'valid'
      end
    end
  end
end
