# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pilots API', type: :request do
  describe 'GET /v1/pilots' do
    let!(:pilot) { create(:pilot) }

    context 'requests list of all pilots on database' do
      before { get '/v1/pilots' }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).not_to be_empty }
    end
  end

  describe 'GET /v1/pilots/:id' do
    let!(:pilot) { create(:pilot) }

    it 'returns the pilot' do
      get "/v1/pilots/#{pilot.id}"

      expect(response).to have_http_status(:ok)

      response_json = JSON.parse(response.body)
      expect(response_json['name']).to eq(pilot.name)
    end
  end

  describe 'POST /v1/pilots' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          pilot: {
            name: 'Jane Doe',
            age: 25,
            credits: 100,
            certification: '205979-8',
            location: 'Andvari'
          }
        }
      end
      let(:request) { post '/v1/pilots', params: valid_params }

      it 'creates a new pilot' do
        expect { request }.to change(Pilot, :count).by(1)
        expect(response).to have_http_status(:created)

        response_json = JSON.parse(response.body)
        expect(response_json['name']).to eq('Jane Doe')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          pilot: {
            name: '',
            age: 25,
            credits: 100,
            certification: '1234567',
            location: 'Andvari'
          }
        }
      end
      let(:request) { post '/v1/pilots', params: invalid_params }

      it 'does not create a new pilot' do
        expect { request }.not_to change(Pilot, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
