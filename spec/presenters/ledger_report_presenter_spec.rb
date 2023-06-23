# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LedgerReportPresenter do
  describe '#generate_transactions_ledger_report' do
    let!(:contract1) { create(:contract, description: 'Water to Demeter') }
    let!(:contract2) { create(:contract, description: 'Food to Aqua') }

    it 'returns the transactions ledger report' do
      presenter = described_class.new
      report_data = presenter.generate_transactions_ledger_report

      expect(report_data).to contain_exactly(
        "Water to Demeter paid: ₭100.00",
        "Food to Aqua paid: ₭100.00"
      )
    end
  end
end
