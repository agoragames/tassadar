require 'spec_helper'

describe Tassadar::MPQ::MPQ do
  before(:each) do
    @mpq = Tassadar::MPQ::MPQ.read(File.read("spec/replays/patch150.SC2Replay"))
  end

  it "should read the user data size" do
    @mpq.user_data_length.should == 60
  end

  it "should have block_table entries" do
    @mpq.block_table.blocks.size.should == 10
  end

  it "should have hash_table entries" do
    @mpq.hash_table.hashes.size.should == 16
  end

  it "should have files" do
    @mpq.file_data.size.should > 1
  end

  it "should have a list of files" do
    @mpq.files.size.should == 8
    @mpq.files.should include("replay.attributes.events")
  end
end
