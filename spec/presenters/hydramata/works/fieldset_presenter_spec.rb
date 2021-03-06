require 'spec_fast_helper'
require 'hydramata/works/fieldset_presenter'
require 'hydramata/works/work'
require 'hydramata/works/work_type'

module Hydramata
  module Works
    describe FieldsetPresenter do
      let(:fieldset_class) { Struct.new(:name, :work_type) }
      let(:fieldset) { fieldset_class.new('my_fieldset', work_type) }
      let(:work_type) { WorkType.new(identity: 'a work type') }
      let(:work) { Work.new(work_type: work_type) }
      let(:renderer) { double('Renderer', call: true) }
      let(:template) { double('Template') }
      subject { described_class.new(work: work, fieldset: fieldset, renderer: renderer) }

      it 'renders as per the template' do
        expect(renderer).to receive(:call).with(template, kind_of(Hash)).and_return('YES')
        expect(subject.render(template)).to eq('YES')
      end

      it 'has #container_content_tag_attributes' do
        expect(subject.container_content_tag_attributes).to have_key(:class)
      end

      it 'has an #work_type' do
        expect(subject.work_type).to eq(work.work_type)
      end

      it 'has a #legend' do
        expect(subject.legend).to eq(subject.label)
      end

      it 'is an instance of the presented object\'s class' do
        expect(subject.instance_of?(fieldset.class)).to be_truthy
      end

      it 'is also an instance of the presenter class' do
        expect(subject.instance_of?(described_class)).to be_truthy
      end

      it 'has a #dom_class' do
        expect(subject.dom_class).to eq('my-fieldset')
      end

      it 'has a default partial prefixes' do
        expect(subject.partial_prefixes).to eq([['a_work_type', 'my_fieldset'], ['my_fieldset']])
      end

    end
  end
end
