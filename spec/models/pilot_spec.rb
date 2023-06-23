require 'rails_helper'

RSpec.describe Pilot, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:certification) }
    it { should validate_uniqueness_of(:certification) }
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:age).is_greater_than_or_equal_to(18) }
    it { should validate_numericality_of(:credits).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:location) }
  end

  describe 'associations' do
    it { should have_one(:ship) }
    it { should have_many(:fuel_refills) }
  end
end
