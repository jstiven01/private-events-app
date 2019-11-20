# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'should be valid' do
      user = User.new(name: 'Johan', email: 'foo@example.com').save
      expect(user).to eq(true)
    end
  end
end
