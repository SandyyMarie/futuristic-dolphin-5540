class Mechanic < ApplicationRecord
    has_many :ride_mechanics
    has_many :ride, through: :ride_mechanics
end