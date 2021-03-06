require 'spec_slow_helper'
require 'hydramata/works/presence_of_each_validator'

module Hydramata
  module Works
    describe PresenceOfEachValidator do
      class Validatable
        include ActiveModel::Validations
        attr_accessor :identity

        def read_attribute_for_validation(attribute)
          send(attribute)
        end
      end

      Given(:record) { Validatable.new.tap {|v| v.identity = values } }
      Given(:attribute) { :identity }
      Given(:validator) { described_class.new(attributes: [attribute]) }

      context 'with no values' do
        Given(:values) { [] }
        When { validator.validate(record) }
        Then { record.errors[attribute].present? }
      end

      context 'with a nil value' do
        Given(:values) { [nil] }
        When { validator.validate(record) }
        Then { record.errors[attribute].present? }
      end

      context 'with a value' do
        Given(:values) { ['valid'] }
        When { validator.validate(record) }
        Then { record.errors[attribute].empty? }
      end

      context 'with a value and a blank' do
        Given(:values) { ['valid', ''] }
        When { validator.validate(record) }
        Then { record.errors[attribute].present? }
      end

      context 'with two values' do
        Given(:values) { ['valid', 'valid'] }
        When { validator.validate(record) }
        Then { record.errors[attribute].empty? }
      end

    end
  end
end
