require './lib/station'

class Oystercard

  attr_reader :balance, :entry_station
  TOP_UP_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(max_limit = TOP_UP_LIMIT)
    @max_limit = max_limit
    @balance = 0
    @minimum_fare = MINIMUM_FARE
    @entry_station
    @exit_station
    @journey = []
  end

  def top_up(money)
    if @balance + money > @max_limit
      raise Exception.new "Max balance of £#{TOP_UP_LIMIT} reached"
    else 
      return @balance += money
    end
  end

  def touch_in(entry_station)
    if @balance < MINIMUM_FARE
      raise Exception.new "Must have at least minimum fare in balance to touch in"
    else
      @entry_station = entry_station
    end
  end

  def in_journey?
    !!@entry_station
  end


  def touch_out(exit_station)
    @balance -= MINIMUM_FARE
    @exit_station = exit_station
    record_journey
    @entry_station = nil
  end

  def record_journey
    @journey << {@entry_station => @exit_station}
  end

  def print_journeys
    return @journey
  end

  private

  def deduct(money)
    return @balance -= money
  end
end