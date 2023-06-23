# frozen_string_literal: true

class LedgerReportPresenter
  def generate_transactions_ledger_report
    contracts = Contract.order(created_at: :asc)
    report_data = []

    contracts.each do |contract|
      report_data << "#{contract.description} paid: #{format_amount(contract.value)}"
    end

    report_data
  end

  private

  def format_amount(value)
    "₭#{'%.2f' % value}"
  end
end
