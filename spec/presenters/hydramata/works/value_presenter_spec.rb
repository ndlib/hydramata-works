require 'spec_fast_helper'
require 'hydramata/works/value_presenter'
require 'hydramata/works/work'
require 'hydramata/works/predicate'

module Hydramata
  module Works
    describe ValuePresenter do
      let(:work) { Work.new(work_type: 'a work type') }
      let(:predicate) { Predicate.new(identity: 'a predicate') }
      let(:value) { double('Value') }
      let(:template) { double('Template', render: true) }
      subject do
        described_class.new(
          value: value,
          work: work,
          predicate: predicate,
          presentation_context: 'show',
          template_missing_exception: [RuntimeError]
        )
      end

      it 'attempts to render with diminishing specificity' do
        expect(template).to receive(:render).
          with(partial: 'hydramata/works/values/a_work_type/a_predicate/show', object: subject).
          ordered.
          and_raise(RuntimeError)
        expect(template).to receive(:render).
          with(partial: 'hydramata/works/values/a_predicate/show', object: subject).
          ordered.
          and_raise(RuntimeError)
        expect(template).to receive(:render).
          with(partial: 'hydramata/works/values/show', object: subject).
          ordered.
          and_return('YES')
        expect(subject.render(template: template)).to eq('YES')
      end

      it 'renders the value as a string' do
        allow(template).to receive(:render).and_raise(RuntimeError)
        expect(subject.render(template: template)).to eq(value.to_s)
      end

      it 'has a default partial prefixes' do
        expect(subject.partial_prefixes).to eq([['a_work_type','a_predicate'], ['a_predicate']])
      end
    end
  end
end