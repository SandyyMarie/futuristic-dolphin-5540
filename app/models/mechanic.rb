class Mechanic < ApplicationRecord
    has_many :ride_mechanics
    has_many :rides, through: :ride_mechanics

    def self.avg_years_experience
        average(:years_of_experience)
    end

    def open_rides_by_thrill
        self.rides.where(open: true).order(thrill_rating: :desc) #could also be a rides class method where you just start on the .where
    end
end