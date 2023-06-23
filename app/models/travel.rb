# frozen_string_literal: true

class Travel < ApplicationRecord
  belongs_to :ship, optional: true

  validates :to_planet, :from_planet, :fuel_consumption, presence: true
end
