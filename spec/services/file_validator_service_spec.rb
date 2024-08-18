# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe FileValidatorService do
  let(:file) { double('file') }
  let(:service) { described_class.new(file) }

  describe '#validate' do
    context 'when file is nil' do
      let(:file) { nil }

      it 'returns an error' do
        expect(service.validate).to eq({ success: false, error: 'No file uploaded' })
      end
    end

    context 'when file type is invalid' do
      before { allow(file).to receive(:content_type).and_return('application/pdf') }

      it 'returns an error' do
        expect(service.validate).to eq({ success: false, error: 'Invalid file type. Please upload only TXT files.' })
      end
    end

    context 'when file size is too large' do
      before do
        allow(file).to receive(:content_type).and_return('text/plain')
        allow(file).to receive(:size).and_return(10.megabytes)
      end

      it 'returns an error' do
        expect(service.validate).to eq({ success: false, error: 'File is too large. Maximum size is 5MB.' })
      end
    end

    context 'when file is valid' do
      before do
        allow(file).to receive(:content_type).and_return('text/plain')
        allow(file).to receive(:size).and_return(1.megabyte)
      end

      it 'returns success' do
        expect(service.validate).to eq({ success: true })
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
