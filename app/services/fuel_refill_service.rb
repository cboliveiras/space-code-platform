# frozen_string_literal: true

class FuelRefillService
  attr_reader :pilot, :to_planet
  attr_accessor :errors

  def initialize(pilot, to_planet)
    @pilot = pilot
    @ship = Ship.find_by(pilot: @pilot)
    @to_planet = to_planet
    @errors = []
  end

  def refill?
    return false unless pilot_has_ship? && need_additional_fuel?
    return false unless has_fuel_capacity? && has_enough_credits?

    @pilot.update(credits: @pilot.credits - calculate_cost)
    @ship.update(fuel_level: @ship.fuel_level + required_fuel)
    FuelRefill.create(pilot_id: @pilot.id, fuel: required_fuel, cost: calculate_cost)

    true
  end

  private

  def pilot_has_ship?
    validate_pilot_has_ship = @pilot.ship.present?

    @errors << 'Pilot has no ship' unless validate_pilot_has_ship

    validate_pilot_has_ship
  end

  def required_fuel
    required_fuel = fuel_calculation_service.calculate_fuel_consumption(@pilot.location, @to_planet) - @ship.fuel_level

    return 0 if required_fuel <= 0

    required_fuel
  end

  def need_additional_fuel?
    validate_fuel_required = required_fuel > 0

    @errors << 'Ship has enough fuel to travel' if required_fuel <= 0

    validate_fuel_required
  end

  def has_fuel_capacity?
    fuel_to_travel = fuel_calculation_service.calculate_fuel_consumption(@pilot.location, @to_planet)
    validate_fuel_capacity = (@ship.fuel_level + required_fuel) <= @ship.fuel_capacity

    @errors << 'Ship cannot handle the necessary fuel' unless validate_fuel_capacity

    validate_fuel_capacity
  end

  def has_enough_credits?
    validate_credits = @pilot.credits >= required_fuel * 7

    @errors << 'Insufficient credits' unless validate_credits

    validate_credits
  end

  def calculate_cost
    required_fuel * 7
  end

  def fuel_calculation_service
    FuelCalculationService.new
  end
end
