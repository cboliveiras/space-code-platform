require 'rails_helper'

RSpec.describe Travel, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:to_planet) }
    it { should validate_presence_of(:from_planet) }
    it { should validate_presence_of(:fuel_consumption) }
  end

  describe 'associations' do
    it { should belong_to(:ship).optional }
  end
end
