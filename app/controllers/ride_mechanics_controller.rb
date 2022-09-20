class RideMechanicsController < ApplicationController
  def create
    # Maintenence.create!(ride_id: params(:ride_id), mechanic_id: params[:mechanic_id]) #not taking advantage of active record
    mechanic = Mechanic.find(params[:mechanic_id])
    ride = Ride.find(params[:ride_id])
    RideMechanic.create(ride: ride, mechanic: mechanic)
    redirect_to mechanic_path(mechanic)
  end
end