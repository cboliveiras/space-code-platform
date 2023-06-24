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

  describe '#luhn_validation' do
    let(:pilot) { Pilot.new(certification: certification) }

    context 'when certification is valid' do
      let(:certification) { '305504-3' }

      it 'does not add any errors' do
        pilot.valid?
        expect(pilot.errors[:certification]).to be_empty
      end
    end

    context 'when certification is invalid' do
      let(:certification) { '123456-8' }

      it 'adds an error to certification' do
        pilot.valid?
        expect(pilot.errors[:certification]).to include('is invalid')
      end
    end
  end
end
