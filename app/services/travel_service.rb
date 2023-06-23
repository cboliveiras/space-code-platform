# frozen_string_literal: true

class TravelService
  attr_reader :pilot, :to_planet

  def initialize(pilot, to_planet)
    @pilot = pilot
    @ship = @pilot&.ship
    @to_planet = to_planet
  end

  def perform_travel
    return false unless @pilot && @ship

    fuel_consumption = FuelCalculationService.new.calculate_fuel_consumption(@pilot.location, to_planet)

    if ship_has_enough_fuel?(fuel_consumption)
      update_pilot_location(to_planet)
      decrement_ship_fuel_level(fuel_consumption)
      true
    else
      false
    end
  end

  private

  def ship_has_enough_fuel?(fuel_consumption)
    @ship.fuel_level >= fuel_consumption
  end

  def update_pilot_location(to_planet)
    @pilot.update(location: to_planet)
  end

  def decrement_ship_fuel_level(fuel_consumption)
    @ship.decrement(:fuel_level, fuel_consumption)
    @ship.save!
  end
end
