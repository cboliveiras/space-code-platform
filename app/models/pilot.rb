# frozen_string_literal: true

class Pilot < ApplicationRecord
  has_one :ship
  has_many :fuel_refills

  validates :name, :age, :location, presence: true
  validates :certification, presence: true, uniqueness: true
  validate :luhn_validation, on: :create

  validates :age, numericality: { greater_than_or_equal_to: 18 }
  validates :credits, numericality: { greater_than_or_equal_to: 0 }


  private

  def luhn_validation
    return unless certification.present?

    digits = certification.scan(/\d/).map(&:to_i)
    checksum = 0

    digits.reverse.each_with_index do |digit, index|
      checksum += index.even? ? digit : (digit * 2).divmod(10).sum if index < 15
    end

    errors.add(:certification, 'is invalid') unless (checksum % 10).zero?
  end
end
