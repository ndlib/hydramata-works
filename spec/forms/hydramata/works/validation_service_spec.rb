require 'spec_fast_helper'
require 'hydramata/works/validation_service'
require 'hydramata/works/entity_form'
require 'hydramata/works/predicate'
require 'hydramata/works/entity'
require 'active_model/validations/presence'

module Hydramata
  module Works
    describe ValidationService do
      let(:title) { nil }
      let(:title_predicate) { Predicate.new(identity: 'title', validations: { presence: true }) }
      let(:entity) do
        Entity.new(work_type: 'article') do |entity|
          entity.properties << { predicate: title_predicate }
        end
      end
      let(:entity_form) { EntityForm.new(entity) }
      subject { described_class }

      context '#call' do
        it 'runs validations attached to each predicate' do
          expect { subject.call(entity_form) }.
            to change { entity_form.errors.full_messages }.
            from([]).
            to(['title can\'t be blank'])
        end

      end
    end
  end
end