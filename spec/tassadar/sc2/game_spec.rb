require 'spec_helper'

describe Tassadar::SC2::Game do
  before(:each) do
    @replay = Tassadar::SC2::Replay.new(File.join(REPLAY_DIR, "patch150.SC2Replay"))
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

  context "2v2's" do
    let(:replay) { Tassadar::SC2::Replay.new(File.join(REPLAY_DIR, "2v2.SC2Replay")) }

    it "returns the game winners" do
      expect(replay.game).to have(2).winners
    end

    it "returns the correct winners" do
      winners = replay.game.winners.map(&:name)
      expect(winners).to eq ["EaglePunch", "JZTD"]
    end
  end
end
