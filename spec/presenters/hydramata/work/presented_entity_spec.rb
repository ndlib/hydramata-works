require 'fast_helper'
require 'hydramata/work/presented_entity'
require 'hydramata/work/linters'

module Hydramata
  module Work
    describe PresentedEntity do
      it_behaves_like 'a presented entity'

      let(:presentation_structure) { double('PresentationStructure') }
      let(:entity) { double('Entity', work_type: true) }
      let(:presented_fieldset_builder) { double('Builder', call: true) }
      subject { described_class.new(entity: entity, presentation_structure: presentation_structure, presented_fieldset_builder: presented_fieldset_builder) }

      it 'should have #fieldsets that are extracted from the #entity and #presentation_structure' do
        subject.fieldsets
        expect(presented_fieldset_builder).to have_received(:call).with(entity: subject, presentation_structure: presentation_structure)
      end

      it 'delegates :work_type to :entity' do
        subject.work_type
        expect(entity).to have_received(:work_type)
      end

      it 'should be an instance of the presented object\'s class' do
        expect(subject.instance_of?(entity.class)).to be_truthy
      end

      it 'should also be an instance of the presenter class' do
        expect(subject.instance_of?(described_class)).to be_truthy
      end

    end
  end
end