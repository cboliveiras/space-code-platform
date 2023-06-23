# frozen_string_literal: true

class FuelRefillService
  def initialize(pilot, to_planet)
    @pilot = pilot
    @ship = @pilot.ship if @pilot
    @to_planet = to_planet
  end

  def refill?
    return false unless @ship && @pilot
    return false if !has_fuel_capacity? || !has_enough_credits?

    cost = calculate_cost

    return false unless cost.positive?

    @pilot.update(credits: @pilot.credits - cost)
    @ship.update(fuel_level: @ship.fuel_level + required_fuel)

    FuelRefill.create(pilot_id: @pilot.id, fuel: required_fuel, cost: cost)

    true
  end

  private

  def required_fuel
    required_fuel = fuel_calculation_service.calculate_fuel_consumption(@pilot.location, @to_planet) - @ship.fuel_level

    return 0 if required_fuel.negative?

    required_fuel
  end

  def has_fuel_capacity?

    fuel_to_travel = fuel_calculation_service.calculate_fuel_consumption(@pilot.location, @to_planet)

    (@ship.fuel_level + required_fuel) <= @ship.fuel_capacity
  end

  def has_enough_credits?
    @pilot.credits >= required_fuel * 7
  end

  def calculate_cost
    required_fuel * 7
  end

  def fuel_calculation_service
    FuelCalculationService.new
  end
end
