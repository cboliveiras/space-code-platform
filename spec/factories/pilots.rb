# frozen_string_literal: true

FactoryBot.define do
  factory :pilot do
    name { 'Jane Doe' }
    age { 25 }
    certification { '205979-8' }
    credits { 100 }
    location { 'Andvari' }
  end
end
