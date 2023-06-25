# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TravelService do
  describe '#perform_travel' do
    let(:fuel_calculation_service) { instance_double(FuelCalculationService) }
    let(:service) { described_class.new(pilot, to_planet) }
    let(:to_planet) { 'Demeter' }
    let(:pilot) { create(:pilot) }
    let!(:ship) { create(:ship, fuel_level: 50, pilot: pilot) }

    context 'when the ship has enough fuel' do
      before do
        allow(FuelCalculationService).to receive(:new).and_return(fuel_calculation_service)
        allow(fuel_calculation_service).to receive(:calculate_fuel_consumption).and_return(30)
      end

      it 'returns true' do
        expect(service.perform_travel).to eq(true)
      end

      it 'creates a travel record' do
        expect { service.perform_travel }.to change { Travel.count }.by(1)
      end

      it 'updates the pilot location' do
        expect { service.perform_travel }.to change { pilot.reload.location }.from('Andvari').to(to_planet)
      end

      it 'decrements the ship fuel level' do
        expect { service.perform_travel }.to change { ship.reload.fuel_level }.from(50).to(20)
      end
    end
  end
end
