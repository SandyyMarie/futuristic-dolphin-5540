require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'relationships' do
    it { should have_many(:ride_mechanics) }
    it { should have_many(:rides).through(:ride_mechanics) }
  end

  before :each do
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

      @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
      @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
      @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
      @jaws = @six_flags.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)

      @lisa = Mechanic.create!(name: "Lisa Simmons", years_of_experience: 11)
      @jason = Mechanic.create!(name: "Jason Mayor", years_of_experience: 5)
      
      @lisa.rides << @hurler
      @lisa.rides << @scrambler
      @lisa.rides << @ferris
      RideMechanic.create!(mechanic: @lisa, ride: @jaws) #alternative way but not as used
      #essentially both are creating a new record in the join table
  end

  describe 'average_experience' do
    it 'returns the average experience across all mechanics' do
      expect(Mechanic.avg_years_experience).to eq(8)
    end
  end

  describe 'instance methods' do
    it 'returns the mechanics open rides, sorted by thrills desc' do
      expect(@lisa.open_rides_by_thrill).to eq([@hurler, @jaws, @scrambler])
    end
  end
end