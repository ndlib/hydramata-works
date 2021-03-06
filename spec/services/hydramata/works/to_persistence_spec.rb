require 'spec_fast_helper'
require 'hydramata/works/to_persistence'

module Hydramata
  module Works
    describe ToPersistence do
      let(:pid) { 'abc-123' }
      let(:persistence_coordinator) { double('Storage Service', call: true) }
      let(:pid_minting_service) { double('PID Minting Service', call: pid)}
      let(:property_1) { double(predicate: 'Title', values: ['Hello World']) }
      let(:property_2) { double(predicate: 'Description', values: ['A Brief Description']) }

      context '#call' do
        context 'creating a new object' do
          let(:work) { double('Work', work_type: 'Article', properties: [property_1, property_2], identity: nil)}
          it 'passes along to the underlying storage' do
            expect(work).to receive(:identity=).with(pid)
            described_class.call(work: work, persistence_coordinator: persistence_coordinator, pid_minting_service: pid_minting_service)
            expect(persistence_coordinator).
              to have_received(:call).
            with(
              {
                pid: pid,
                work_type: 'Article',
                state: nil,
                properties: { 'Title' => ['Hello World'], 'Description' => ['A Brief Description'] },
                attachments: {},
                dettachments: {}
              }, { pid_minting_service: pid_minting_service }
            )
          end

          it 'returns true on success' do
            expect(work).to receive(:identity=).with(pid)
            expect(
              described_class.call(
                work: work,
                persistence_coordinator: persistence_coordinator,
                pid_minting_service: pid_minting_service
              )
            ).to be_truthy
          end

          it 'returns false on failure' do
            expect(work).to_not receive(:identity=)
            expect(persistence_coordinator).to receive(:call).and_return(false)
            expect(
              described_class.call(
                work: work,
                persistence_coordinator: persistence_coordinator,
                pid_minting_service: pid_minting_service
              )
            ).to be_falsey
          end
        end

        context 'updating an existing object' do
          let(:work) { double('Work', work_type: 'Article', properties: [property_1, property_2], identity: pid)}
          it 'returns true on success' do
            expect(work).to_not receive(:identity=)
            described_class.call(work: work, persistence_coordinator: persistence_coordinator, pid_minting_service: pid_minting_service)
            expect(persistence_coordinator).
              to have_received(:call).
            with(
              {
                pid: pid,
                work_type: 'Article',
                state: nil,
                properties: { 'Title' => ['Hello World'], 'Description' => ['A Brief Description'] },
                attachments: {},
                dettachments: {}
              }, { pid_minting_service: pid_minting_service }
            )
          end
        end
      end
    end
  end
end
