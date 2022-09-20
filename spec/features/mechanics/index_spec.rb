require 'rails_helper'

RSpec.describe 'As a User, when I visit the Mechanics Index Page' do
    before :each do
        @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
        @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

        @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
        @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
        @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

        @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)

        @lisa = Mechanic.create!(name: "Lisa Simmons", years_of_experience: 11)
        @jason = Mechanic.create!(name: "Jason Mayor", years_of_experience: 5)
    end

    it 'shows a header saying "All Mechanics" with a list of all mechanics names and their experience' do
        visit "/mechanics"
        # within "#mechanic-#{@lisa}" do
            expect(page).to have_content("Lisa Simmons, 11 years of experience")
        # end
        # within "#mechanic-#{@jason}" do
            expect(page).to have_content("Jason Mayor, 5 years of experience")
        # end 
    end

    it 'also shows the average years of experience across all mechanics' do
        visit "/mechanics"
        expect(page).to have_content("Combined, their average years of experience is #{Mechanic.avg_years_experience} years")
    end
end