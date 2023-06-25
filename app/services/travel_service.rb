# frozen_string_literal: true

class TravelService
  attr_reader :pilot, :to_planet
  attr_accessor :errors

  def initialize(pilot, to_planet)
    @pilot = pilot
    @ship = @pilot&.ship
    @to_planet = to_planet
    @errors = []
  end

  def perform_travel
    return false unless pilot_has_ship?
    return false if pilot_already_at_destination?

    fuel_consumption = FuelCalculationService.new.calculate_fuel_consumption(@pilot.location, to_planet)

    if ship_has_enough_fuel?(fuel_consumption)
      create_travel_record(fuel_consumption)
      update_pilot_location(to_planet)
      decrement_ship_fuel_level(fuel_consumption)
      true
    else
      false
    end
  end

  private

  def pilot_already_at_destination?
    validate_pilot_destination = @pilot.location == to_planet
    @errors << 'Pilot already at destination' if validate_pilot_destination

    validate_pilot_destination
  end

  def ship_has_enough_fuel?(fuel_consumption)
    validate_fuel_quantity = @ship.fuel_level >= fuel_consumption
    @errors << 'Insufficient fuel. Please refuel.' unless validate_fuel_quantity

    validate_fuel_quantity
  end

  def update_pilot_location(to_planet)
    @pilot.update(location: to_planet)
  end

  def decrement_ship_fuel_level(fuel_consumption)
    @ship.decrement(:fuel_level, fuel_consumption)
    @ship.save!
  end

  def pilot_has_ship?
    validate_pilot_has_ship = @pilot.ship.present?

    @errors << 'Pilot has no ship' unless validate_pilot_has_ship

    validate_pilot_has_ship
  end

  def create_travel_record(fuel_consumption)
    Travel.create!(ship_id: @ship.id, from_planet: @pilot.location, to_planet:, fuel_consumption:)
  end
end
