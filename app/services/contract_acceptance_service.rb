# frozen_string_literal: true

class ContractAcceptanceService
  attr_reader :contract, :ship
  attr_accessor :errors

  def initialize(contract, ship)
    @contract = contract
    @ship = ship
    @errors = []
  end

  def accept
    validate_contract_status
    validate_ship_existence
    validate_ship_capacity

    if @errors.empty?
      @contract.ship = @ship
      @contract.status = 'TAKEN'
      @contract.save
      true
    else
      false
    end
  end

  private

  def validate_contract_status
    @errors << "Contract is not in the 'OPEN' status" unless @contract.open?
  end

  def validate_ship_existence
    @errors << 'Ship not found' if @ship.nil?
  end

  def validate_ship_capacity
    return if @ship.nil?

    total_weight = contract.resources.sum(:weight)
    if total_weight > @ship.weight_capacity
      @errors << 'Ship cannot handle the contract weight'
    end
  end
end
