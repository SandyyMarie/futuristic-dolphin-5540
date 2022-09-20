require 'rails_helper'

RSpec.describe 'As a User, when I visit the Mechanics Index Page' do
    before :each do
        @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

        @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
        @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
        @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
        @jaws = @six_flags.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)
        @superman = @six_flags.rides.create!(name: 'Superman', thrill_rating: 10, open: true)

        @lisa = Mechanic.create!(name: "Lisa Simmons", years_of_experience: 11)
        @jason = Mechanic.create!(name: "Jason Mayor", years_of_experience: 5)

        @lisa.rides << @hurler
        @lisa.rides << @scrambler
        @lisa.rides << @ferris
        RideMechanic.create!(mechanic: @lisa, ride: @jaws) #alternative way but not as used
        #essentially both are creating a new record in the join table
    end

    it 'shows al the mechanic attributes' do
      visit "/mechanics/#{@lisa.id}"

      expect(page).to have_content(@lisa.name)
      expect(page).to have_content("Experience: #{@lisa.years_of_experience} years")
    end

    it 'shows the rides open that the mechanic is working on ' do
       visit "/mechanics/#{@lisa.id}"
       expect(page).to have_content("Rides currently working on:")
       expect(page).to have_content(@hurler.name)
       expect(page).to have_content(@scrambler.name)
       expect(page).to have_content(@jaws.name)
       expect(page).to_not have_content(@ferris.name)
    end


    it 'orders rides by thrill rating in descending order' do
      visit "/mechanics/#{@lisa.id}"
      expect(@hurler.name).to appear_before(@jaws.name)
      expect(@jaws.name).to appear_before(@scrambler.name)
    end

    it 'can add a ride to the mechanics workload from the show page' do
      visit "/mechanics/#{@lisa.id}"
      expect(page).to_not have_content(@superman.name)
      expect(page).to have_content("Add a ride to workload")
      fill_in :ride_id, with: @superman.id
      click_button 'Submit'
      expect(page).to have_content(@superman.name)
    end

end