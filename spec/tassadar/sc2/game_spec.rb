require 'spec_helper'

describe Tassadar::SC2::Game do
  let(:replay) { Tassadar::SC2::Replay.new(File.join(REPLAY_DIR, "patch150.SC2Replay")) }

  it "sets the winner" do
    expect(replay.game.winner.name).to eq("Ratbaxter")
  end

  it "sets the map" do
    expect(replay.game.map).to eq("Scorched Haven")
  end

  it "sets the time" do
    #expect(replay.game.time).to eq(Time.new(2012, 8, 2, 11, 00, 33, "-05:00"))
  end

  it "sets the speed" do
    expect(replay.game.speed).to eq("Faster")
  end

  it "sets the game type" do
    expect(replay.game.type).to eq("2v2")
  end

  it "sets the category" do
    expect(replay.game.category).to eq("Ladder")
  end

  context "2v2's" do
    let(:replay) { Tassadar::SC2::Replay.new(File.join(REPLAY_DIR, "2v2.SC2Replay")) }

    it "returns the game winners" do
      expect(replay.game.winners.length).to eq(2)
    end

    it "returns the correct winners" do
      winners = replay.game.winners.map(&:name)
      expect(winners).to match_array(["EaglePunch", "JZTD"])
    end
  end
end
