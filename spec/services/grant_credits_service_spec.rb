# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GrantCreditsService do
  describe '#grant_credits?' do
    let!(:pilot) { create(:pilot, credits: 100) }
    let!(:ship) { create(:ship, weight_capacity: 100, pilot: pilot) }
    let!(:contract) { create(:contract, :taken, :with_ship) }

    context 'when the contract is fulfilled' do
      let!(:resource) { create(:resource, contracts: [contract], weight: 10) }
      let!(:travel) { create(:travel, ship: nil, to_planet: contract.to_planet, from_planet: contract.from_planet) }

      it 'grants the credits to the pilot' do
        service = GrantCreditsService.new(pilot, travel.id, contract.id)

        expect { service.grant_credits? }.to change { pilot.credits }.from(100).to(200)
      end
    end

    context 'when the contract is not fulfilled' do
      let!(:resource) { create(:resource, contracts: [contract], weight: 1000) }
      let!(:travel) { create(:travel, ship: ship) }

      it 'does not grant the credits to the pilot' do
        service = GrantCreditsService.new(pilot, travel.id, contract.id)

        expect { service.grant_credits? }.not_to change { pilot.credits }
      end
    end
  end
end
