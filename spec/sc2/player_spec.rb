# encoding: UTF-8
require 'spec_helper'

describe Tassadar::SC2::Player do
  context 'NA Sc2 Replay' do
    before(:each) do
      @replay = Tassadar::SC2::Replay.new("spec/replays/Delta\ Quadrant.SC2Replay")
      @player = @replay.players.first
    end

    it "should set the name" do
      @player.name.should == "guitsaru"
    end

    it "should set the id" do
      @player.id.should == 1918894
    end

    it "should tell if the player won" do
      @player.should_not be_winner
    end

    it "should have a color" do
      @player.color.should == {:alpha => 255, :red => 180, :green => 20, :blue => 30}
    end

    it "should have a chosen race" do
      @player.chosen_race.should == "Terran"
    end

    it "should have random as the chosen race if random" do
      replay = Tassadar::SC2::Replay.new("spec/replays/random.sc2replay")
      replay.players.last.chosen_race.should == "Random"
    end

    it "should have an actual race" do
      @player.actual_race.should == "Terran"
    end

    it "should have a handicap" do
      @player.handicap.should == 100
    end
  end

  context 'EU SC2 Replay' do
    let(:replay) { Tassadar::SC2::Replay.new('spec/replays/eu_replay.SC2Replay') }
    subject  { replay.players.last }

    it 'encodes the name in UTF-8' do
      subject.name.encoding.to_s.should == 'UTF-8'
      subject.name.should == 'MǂStephano'
    end
  end
end
