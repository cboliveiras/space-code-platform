# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ships API', type: :request do
  let(:pilot) { create(:pilot) }

  describe 'GET /v1/pilots/:pilot_id/ships' do
    let!(:ship) { create(:ship, pilot: pilot) }

    context 'request list of all ships on database' do
      before { get "/v1/pilots/#{pilot.id}/ships" }

      it { expect(response).to have_http_status(:ok) }

      it 'returns all ships' do
        expect(response.body).to include('fuel_capacity')
        expect(response.body).to include('fuel_level')
        expect(response.body).to include('weight_capacity')
      end
    end
  end

  describe 'POST /v1/pilots/:pilot_id/ships' do
    context 'with valid ship parameters' do
      let(:valid_params) { { ship: { fuel_capacity: 150, fuel_level: 85, weight_capacity: 30, pilot_id: pilot.id } } }

      before { post "/v1/pilots/#{pilot.id}/ships", params: valid_params }

      it 'creates a ship associated with the pilot' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid ship parameters' do
      let(:invalid_params) { { ship: { fuel_capacity: 'abc', fuel_level: 50, weight_capacity: 10 } } }

      before { post "/v1/pilots/#{pilot.id}/ships", params: invalid_params }

      it 'does not create a new ship' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(pilot.ship).to eq(nil)
      end
    end

    context 'with an invalid pilot ID' do
      let(:valid_params) { { ship: { fuel_capacity: 150, fuel_level: 85, weight_capacity: 30 } } }

      it 'returns not found status' do
        post "/v1/pilots/999/ships", params: valid_params

        expect(response).to have_http_status(:not_found)
        expect(pilot.ship).to eq(nil)
      end
    end
  end
end
