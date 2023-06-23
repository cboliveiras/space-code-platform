# frozen_string_literal: true

FactoryBot.define do
  factory :contract do
    description { 'Transportation of water to Planet A' }
    from_planet { 'Planet A' }
    to_planet { 'Planet B' }
    value { 100 }
    status { 'OPEN' }

    trait :with_ship do
      association :ship
    end

    trait :taken do
      status { 'TAKEN' }
    end

    trait :finished do
      status { 'FINISHED' }
    end

    resources { [association(:resource)] }
  end
end
