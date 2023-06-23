# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FuelRefill, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:pilot) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:fuel) }
    it { is_expected.to validate_presence_of(:cost) }
  end
end
