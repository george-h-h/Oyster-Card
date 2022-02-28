class Oystercard

  attr_reader :balance
  TOP_UP_LIMIT = 90

  def initialize(max_limit = TOP_UP_LIMIT)
    @max_limit = max_limit
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    if @balance + money > @max_limit
      raise Exception.new "Max balance of £#{TOP_UP_LIMIT} reached"
    else 
      return @balance += money
    end
  end

  def deduct(money)
    return @balance -= money
  end

  def touch_in
    if @balance < 1
      raise Exception.new "Must have at least minimum balance to touch in"
    else
      @in_journey = true
    end
  end

  def in_journey?
    return @in_journey
  end


  def touch_out
    @in_journey = false
  end
end