# frozen_string_literal: true

class Contract < ApplicationRecord
  belongs_to :ship, optional: true

  has_many :contract_resources
  has_many :resources, through: :contract_resources

  validates :description, :from_planet, :to_planet, presence: true
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :ship_id, presence: true, if: -> { taken? || finished? }
  validate :validate_ship_assigned, if: :taken?

  enum status: { open: 'OPEN', taken: 'TAKEN', finished: 'FINISHED' }

  private

  def total_weight
    resources.sum(:weight)
  end

  def validate_ship_assigned
    errors.add(:base, 'Contract must have a ship assigned to be taken') if ship.blank?
  end
end
