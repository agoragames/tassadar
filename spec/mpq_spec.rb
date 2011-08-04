require 'spec_helper'

describe Tassadar::MPQ::MPQ do
  before(:each) do
    @mpq = Tassadar::MPQ::MPQ.read(File.read("spec/replays/Delta\ Quadrant.SC2Replay"))
  end

  it "should have a valid magic string" do
    @mpq.magic.should == "MPQ"
  end

  it "should read the user data size" do
    @mpq.user_data_size.should == 512
  end

  it "should have block_table entries" do
    @mpq.block_table.blocks.size.should == 10
  end

  it "should have hash_table entries" do
    @mpq.hash_table.hashes.size.should == 16
  end

  pending "should have files" do
    @mpq.file_data.first.sector_offset_table.size.should > 0
  end
end
