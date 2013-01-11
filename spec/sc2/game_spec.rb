require 'spec_helper'

describe Tassadar::SC2::Game do
  before(:each) do
    @replay = Tassadar::SC2::Replay.new("spec/replays/patch150.SC2Replay")
  end

  it "should set the winner" do
    @replay.game.winner.name.should == "Ratbaxter"
  end

  it "should set the map" do
    @replay.game.map.should == "Scorched Haven"
  end

  it "should set the time" do
    #@replay.game.time.should == Time.new(2012, 8, 2, 11, 00, 33, "-05:00")
  end

  it "should set the speed" do
    @replay.game.speed.should == "Faster"
  end

  it "should set the game type" do
    @replay.game.type.should == "2v2"
  end

  it "should set the category" do
    @replay.game.category.should == "Ladder"
  end
end
