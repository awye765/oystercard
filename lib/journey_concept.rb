require 'oystercard'

class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :journeys

  def initialize(entry_station=nil)
    @entry_station = entry_station
    @journeys = Hash.new
    @complete = false
  end

  def start(station)
    @entry_station = station
    @journeys[:entry_station] = station
  end

  def finish(station)
    @exit_station = station
    @journeys[:exit_station] = station
  end

  def fare
    return PENALTY_FARE if penalty?
  end

  def complete?
    @complete
  end

  def penalty?
    ( !entry_station || !exit_station )
  end

end
