require 'spec_fast_helper'
require 'hydramata/work/fieldset_presenter'

module Hydramata
  module Work
    describe FieldsetPresenter do
      let(:fieldset_class) { Struct.new(:name, :work_type) }
      let(:fieldset) { fieldset_class.new('my_fieldset', 'an entity type') }
      let(:entity) { double('Entity', work_type: 'an entity type') }
      let(:template) { double('Template', render: true) }
      subject { described_class.new(entity: entity, fieldset: fieldset, presentation_context: 'show', template_missing_exception: [RuntimeError]) }

      it 'should render as per the template' do
        expect(template).to receive(:render).
          with(partial: 'hydramata/work/fieldsets/an_entity_type/my_fieldset/show', object: subject).
          ordered.
          and_raise(RuntimeError)
        expect(template).to receive(:render).
          with(partial: 'hydramata/work/fieldsets/my_fieldset/show', object: subject).
          ordered.
          and_raise(RuntimeError)
        expect(template).to receive(:render).
          with(partial: 'hydramata/work/fieldsets/show', object: subject).
          ordered.
          and_return('YES')
        expect(subject.render(template: template)).to eq('YES')
      end

      it 'should have an #work_type' do
        expect(subject.work_type).to eq(entity.work_type)
      end

      it 'should be an instance of the presented object\'s class' do
        expect(subject.instance_of?(fieldset.class)).to be_truthy
      end

      it 'should also be an instance of the presenter class' do
        expect(subject.instance_of?(described_class)).to be_truthy
      end

      it 'should have a #dom_class' do
        expect(subject.dom_class).to eq('my-fieldset')
      end

      it 'should have a default partial prefixes' do
        expect(subject.partial_prefixes).to eq([['an_entity_type', 'my_fieldset'], ['my_fieldset']])
      end

    end
  end
end
