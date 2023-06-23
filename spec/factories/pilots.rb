# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :pilot do
    name { 'Jane Doe' }
    age { 25 }
    certification { FFaker::Lorem.characters(7) }
    credits { 100 }
    location { 'Andvari' }
  end
end
