# frozen_string_literal: true

class FuelRefill < ApplicationRecord
  belongs_to :pilot

  validates :fuel, :cost, presence: true
end
