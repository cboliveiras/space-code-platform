# frozen_string_literal: true

class Pilot < ApplicationRecord
  has_one :ship
  has_many :fuel_refills

  validates :name, :age, :location, presence: true
  validates :certification, presence: true, uniqueness: true
  validates :age, numericality: { greater_than_or_equal_to: 18 }
  validates :credits, numericality: { greater_than_or_equal_to: 0 }
end
