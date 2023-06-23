# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ResourceWeightsPresenter do
  describe '#generate_resource_weights_report' do
    let!(:contract) { create(:contract, :finished, :with_ship) }

    subject { described_class.new.generate_resource_weights_report }

    it 'generates the correct resource weights report' do
      expected_report = {
        contract.from_planet => {
          sent: {
            contract.resources[0].name => contract.resources[0].weight,
          },
          received: {}
        },
        contract.to_planet => {
          sent: {},
          received: {
            contract.resources[0].name => contract.resources[0].weight,
          }
        },
      }

      expect(subject).to eq(expected_report)
    end
  end
end
