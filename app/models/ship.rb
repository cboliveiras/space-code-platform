# frozen_string_literal: true

class Ship < ApplicationRecord
  belongs_to :pilot
  has_many :contracts
  has_many :travels

  validates :fuel_capacity, :fuel_level, :weight_capacity, numericality: { greater_than_or_equal_to: 0 }

  def can_handle_weight?(weight)
    self.weight_capacity >= weight
  end
end
