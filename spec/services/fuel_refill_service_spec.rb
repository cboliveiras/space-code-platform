# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FuelRefillService do
  let!(:pilot) { create(:pilot) }
  let!(:ship) { create(:ship, fuel_capacity: 5, pilot: pilot) }
  let(:to_planet) { 'Demeter' }
  let(:service) { described_class.new(pilot, to_planet) }

  describe '#refill?' do
    context 'when the ship does not have fuel_capacity and the pilot does not have enough credits' do

      it 'returns false' do
        expect(service.refill?).to eq(false)
      end

      it 'does not update the pilot credits' do
        expect { service.refill? }.to_not change { pilot.reload.credits }
      end

      it 'does not update the ship fuel level' do
        expect { service.refill? }.to_not change { ship.reload.fuel_level }
      end

      it 'does not create a fuel refill record' do
        expect { service.refill? }.to change { FuelRefill.count }.by(0)
      end
    end

    context 'when the ship has fuel_capacity and the pilot has enough credits' do
      before { ship.update(fuel_level: 40) }

      it 'returns true' do
        expect(service.refill?).to eq(true)
      end

      it 'updates the pilot credits' do
        expect { service.refill? }.to change { pilot.reload.credits }
      end

      it 'updates the ship fuel level' do
        expect { service.refill? }.to change { ship.reload.fuel_level }
      end

      it 'reates a fuel refill record' do
        expect { service.refill? }.to change { FuelRefill.count }.by(1)
      end
    end

  end
end
