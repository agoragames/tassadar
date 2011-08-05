require 'spec_helper'

describe Tassadar::MPQ::ArchiveHeader do
  before(:each) do
    @mpq = Tassadar::MPQ::MPQ.read(File.read("spec/replays/Delta\ Quadrant.SC2Replay"))
  end

  it "should have some blocks" do
    @mpq.block_table.blocks.size.should == 10
  end

  it "should have a valid block table entry" do
    block = @mpq.block_table.blocks.first
    block.block_offset.should == 0x0000002C
    block.block_size.should == 448
    block.file_size.should == 448
    block.flags.should == 0x81000200
  end
  
  it "should have another valid block table entry" do
    block = @mpq.block_table.blocks[1]
    block.block_offset.should == 0x000001EC
    block.block_size.should == 652
    block.file_size.should == 1216
    block.flags.should == 0x81000200
  end
end

#  MPQ archive block table
#  -----------------------------------
#  Offset  ArchSize RealSize  Flags
#  0000002C      448      448 81000200
#  000001EC      652     1216 81000200
#  00000478     9984    19453 81000200
#  00002B78      113      149 81000200
#  00002BE9       96       96 81000200
#  00002C49      578      760 81000200
#  00002E8B      682     1112 81000200
#  00003135      254      581 81000200
#  00003233      120      164 81000200
#  000032AB      261      288 81000200
