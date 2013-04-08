# encoding: UTF-8
require 'spec_helper'

describe Tassadar::SC2::Player do
  subject(:player) { replay.players.last }

  context 'NA SC2 Replay' do
    let(:replay) { Tassadar::SC2::Replay.new(File.join(REPLAY_DIR, "OhanaLE.SC2Replay")) }

    it "should set the name" do
      player.name.should == "MLGLogan"
    end

    it "should set the id" do
      player.id.should == 1485031
    end

    it "should tell if the player won" do
      player.should_not be_winner
    end

    it "should have a color" do
      player.color.should == {:alpha => 255, :red => 0, :green => 66, :blue => 255}
    end

    it "should have random as the chosen race if random" do
      player.chosen_race.should == "Random"
    end

    it "should have an actual race" do
      player.actual_race.should == "Protoss"
    end

    it "should have a handicap" do
      player.handicap.should == 100
    end

    it "should set the team" do
      player.team.should == 0
    end
  end

  context 'EU SC2 Replay' do
    let(:replay) { Tassadar::SC2::Replay.new(File.join(REPLAY_DIR, 'eu_replay.SC2Replay')) }

    it 'encodes the name in UTF-8' do
      player.name.encoding.to_s.should == 'UTF-8'
      player.name.should == 'MǂStephano'
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
