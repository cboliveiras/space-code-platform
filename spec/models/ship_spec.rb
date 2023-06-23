require 'rails_helper'

RSpec.describe Ship, type: :model do
  describe 'validations' do
    it { should validate_numericality_of(:fuel_capacity).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:fuel_level).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:weight_capacity).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:pilot) }
  end
end
