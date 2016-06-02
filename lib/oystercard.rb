class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 1

  attr_reader :balance, :journeys

  def initialize
    @balance = 0
    @journeys = Hash.new
  end

  def in_journey?
    !!journeys
  end

  def top_up(amount)
    max_balance_error(amount)
    @balance += amount
  end

  def touch_in(station)
    min_balance_error
    login(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    log_out(station)
  end

  def log_in(station)
    @journeys[:entry_station] = station
  end

  def log_out(station)
    @journeys[:exit_station] = station
  end

  def max_balance_error(amount)
    fail "Maximum balance of #{MAX_BALANCE} reached!" if over_limit?(amount)
  end

  def min_balance_error
    fail "Error: minimum balance less than minimum fare. Top-up!" if balance < MIN_FARE
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def over_limit?(amount)
    (amount + balance) > MAX_BALANCE
  end

end