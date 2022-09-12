class Mechanics < ApplicationController
    def index
        @mechanics = Mechanic.all
    end
end