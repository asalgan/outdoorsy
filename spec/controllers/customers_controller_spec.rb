# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe CustomersController, type: :controller do
  describe 'GET #index' do
    let!(:customer1) { Customer.create!(first_name: 'Alice', last_name: 'Smith', email: 'alice.smith@example.com') }
    let!(:customer2) { Customer.create!(first_name: 'Bob', last_name: 'Jones', email: 'bob.jones@example.com') }
    let!(:vehicle1)  { Vehicle.create!(customer: customer1, vehicle_type: 'rv', name: 'Happy Camper', length: 25) }
    let!(:vehicle2)  { Vehicle.create!(customer: customer2, vehicle_type: 'sailboat', name: 'Sea Breeze', length: 30) }

    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns customers with formatted data' do
      get :index
      customers = controller.instance_variable_get('@customers')
      expect(customers).to be_an(Array)
      expect(customers.length).to eq(2)
      expect(customers.first).to include(
        full_name: 'Alice Smith',
        email: 'alice.smith@example.com',
        vehicle_type: 'RV',
        vehicle_name: 'Happy Camper',
        vehicle_length: '25 ft.'
      )
    end

    it 'sorts customers by first_name in ascending order by default' do
      get :index
      customers = controller.instance_variable_get('@customers')
      expect(customers.map { |c| c[:full_name] }).to eq(['Alice Smith', 'Bob Jones'])
    end

    it 'allows sorting by different columns' do
      get :index, params: { sort: 'first_name', direction: 'desc' }
      customers = controller.instance_variable_get('@customers')
      expect(customers.map { |c| c[:full_name] }).to eq(['Bob Jones', 'Alice Smith'])
    end
  end
end
# rubocop:enable Metrics/BlockLength
