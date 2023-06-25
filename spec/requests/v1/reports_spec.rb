# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reports API', type: :request do
  describe 'GET /v1/reports/resource_weights' do
    let(:report_data) do
      {
        'Andvari' => {
          'sent' => {
            'Food' => 50,
            'Water' => 30
          },
          'received' => {}
        },
        'Demeter' => {
          'sent' => {},
          'received' => {}
        },
        'Aqua' => {
          'sent' => {},
          'received' => {
            'Minerals' => 20
          }
        }
      }
    end

    before do
      allow_any_instance_of(ResourceWeightsPresenter)
        .to receive(:generate_resource_weights_report)
        .and_return(report_data)
    end

    it 'returns the resource weights report' do
      get '/v1/reports/resource_weights'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(report_data)
    end
  end

  describe 'GET /v1/reports/resource_percentage' do
    let(:report_data) do
      {
        'Pilot 1' => {
          'Food' => 50.0,
          'Water' => 30.0
        },
        'Pilot 2' => {
          'Minerals' => 20.0
        }
      }
    end

    before do
      allow_any_instance_of(ResourcePercentagePresenter)
        .to receive(:generate_resource_percentage_report)
        .and_return(report_data)
    end

    it 'returns the resource percentage report' do
      get '/v1/reports/resource_percentage'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(report_data)
    end
  end

  describe 'GET /v1/reports/ledger_transactions' do
    let(:report_data) do
      [
        'Water to Demeter paid: ₭2178.00',
        'Food to Aqua paid: ₭2178.00',
        'Minerals to Calas paid: ₭2178.00'
      ]
    end

    before do
      allow_any_instance_of(LedgerReportPresenter)
        .to receive(:generate_transactions_ledger_report)
        .and_return(report_data)
    end

    it 'returns the transactions ledger report' do
      get '/v1/reports/ledger_transactions'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(report_data)
    end
  end
end
