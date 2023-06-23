# frozen_string_literal: true

module V1
  class ReportsController < ApplicationController
    def resource_weights
      presenter = ResourceWeightsPresenter.new
      report_data = presenter.generate_resource_weights_report

      render json: report_data
    end

    def resource_percentage
      presenter = ResourcePercentagePresenter.new
      report_data = presenter.generate_resource_percentage_report

      render json: report_data
    end

    def ledger_transactions
      presenter = LedgerReportPresenter.new
      report_data = presenter.generate_transactions_ledger_report

      render json: report_data
    end
  end
end
