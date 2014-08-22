require 'delegate'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/blank'
require 'active_model/naming'
require 'hydramata/works/conversions/translation_key_fragment'

module Hydramata
  module Works
    # Responsible for wrapping a given Work such that it can interact with
    # form rendering in HTML as well as exposing validation behavior.
    class WorkForm < SimpleDelegator
      include Conversions
      def initialize(work, collaborators = {})
        __setobj__(work)
        @errors = collaborators.fetch(:error_container) { default_error_container }
        @validation_service = collaborators.fetch(:validation_service) { default_validation_service }
      end

      attr_reader :errors
      attr_reader :validation_service

      def valid?
        validate
        errors.size == 0
      end

      def to_key
        persisted? ? [identity] : nil
      end

      def to_param
        persisted? ? identity : nil
      end

      def to_partial_path
        # @TODO - need to figure out what this should be
        ''
      end

      def persisted?
        identity.present?
      end

      # Needed for Validator interaction
      def self.human_attribute_name(attr, options = {})
        attr
      end

      def self.model_name
        # @TODO - allow overwrite of the ActiveModel::Name, which may require
        # overwriting #class to be something else.
        @_model_name ||= ActiveModel::Name.new(self, Hydramata::Works)
      end

      # Needed for Validator interaction
      def read_attribute_for_validation(attribute_name)
        send(TranslationKeyFragment(attribute_name))
      end

      def inspect
        format('#<%s:%#0x work=%s>', WorkForm, __id__, __getobj__.inspect)
      end

      def instance_of?(klass)
        super || __getobj__.instance_of?(klass)
      end

      private

      def respond_to_missing?(method_name, include_all = false)
        super || __getobj__.has_property?(method_name)
      end

      def method_missing(method_name, *args, &block)
        if __getobj__.has_property?(method_name)
          # @TODO - The Law of Demeter is being violated.
          __getobj__.properties.fetch(method_name).values
        else
          super
        end
      end

      def default_error_container
        require 'active_model/errors'
        ActiveModel::Errors.new(self)
      end

      def default_validation_service
        require 'hydramata/works/validation_service'
        ValidationService
      end

      def validate
        validation_service.call(self)
      end

    end
  end
end
