# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SortHelper, type: :helper do
  describe '#sortable' do
    it 'returns a URL with default sorting params when no params are passed in' do
      allow(helper).to receive(:params).and_return({})
      expect(helper.sortable('first_name')).to include('/customers?direction=desc&amp;sort=first_name')
    end

    it 'returns a URL with asc direction when descending param is passed in' do
      allow(helper).to receive(:params).and_return({ sort: 'first_name', direction: 'desc' })
      expect(helper.sortable('first_name')).to include('/customers?direction=asc&amp;sort=first_name')
    end

    it 'includes the correct sort indicator when sorting asc' do
      allow(helper).to receive(:params).and_return({ sort: 'first_name', direction: 'asc' })
      expect(helper.sortable('first_name')).to include('↑')
    end

    it 'includes the correct sort indicator when sorting desc' do
      allow(helper).to receive(:params).and_return({ sort: 'first_name', direction: 'desc' })
      expect(helper.sortable('first_name')).to include('↓')
    end

    it 'includes the default sort indicator for unsorted columns' do
      allow(helper).to receive(:params).and_return({ sort: 'last_name', direction: 'asc' })
      expect(helper.sortable('first_name')).to include('↕')
    end
  end
end
