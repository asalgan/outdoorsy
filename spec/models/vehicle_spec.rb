# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it { should belong_to(:customer) }
  it { should validate_presence_of(:vehicle_type) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:length) }
  it { should define_enum_for(:vehicle_type).with_values(%i[sailboat motorboat rv campervan bicycle]) }

  describe 'before_validation callback' do
    it 'parses the length before validation' do
      vehicle = Vehicle.new(length: '20 ft')
      vehicle.valid?
      expect(vehicle.length).to eq(20)
    end

    it 'adds an error for invalid length format' do
      vehicle = Vehicle.new(length: 'invalid')
      vehicle.valid?
      expect(vehicle.errors[:length]).to include('invalid length format')
    end
  end
end
