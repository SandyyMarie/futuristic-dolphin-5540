require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'relationships' do
    it { should belong_to(:rides) }
    # it { should have_many(:rides) }
  end
end