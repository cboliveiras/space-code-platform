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
    return false unless pilot_has_ship? && same_route?
    return false unless !pilot_awarded?
    return false if contract_already_finished?

    if @errors.empty?
      grant_credits_to_pilot
      update_travel_pilot
      update_contract_status

      true
    else
      false
    end
  end

  private

  def contract_already_finished?
    validate_contract = @contract.finished?

    @errors << 'Contract already finished' if validate_contract

    validate_contract
  end

  def same_route?
    validate_route = @travel.from_planet == @contract.from_planet && @travel.to_planet == @contract.to_planet

    @errors << 'Invalid route' unless validate_route

    validate_route
  end

  def pilot_awarded?
    validate_pilot_awards = @travel.ship_id == @pilot.ship&.id

    @errors << 'Pilot already awarded for this travel' if validate_pilot_awards

    validate_pilot_awards
  end

  def pilot_has_ship?
    validate_pilot_has_ship = @pilot.ship.present?

    @errors << 'Pilot has no ship' unless validate_pilot_has_ship

    validate_pilot_has_ship
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
