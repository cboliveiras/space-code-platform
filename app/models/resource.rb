# frozen_string_literal: true

class Resource < ApplicationRecord
  has_many :contract_resources
  has_many :contracts, through: :contract_resources

  validates :name, :weight, presence: true
end
