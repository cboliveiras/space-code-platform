class GrantCreditsService
  attr_reader :pilot, :travel_id, :contract_id
  attr_accessor :errors

  def initialize(pilot, travel_id, contract_id)
    @pilot = pilot
    @ship = @pilot&.ship
    @fuel_refill = @pilot&.fuel_refills
    @travel = Travel.find(travel_id)
    @contract = Contract.find(contract_id)
    @errors = []
  end

  def grant_credits?
    return false unless @pilot && @ship

    return false unless valid_contract? && !pilot_awarded?

    grant_credits_to_pilot
    update_travel_pilot
    update_contract_status
    @errors.empty?
  end

  private

  def valid_contract?
    validate_contract = same_route? && !@contract.finished?

    @errors << 'Invalid contract' unless validate_contract

    validate_contract
  end

  def same_route?
    validate_route = @travel.from_planet == @contract.from_planet && @travel.to_planet == @contract.to_planet

    @errors << 'Invalid route' unless validate_route

    validate_route
  end

  def pilot_awarded?
    validate_pilot_awards = @travel.ship_id == @pilot.ship&.id

    @errors << 'Pilot already awarded for this travel' unless validate_pilot_awards

    validate_pilot_awards
  end

  def update_travel_pilot
    @travel.update(ship_id: @pilot.ship.id)
  end

  def grant_credits_to_pilot
    @pilot.update(credits: @pilot.credits + @contract.value)
  end

  def update_contract_status
    @contract.update(status: 'finished')
  end
end
