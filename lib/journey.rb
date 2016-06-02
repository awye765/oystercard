require_relative 'oystercard'

class Journey

  PENALTY_FARE = 6
  MIN_FARE = 1


  attr_reader :current_journey, :complete, :journey_log, :entry_station, :exit_station

  def initialize(entry_station=nil)
    @current_journey = {}
    @journey_log = []
    current_journey_start(entry_station)
    @complete = false
  end

  def finish(exit_station=nil)
    current_journey_end(exit_station)
    journey_log_update
    # current_journey_reset
    @complete = true
  end

  def current_journey_start(entry_station)
    @entry_station = entry_station
    @current_journey[:entry_station] = entry_station
  end

  def current_journey_end(exit_station)
    @exit_station = exit_station
    @current_journey[:exit_station] = exit_station
  end

  def journey_log_update
    @journey_log << current_journey
  end

  def current_journey_reset
    @current_journey = {}
  end

  def fare
    return PENALTY_FARE if penalty?
    MIN_FARE
  end

  def penalty?
    (!entry_station || !exit_station)
  end

end
