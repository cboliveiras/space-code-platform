# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::ContractsController, type: :request do
  describe 'GET /v1/contracts' do
    let!(:contracts) { create(:contract) }

    before { get '/v1/contracts' }

    it 'returns a list of contracts' do
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.size).to eq(1)
    end
  end

  describe 'GET /v1/contracts/:id' do
    let(:contract) { create(:contract) }

    before { get "/v1/contracts/#{contract.id}" }

    it 'returns the contract' do
      expect(response).to have_http_status(:ok)

      response_json = JSON.parse(response.body)
      expect(response_json['id']).to eq(contract.id)
    end
  end

  describe 'POST /v1/contracts' do
    let(:ship) { create(:ship) }
    let(:resource) { create(:resource) }
    let(:valid_params) do
      {
        contract: {
          description: 'Transportation of water to Planet A',
          from_planet: 'Planet A',
          to_planet: 'Planet B',
          value: 100,
          status: 'open',
          ship_id: ship.id
        }
      }
    end

    context 'with valid parameters' do
      before { post '/v1/contracts', params: valid_params }

      it 'creates a contract' do
        expect(response).to have_http_status(:created)
        expect(response.parsed_body['description']).to eq('Transportation of water to Planet A')
      end
    end

    context 'when the request is invalid' do
      let(:invalid_params) do
        {
          contract: {
            description: '',
            from_planet: 'Planet A',
            to_planet: 'Planet B',
            value: -100,
            status: 'open',
            ship_id: ship.id
          }
        }
      end

      before { post '/v1/contracts', params: invalid_params }

      it 'returns a validation failure message' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['value']).to eq(['must be greater than or equal to 0'])
      end
    end
  end

  describe 'PATCH /v1/contracts/:id' do
    let(:contract) { create(:contract, :with_ship) }

    context 'with valid parameters' do
      let(:valid_params) do
        {
          contract: {
            status: 'taken',
            ship_id: contract.ship.id
          }
        }
      end

      before { patch "/v1/contracts/#{contract.id}", params: valid_params }

      it 'updates the contract' do
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['status']).to eq('taken')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          contract: {
            status: 'taken',
            ship_id: nil
          }
        }
      end

      before { patch "/v1/contracts/#{contract.id}", params: invalid_params }

      it 'returns a validation failure message' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['ship_id']).to eq(["can't be blank"])
      end
    end
  end

  describe 'GET /v1/contracts/list_open_contracts' do
    context 'when there is any contracts' do
      let!(:open_contract) { create(:contract) }
      let!(:open_contract2) { create(:contract) }
      let!(:taken_contract) { create(:contract, :taken, :with_ship) }
      let!(:finished_contract) { create(:contract, :finished, :with_ship) }

      it 'returns only the open contracts' do
        get '/v1/contracts/list_open_contracts'

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(2)

        contract_ids = json_response.map { |contract| contract['id'] }
        expect(contract_ids).to include(open_contract.id, open_contract2.id)
        expect(contract_ids).not_to include(taken_contract.id, finished_contract.id)
      end
    end

    context 'when there is no contracts' do
      it 'returns an empty list' do
        get '/v1/contracts/list_open_contracts'

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq('[]')
      end
    end
  end

  describe 'POST /v1/contracts/:id/accept_contract' do
    let(:contract) { create(:contract) }
    let(:ship) { create(:ship) }

    context 'when the contract can be accepted' do
      it 'returns success' do
        allow_any_instance_of(ContractAcceptanceService).to receive(:accept).and_return(true)

        post "/v1/contracts/#{contract.id}/accept_contract", params: { ship_id: ship.id }

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the contract cannot be accepted' do
      it 'returns an error' do
        allow_any_instance_of(ContractAcceptanceService).to receive(:accept).and_return(false)
        allow_any_instance_of(ContractAcceptanceService).to receive(:errors).and_return(['Invalid contract'])

        post "/v1/contracts/#{contract.id}/accept_contract", params: { ship_id: ship.id }

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to eq(['Invalid contract'])
      end
    end
  end
end
