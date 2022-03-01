require 'oystercard'

describe Oystercard do

  context "deals with balance, topping up and max limit" do
    it "starts with a balance of 0" do
      expect(subject.balance).to eq(0)
    end

    it "can be topped up" do
      expect(subject.top_up(3)).to eq(3)
    end

    it "top up raises exception if new balance would exceed limit" do
      expect {subject.top_up(91)}.to raise_error("Max balance of £90 reached")
    end
  end

  it "supports touch in" do
    subject.top_up(25)
    subject.touch_in("origin")
    expect(subject).to be_in_journey
  end

  it "is initially not in a journey" do
    expect(subject).not_to be_in_journey
  end

  it "supports touch out" do
    subject.top_up(25)
    subject.touch_in("origin")
    subject.touch_out("destination")
    expect(subject).not_to be_in_journey
  end

  it "touch in raises exception if balance is less than minimum fare" do
    expect {subject.touch_in("origin")}.to raise_error("Must have at least minimum fare in balance to touch in")
  end

  it "expects fare to be taken out of balance after touching out" do
    expect {subject.touch_out("destination")}.to change{subject.balance}.by (-Oystercard::MINIMUM_FARE)
  end

  let(:station){ double :station }

  it "records entry station" do    
    subject.top_up(20)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  it "checks that journey list is empty by default" do
    expect(subject.print_journeys).to be_empty
  end

  it "records journey history" do
    subject.top_up(10)
    subject.touch_in("origin")
    subject.touch_out("destination")
    expect(subject.print_journeys).to match_array(["origin"=>"destination"])
    # expect(subject.print_journeys).to eq([{"origin"=>"destination"}])
  end
end
