# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FuelCalculationService do
  describe '#calculate_fuel_consumption' do
    let(:service) { described_class.new }

    it 'returns the correct fuel consumption for a valid route' do
      fuel_consumption = service.calculate_fuel_consumption('Andvari', 'Demeter')
      expect(fuel_consumption).to eq(43)
    end

    it 'returns 0 for an invalid route' do
      fuel_consumption = service.calculate_fuel_consumption('Andvari', 'Unknown')
      expect(fuel_consumption).to eq(0)
    end
  end
end
