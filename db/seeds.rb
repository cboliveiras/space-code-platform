# frozen_string_literal: true

# Seed data for pilots

def generate_valid_certification
  loop do
    certification = FFaker::Number.number(digits: 7).to_s
    next unless luhn_validation(certification)

    return certification.insert(6, '-')
  end
end

def luhn_validation(certification)
  digits = certification.scan(/\d/).map(&:to_i)
  checksum = 0

  digits.reverse.each_with_index do |digit, index|
    checksum += index.even? ? digit : (digit * 2).divmod(10).sum if index < 15
  end

  (checksum % 10).zero?
end

location = %w[Andvari Demeter Aqua Calas].sample
credits = rand(500..1000)

10.times do
  Pilot.create!(
    name: FFaker::Name.name,
    age: rand(18..50),
    certification: generate_valid_certification,
    credits:,
    location:
  )
end

# Seed data for ships

10.times do
  fuel_capacity = rand(50..100)
  fuel_level = rand(0..fuel_capacity)
  weight_capacity = rand(1000..2000)
  pilot_id = (1..10).to_a.sample

  Ship.create!(fuel_capacity:, fuel_level:, weight_capacity:, pilot_id: pilot_id)
end

# Seed for resources

resources = [
  { name: 'minerals', weight: 45 },
  { name: 'water', weight: 30 },
  { name: 'food', weight: 80 }
]

resources.each do |resource|
  Resource.create!(resource)
end

# Seed for open_contracts

open_contracts = [
  { description: 'Water to Demeter', from_planet: 'Andvari', to_planet: 'Demeter', value: rand(500..3000),
    status: 'OPEN' },
  { description: 'Food to Aqua', from_planet: 'Andvari', to_planet: 'Aqua', value: rand(500..3000), status: 'OPEN' },
  { description: 'Minerals to Calas', from_planet: 'Andvari', to_planet: 'Calas', value: rand(500..3000),
    status: 'OPEN' },
  { description: 'Water and Food to Andvari', from_planet: 'Demeter', to_planet: 'Andvari', value: rand(500..3000),
    status: 'OPEN' },
  { description: 'Water and Minerals to Aqua', from_planet: 'Demeter', to_planet: 'Aqua', value: rand(500..3000),
    status: 'OPEN' },
  { description: 'Minerals and Food to Calas', from_planet: 'Demeter', to_planet: 'Calas', value: rand(500..3000),
    status: 'OPEN' },
  { description: 'Water to Andvari', from_planet: 'Aqua', to_planet: 'Andvari', value: rand(500..3000),
    status: 'OPEN' },
  { description: 'Minerals to Demeter', from_planet: 'Aqua', to_planet: 'Demeter', value: rand(500..3000),
    status: 'OPEN' },
  { description: 'Food to Calas', from_planet: 'Aqua', to_planet: 'Calas', value: rand(500..3000), status: 'OPEN' },
  { description: 'Food and Minerals to Andvari', from_planet: 'Calas', to_planet: 'Andvari', value: rand(500..3000),
    status: 'OPEN' },
  { description: 'Food to Demeter', from_planet: 'Calas', to_planet: 'Demeter', value: rand(500..3000),
    status: 'OPEN' },
  { description: 'Minerals to Aqua', from_planet: 'Calas', to_planet: 'Aqua', value: rand(500..3000), status: 'OPEN' }
]

open_contracts.each do |contract|
  contract = Contract.create!(contract)
  rand(1..3).times do
    contract.resources << Resource.all.sample
    contract.save!
  end
end

# Seed for finished_contracts

finished_contracts = [
  { description: 'Water to Demeter', from_planet: 'Andvari', to_planet: 'Demeter', value: rand(500..3000),
    status: 'FINISHED' },
  { description: 'Food to Aqua', from_planet: 'Andvari', to_planet: 'Aqua', value: rand(500..3000),
    status: 'FINISHED' },
  { description: 'Minerals to Calas', from_planet: 'Andvari', to_planet: 'Calas', value: rand(500..3000),
    status: 'FINISHED' },
  { description: 'Water and Food to Andvari', from_planet: 'Demeter', to_planet: 'Andvari', value: rand(500..3000),
    status: 'FINISHED' },
  { description: 'Water and Minerals to Aqua', from_planet: 'Demeter', to_planet: 'Aqua', value: rand(500..3000),
    status: 'FINISHED' },
  { description: 'Minerals and Food to Calas', from_planet: 'Demeter', to_planet: 'Calas', value: rand(500..3000),
    status: 'FINISHED' },
  { description: 'Water to Andvari', from_planet: 'Aqua', to_planet: 'Andvari', value: rand(500..3000),
    status: 'FINISHED' },
  { description: 'Minerals to Demeter', from_planet: 'Aqua', to_planet: 'Demeter', value: rand(500..3000),
    status: 'FINISHED' },
  { description: 'Food to Calas', from_planet: 'Aqua', to_planet: 'Calas', value: rand(500..3000), status: 'FINISHED' },
  { description: 'Food and Minerals to Andvari', from_planet: 'Calas', to_planet: 'Andvari', value: rand(500..3000),
    status: 'FINISHED' },
  { description: 'Food to Demeter', from_planet: 'Calas', to_planet: 'Demeter', value: rand(500..3000),
    status: 'FINISHED' },
  { description: 'Minerals to Aqua', from_planet: 'Calas', to_planet: 'Aqua', value: rand(500..3000),
    status: 'FINISHED' }
]

finished_contracts.each do |contract|
  ship = Ship.find_by(id: rand(1..10))
  contract = Contract.create!(contract.merge(ship_id: ship.id))

  rand(1..3).times do
    contract.resources << Resource.all.sample
  end

  contract.save!
end

# Seed for travels

travels = [
  { from_planet: 'Andvari', to_planet: 'Demeter', fuel_consumption: 43, ship_id: rand(1..10) },
  { from_planet: 'Andvari', to_planet: 'Aqua', fuel_consumption: 13, ship_id: rand(1..10) },
  { from_planet: 'Andvari', to_planet: 'Calas', fuel_consumption: 23, ship_id: rand(1..10) },
  { from_planet: 'Demeter', to_planet: 'Andvari', fuel_consumption: 45, ship_id: rand(1..10) },
  { from_planet: 'Demeter', to_planet: 'Aqua', fuel_consumption: 22, ship_id: rand(1..10) },
  { from_planet: 'Demeter', to_planet: 'Calas', fuel_consumption: 25, ship_id: rand(1..10) },
  { from_planet: 'Aqua', to_planet: 'Andvari', fuel_consumption: 32, ship_id: rand(1..10) },
  { from_planet: 'Aqua', to_planet: 'Demeter', fuel_consumption: 30, ship_id: rand(1..10) },
  { from_planet: 'Aqua', to_planet: 'Calas', fuel_consumption: 12, ship_id: rand(1..10) },
  { from_planet: 'Calas', to_planet: 'Andvari', fuel_consumption: 20, ship_id: rand(1..10) },
  { from_planet: 'Calas', to_planet: 'Demeter', fuel_consumption: 25, ship_id: rand(1..10) },
  { from_planet: 'Calas', to_planet: 'Aqua', fuel_consumption: 15, ship_id: rand(1..10) },
  { from_planet: 'Andvari', to_planet: 'Demeter', fuel_consumption: 43, ship_id: nil },
  { from_planet: 'Andvari', to_planet: 'Aqua', fuel_consumption: 13, ship_id: nil },
  { from_planet: 'Andvari', to_planet: 'Calas', fuel_consumption: 23, ship_id: nil },
  { from_planet: 'Demeter', to_planet: 'Andvari', fuel_consumption: 45, ship_id: nil },
  { from_planet: 'Demeter', to_planet: 'Aqua', fuel_consumption: 22, ship_id: nil },
  { from_planet: 'Demeter', to_planet: 'Calas', fuel_consumption: 25, ship_id: nil },
  { from_planet: 'Aqua', to_planet: 'Andvari', fuel_consumption: 32, ship_id: nil },
  { from_planet: 'Aqua', to_planet: 'Demeter', fuel_consumption: 30, ship_id: nil },
  { from_planet: 'Aqua', to_planet: 'Calas', fuel_consumption: 12, ship_id: nil },
  { from_planet: 'Calas', to_planet: 'Andvari', fuel_consumption: 20, ship_id: nil },
  { from_planet: 'Calas', to_planet: 'Demeter', fuel_consumption: 25, ship_id: nil },
  { from_planet: 'Calas', to_planet: 'Aqua', fuel_consumption: 15, ship_id: nil }
].freeze

travels.each do |travel|
  ship_id = travel[:ship_id] if travel[:ship_id].present?
  Travel.create!(travel.merge(ship_id: ship_id))
end
