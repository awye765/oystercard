require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 1

  attr_reader :balance, :journey_log, :current_journey

  def initialize
    @balance = 0
    @journey_log = []
  end


  def top_up(amount)
    max_balance_error(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    @current_journey = Journey.new(entry_station)
    min_balance_error
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
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
