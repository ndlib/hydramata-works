# Instead of using spec_helper, I'm using the twice as fast custom helper
# for active record objects.
require 'spec_fast_helper'
require 'hydramata/work/work_type'
require 'hydramata/work/linters/implement_work_type_interface_matcher'
require 'hydramata/work/linters/implement_data_definition_interface_matcher'

module Hydramata
  module Work
    describe WorkType do
      subject { described_class.new(identity: 'My Identity') }
      it { should implement_work_type_interface }
      it { should implement_data_definition_interface }

      context '#predicate_sets=' do
        it 'handles predicate set conversion' do
          subject = described_class.new(identity: 'My Identity', predicate_sets: ['one predicate', 'two predicate'])
          expect(subject.predicate_sets).to eq([PredicateSet.new(identity: 'one predicate'), PredicateSet.new(identity: 'two predicate')])
        end
      end

      it 'should have #fieldsets that is an alias of #predicate_sets' do
        subject = described_class.new(identity: 'My Identity', predicate_sets: ['one predicate', 'two predicate'])
        expect(subject.fieldsets).to eq(subject.predicate_sets)
      end

      context '#itemtype_schema_dot_org' do
        it 'should utilize the default' do
          subject = described_class.new(identity: 'My Identity')
          expect(subject.itemtype_schema_dot_org).to match(/\Ahttps?:\/\/schema.org/)
        end

        it 'should prepend http://schema.org if is missing' do
          subject = described_class.new(identity: 'My Identity', itemtype_schema_dot_org: 'Thing')
          expect(subject.itemtype_schema_dot_org).to eq('http://schema.org/Thing')
        end

        it 'should accept http directly' do
          subject = described_class.new(identity: 'My Identity', itemtype_schema_dot_org: 'http://schema.org/CreativeWork')
          expect(subject.itemtype_schema_dot_org).to eq('http://schema.org/CreativeWork')
        end
      end
    end
  end
end
