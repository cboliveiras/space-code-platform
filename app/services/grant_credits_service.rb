class GrantCreditsService
  def initialize(pilot, travel_id, contract_id)
    @pilot = pilot
    @fuel_refill = @pilot.fuel_refills
    @travel = Travel.find(travel_id)
    @contract = Contract.find(contract_id)
  end

  def grant_credits?
    return false unless @pilot && @ship

    return false unless valid_contract? && !pilot_awarded?

    grant_credits_to_pilot
    update_travel_pilot
    update_contract_status
    true
  end

  private

  def valid_contract?
    same_route? && !@contract.finished?
  end

  def same_route?
    @travel.from_planet == @contract.from_planet && @travel.to_planet == @contract.to_planet
  end

  def pilot_awarded?
    @travel.ship_id == @pilot.ship.id
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
