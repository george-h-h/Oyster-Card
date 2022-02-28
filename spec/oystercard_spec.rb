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

    it "deducts money" do
      subject.top_up(50)
      expect(subject.deduct(10)).to eq(40)
    end
  end

  it "supports touch in" do
    subject.top_up(25)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it "is initially not in a journey" do
    expect(subject).not_to be_in_journey
  end

  it "supports touch out" do
    subject.top_up(25)
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it "touch in raises exception if balance is less than £1" do
    expect {subject.touch_in}.to raise_error("Must have at least minimum balance to touch in")
  end
end