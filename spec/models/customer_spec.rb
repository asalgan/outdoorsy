# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_one(:vehicle) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_length_of(:first_name).is_at_most(50) }
  it { should validate_length_of(:last_name).is_at_most(50) }
  it { should validate_length_of(:email).is_at_most(255) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  describe '#full_name' do
    it 'returns the full name of the customer' do
      customer = Customer.new(first_name: 'John', last_name: 'Doe')
      expect(customer.full_name).to eq('John Doe')
    end
  end
end
