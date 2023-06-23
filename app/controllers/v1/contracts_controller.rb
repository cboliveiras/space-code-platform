# frozen_string_literal: true

module V1
  class ContractsController < ApplicationController
    before_action :set_contract, only: [:show, :update, :accept_contract]
    before_action :open_contracts, only: [:list_open_contracts]

    def index
      @contracts = Contract.all

      render json: @contracts, status: :ok
    end

    def show
      render json: @contract, status: :ok
    end

    def create
      @contract = Contract.new(contract_params)

      if @contract.save
        render json: @contract, status: :created
      else
        render json: @contract.errors, status: :unprocessable_entity
      end
    end

    def update
      if @contract.update(update_contract_params)
        render json: @contract
      else
        render json: @contract.errors, status: :unprocessable_entity
      end
    end

    def list_open_contracts
      render json: @open_contracts
    end

    def accept_contract
      ship = Ship.find_by(id: params[:ship_id])

      service = ContractAcceptanceService.new(@contract, ship)

      if service.accept
        render json: @contract, status: :ok
      else
        render json: { errors: service.errors }, status: :unprocessable_entity
      end
    end

    private

    def open_contracts
      @open_contracts = Contract.where(status: 'OPEN')

      return render json: [], status: :not_found unless @open_contracts
    end

    def set_contract
      @contract = Contract.find_by(id: params[:id])

      render json: { error: 'Contract not found' }, status: :not_found unless @contract
    end

    def contract_params
      params.require(:contract).permit(:description, :from_planet, :to_planet, :value, :status, :ship_id)
    end

    def update_contract_params
      params.require(:contract).permit(:status, :ship_id)
    end
  end
end
