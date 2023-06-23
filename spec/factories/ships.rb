# frozen_string_literal: true

FactoryBot.define do
  factory :ship do
    fuel_capacity { 150 }
    fuel_level { 85 }
    weight_capacity { 30 }
    association :pilot

    trait :with_contract do
      after(:create) do |ship|
        create(:contract, ship: ship)
      end
    end

    trait :with_travels do
      after(:create) do |ship|
        create_list(:travel, 2, ship: ship)
      end
    end
  end
end
