# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ResourcePercentagePresenter do
  describe '#generate_resource_percentage_report' do
    let!(:ship) { create(:ship, :with_contract) }
    let!(:contract) { create(:contract, :finished, ship_id: ship.id) }

    it 'returns the resource percentage report' do
      presenter = described_class.new
      report_data = presenter.generate_resource_percentage_report

      expect(report_data).to eq("#{ship.pilot.name}" => { "#{contract.resources.first.name}" => 200.0 })
    end
  end
end
