require 'rails_helper'

RSpec.describe ContractResource, type: :model do
  describe 'associations' do
    it { should belong_to(:contract) }
    it { should belong_to(:resource) }
  end
end
