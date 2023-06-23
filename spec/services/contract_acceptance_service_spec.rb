# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContractAcceptanceService, type: :service do
  let(:contract) { create(:contract) }
  let(:ship) { create(:ship) }

  subject { described_class.new(contract, ship) }

  describe '#accept' do
    context 'when the contract can be accepted' do
      it 'updates the contract status and ship association' do
        expect(contract).to receive(:open?).and_return(true)
        expect(contract.resources).to receive(:sum).and_return(50)
        expect(ship).to receive(:weight_capacity).and_return(100)

        expect(contract).to receive(:ship=).with(ship)
        expect(contract).to receive(:status=).with('TAKEN')
        expect(contract).to receive(:save).and_return(true)

        expect(subject.accept).to be_truthy
        expect(subject.errors).to be_empty
      end
    end

    context 'when the contract is not in the open status' do
      it 'returns false and adds an error' do
        expect(contract).to receive(:open?).and_return(false)

        expect(subject.accept).to be_falsy
        expect(subject.errors).to include('Contract has not an OPEN status')
      end
    end

    context 'when the ship does not exist' do
      let(:ship) { nil }

      it 'returns false and adds an error' do
        expect(subject.accept).to be_falsy
        expect(subject.errors).to include('Ship not found')
      end
    end

    context 'when the ship cannot handle the contract weight' do
      it 'returns false and adds an error' do
        expect(contract).to receive(:open?).and_return(true)
        expect(contract.resources).to receive(:sum).and_return(150)
        expect(ship).to receive(:weight_capacity).and_return(100)

        expect(subject.accept).to be_falsy
        expect(subject.errors).to include('Ship cannot handle the contract weight')
      end
    end
  end
end
