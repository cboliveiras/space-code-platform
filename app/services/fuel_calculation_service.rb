# frozen_string_literal: true

class FuelCalculationService
  ROUTES = [
    { from_planet: 'Andvari', to_planet: 'Demeter', fuel: 43 },
    { from_planet: 'Andvari', to_planet: 'Aqua', fuel: 13 },
    { from_planet: 'Andvari', to_planet: 'Calas', fuel: 23 },
    { from_planet: 'Demeter', to_planet: 'Andvari', fuel: 45 },
    { from_planet: 'Demeter', to_planet: 'Aqua', fuel: 22 },
    { from_planet: 'Demeter', to_planet: 'Calas', fuel: 25 },
    { from_planet: 'Aqua', to_planet: 'Andvari', fuel: 32 },
    { from_planet: 'Aqua', to_planet: 'Demeter', fuel: 30 },
    { from_planet: 'Aqua', to_planet: 'Calas', fuel: 12 },
    { from_planet: 'Calas', to_planet: 'Andvari', fuel: 20 },
    { from_planet: 'Calas', to_planet: 'Demeter', fuel: 25 },
    { from_planet: 'Calas', to_planet: 'Aqua', fuel: 15 }
  ].freeze

  def calculate_fuel_consumption(from_planet, to_planet)
    route = ROUTES.find { |r| r[:from_planet] == from_planet && r[:to_planet] == to_planet }
    route ? route[:fuel] : 0
  end
end
