require_relative 'oystercard'

class Journey

  # PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station=nil)
    @entry_station = entry_station
    @complete = false
  end

  def finish(station)
    @exit_station = station
    @complete = true
    @entry_station = nil
  end

end