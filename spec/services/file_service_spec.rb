# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe FileService do
  let(:file) { double('file') }
  let(:file_content) { "John,Doe,john@example.com,rv,Happy Camper,32 ft\n" }
  let(:service) { described_class.new(file) }

  before do
    allow(file).to receive(:read).and_return(file_content)
    allow(FileValidatorService).to receive_message_chain(:new, :validate).and_return({ success: true })
  end

  describe '#process' do
    context 'when file is valid' do
      it 'creates customer and vehicle records' do
        expect { service.process }.to change { Customer.count }.by(1).and change { Vehicle.count }.by(1)
      end

      it 'returns a success message' do
        result = service.process
        expect(result[:success]).to be true
        expect(result[:message]).to include('Successfully imported 1 records')
      end
    end

    context 'when there are errors' do
      let(:file_content) { "John,Doe,,rv,Happy Camper,32 ft\n" }

      it 'returns an error message' do
        result = service.process
        expect(result[:success]).to be false
        expect(result[:message]).to include('Import failed')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
