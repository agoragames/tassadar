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
end
