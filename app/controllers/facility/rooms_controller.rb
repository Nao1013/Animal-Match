class Facility::RoomsController < ApplicationController
  def index
    @reader = Reader.joins(:rooms).merge(Room.where(facility_id: current_facility.id))
    # @reader = Reader.joins(:rooms).where("rooms.facility_id = ?", current_facility.id)
  end

  def show
  end
end
