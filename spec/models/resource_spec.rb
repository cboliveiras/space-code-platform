require 'rails_helper'

RSpec.describe Resource, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:weight) }
  end

  describe 'associations' do
    it { should have_many(:contract_resources) }
    it { should have_many(:contracts).through(:contract_resources) }
  end
end
