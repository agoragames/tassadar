require 'spec_helper'

describe Tassadar::SC2::Game do
  let(:replay) { Tassadar::SC2::Replay.new(File.join(REPLAY_DIR, "patch150.SC2Replay")) }
  let(:replay_from_data) { Tassadar::SC2::Replay.new(nil, File.read(File.join(REPLAY_DIR, "patch150.SC2Replay"))) }

  it "has the same result" do
    expect(replay.game.winner.name).to eq(replay_from_data.game.winner.name)
  end

  it "has players" do
    expect(replay.players).to_not be_nil
    expect(replay_from_data.players).to_not be_nil
  end

  it "has game" do
    expect(replay.game).to_not be_nil
    expect(replay_from_data.game).to_not be_nil
  end

  it "has details" do
    expect(replay.details).to_not be_nil
    expect(replay_from_data.details).to_not be_nil
  end
end
