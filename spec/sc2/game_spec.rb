require 'spec_helper'

describe Tassadar::SC2::Game do
  before(:each) do
    @replay = Tassadar::SC2::Replay.new("spec/replays/Delta\ Quadrant.SC2Replay")
  end

  it "should set the winner" do
    @replay.game.winner.name.should == "redgar"
  end

  it "should set the map" do
    @replay.game.map.should == "Delta Quadrant"
  end

  it "should set the time" do
    @replay.game.time.should == Time.new(2011, 07, 05, 17, 01, 8, "-05:00")
  end
end
