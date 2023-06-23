FactoryBot.define do
  factory :fuel_refill do
    fuel { 12 }
    cost { fuel * 7 }
    discounted { false }
    association :pilot
  end
end
