require 'rails_helper'

RSpec.describe Contract, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:from_planet) }
    it { should validate_presence_of(:to_planet) }
    it { should validate_presence_of(:value) }
    it { should validate_numericality_of(:value).is_greater_than_or_equal_to(0) }

    context 'when status is taken' do
      let(:ship) { create(:ship) }
      let(:contract) { build(:contract, :taken) }

      it 'requires a ship to be assigned' do
        contract.ship = nil
        expect(contract).not_to be_valid
        expect(contract.errors[:base]).to include('Contract must have a ship assigned to be taken')

        contract.ship = ship
        expect(contract).to be_valid
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:ship).optional }
    it { should have_many(:contract_resources) }
    it { should have_many(:resources).through(:contract_resources) }
  end
end
