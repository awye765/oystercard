require 'oystercard'

class Journey

  # PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  # , :journeys

  def initialize(entry_station=nil)
    @entry_station = entry_station
    # @journeys = Hash.new
    @complete = false
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
    @entry_station = nil
  end

end