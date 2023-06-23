# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Travels', type: :request do
  describe 'GET /v1/pilots/:pilot_id/travels' do
    let(:pilot) { create(:pilot) }
    let!(:travels) { create_list(:travel, 3, ship: create(:ship, pilot: pilot)) }

    it 'returns a list of travels' do
      get "/v1/pilots/#{pilot.id}/travels"
      expect(response).to have_http_status(:ok)

      response_body = JSON.parse(response.body)
      expect(response_body.size).to eq(3)
    end
  end

  describe 'POST /v1/pilots/:pilot_id/travel_between_planets' do
    let(:pilot) { create(:pilot) }
    let(:to_planet) { 'Demeter' }

    context 'when the travel is successful' do
      before { allow_any_instance_of(TravelService).to receive(:perform_travel).and_return(true) }

      it 'returns a success message' do
        post "/v1/pilots/#{pilot.id}/travel_between_planets", params: { to_planet: to_planet }
        expect(response).to have_http_status(:ok)

        response_body = JSON.parse(response.body)
        expect(response_body).to eq({ 'message' => 'Travel successful!' })
      end
    end

    context 'when there is insufficient fuel for the journey' do
      before do
        allow_any_instance_of(TravelService).to receive(:perform_travel).and_return(false)
      end

      it 'returns an error message' do
        post "/v1/pilots/#{pilot.id}/travel_between_planets", params: { to_planet: to_planet }
        expect(response).to have_http_status(:unprocessable_entity)

        response_body = JSON.parse(response.body)
        expect(response_body).to eq({ 'error' => 'Insufficient fuel for the journey. Please refuel' })
      end
    end
  end

  describe 'POST /v1/pilots/:pilot_id/register_fuel_refill' do
    let(:pilot) { create(:pilot) }
    let(:to_planet) { 'Demeter' }

    context 'when the fuel refill is successful' do
      before { allow_any_instance_of(FuelRefillService).to receive(:refill?).and_return(true) }

      it 'returns a success message' do
        post "/v1/pilots/#{pilot.id}/register_fuel_refill", params: { to_planet: to_planet }
        expect(response).to have_http_status(:ok)

        response_body = JSON.parse(response.body)
        expect(response_body).to eq({ 'message' => 'Fuel refill successful!' })
      end
    end

    context 'when the fuel refill is not possible' do
      before { allow_any_instance_of(FuelRefillService).to receive(:refill?).and_return(false) }

      it 'returns an error message' do
        post "/v1/pilots/#{pilot.id}/register_fuel_refill", params: { to_planet: to_planet }
        expect(response).to have_http_status(:unprocessable_entity)

        response_body = JSON.parse(response.body)
        expect(response_body).to eq({ 'error' => 'Cannot refill. Check the credits or the fuel ship capacity' })
      end
    end
  end
end
