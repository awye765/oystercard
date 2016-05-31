class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 1

  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @journeys = Hash.new
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} reached!" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Error: minimum balance less than minimum fare. Top-up!" if @balance < MIN_FARE
    # @entry_station = station
    @journeys[:entry_station] = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @exit_station = station
    @journeys[:exit_station] = station
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def over_limit?(amount)
    (amount + balance) > MAX_BALANCE
  end

end