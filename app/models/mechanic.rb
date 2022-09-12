class Mechanic < ApplicationRecord
    has_many :ride_mechanics
    has_many :ride, through: :ride_mechanics

    def self.avg_years_experience
        @mechanics = Mechanic.all

        acc = 0
        @mechanics.each do |mechanic|
            acc += mechanic.years_of_experience
        end

        if (@mechanics.count != 0)
            acc / @mechanics.count
        else
            0
        end
    end
end