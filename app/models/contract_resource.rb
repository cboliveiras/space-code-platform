# frozen_string_literal: true

class ContractResource < ApplicationRecord
  belongs_to :contract
  belongs_to :resource
end
