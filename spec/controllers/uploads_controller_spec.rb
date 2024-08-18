# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe UploadsController, type: :controller do
  describe 'POST #create' do
    let(:file1) { fixture_file_upload('dockwa1.txt', 'text/plain') }
    let(:file2) { fixture_file_upload('dockwa2.txt', 'text/plain') }
    let(:file_service) { instance_double(FileService) }

    before do
      allow(FileService).to receive(:new).and_return(file_service)
    end

    context 'when comma-separated file upload is successful' do
      before do
        allow(file_service).to receive(:process).and_return({ success: true, message: 'Success' })
      end

      it 'redirects to customers path with a success flash message' do
        post :create, params: { file: file1 }
        expect(response).to redirect_to(customers_path)
        expect(flash[:success]).to eq('Success')
      end
    end

    context 'when pipe-separated file upload is successful' do
      before do
        allow(file_service).to receive(:process).and_return({ success: true, message: 'Success' })
      end

      it 'redirects to customers path with a success flash message' do
        post :create, params: { file: file2 }
        expect(response).to redirect_to(customers_path)
        expect(flash[:success]).to eq('Success')
      end
    end

    context 'when file upload fails' do
      before do
        allow(file_service).to receive(:process).and_return({ success: false, message: 'Failure',
                                                              details: ['Error 1'] })
      end

      it 'redirects to customers path with an error flash message' do
        post :create, params: { file: file1 }
        expect(response).to redirect_to(customers_path)
        expect(flash[:error]).to include('Failure')
        expect(flash[:error]).to include('Error 1')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
