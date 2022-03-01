require 'station'

describe Station do
  
    station = Station.new("Liverpool Street", 1)
  
  it "has a name" do
    expect(station.name).to eq("Liverpool Street")
  end

  it "has a zone" do
    expect(station.zone).to eq(1)
  end
end