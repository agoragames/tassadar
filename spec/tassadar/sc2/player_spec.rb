# encoding: UTF-8
require 'spec_helper'

describe Tassadar::SC2::Player do
  subject(:player) { replay.players.last }

  context 'NA SC2 Replay' do
    let(:replay) { Tassadar::SC2::Replay.new(File.join(REPLAY_DIR, "OhanaLE.SC2Replay")) }

    it "sets the name" do
      expect(player.name).to eq("MLGLogan")
    end

    it "sets the id" do
      expect(player.id).to eq(1485031)
    end

    it "tells if the player won" do
      expect(player).to_not be_winner
    end

    it "has a color" do
      expect(player.color).to eq({:alpha => 255, :red => 0, :green => 66, :blue => 255})
    end

    it "has random as the chosen race if random" do
      expect(player.chosen_race).to eq("Random")
    end

    it "has an actual race" do
      expect(player.actual_race).to eq("Protoss")
    end

    it "has a handicap" do
      expect(player.handicap).to eq(100)
    end

    it "sets the team" do
      expect(player.team).to eq(0)
    end
  end

  context 'EU SC2 Replay' do
    let(:replay) { Tassadar::SC2::Replay.new(File.join(REPLAY_DIR, 'eu_replay.SC2Replay')) }

    it 'encodes the name in UTF-8' do
      expect(player.name.encoding.to_s).to eq('UTF-8')
      expect(player.name).to eq('MǂStephano')
    end
  end

  context "replay with a player who has a clan tag" do
    let(:replay) { Tassadar::SC2::Replay.new(File.join(REPLAY_DIR, 'game_with_clan_tag.SC2Replay')) }

    subject(:player) { replay.players.first }

    it "returns the name without a <sp/>" do
      expect(player.name).to eq("[JZTD]JZTD")
    end
  end
end
