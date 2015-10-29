require 'spec_helper'

describe Tassadar::MPQ::ArchiveHeader do
  let(:mpq) { Tassadar::MPQ::MPQ.read(File.read(File.join(REPLAY_DIR, "Delta\ Quadrant.SC2Replay"))) }

  it "has 10 blocks" do
    expect(mpq.block_table.blocks.size).to eq(10)
  end

  it "has a valid block table entry" do
    block = mpq.block_table.blocks.first
    expect(block.block_offset).to eq(0x0000002C)
    expect(block.block_size).to eq(448)
    expect(block.file_size).to eq(448)
    expect(block.flags).to eq(0x81000200)
  end

  it "has another valid block table entry" do
    block = mpq.block_table.blocks[1]
    expect(block.block_offset).to eq(0x000001EC)
    expect(block.block_size).to eq(652)
    expect(block.file_size).to eq(1216)
    expect(block.flags).to eq(0x81000200)
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
