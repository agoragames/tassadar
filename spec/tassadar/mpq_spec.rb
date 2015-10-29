require 'spec_helper'

describe Tassadar::MPQ::MPQ do
  let(:mpq) { Tassadar::MPQ::MPQ.read(File.read(File.join(REPLAY_DIR, 'patch150.SC2Replay'))) }

  it "reads the user data size" do
    expect(mpq.user_data_length).to eq(60)
  end

  it "has block_table entries" do
    expect(mpq.block_table.blocks.size).to eq(10)
  end

  it "has hash_table entries" do
    expect(mpq.hash_table.hashes.size).to eq(16)
  end

  it "has files" do
    expect(mpq.file_data.size).to be > 1
  end

  it "has a list of files" do
    expect(mpq.files.size).to eq(8)
    expect(mpq.files).to include("replay.attributes.events")
  end
end
