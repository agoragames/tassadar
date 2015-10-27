require 'spec_helper'

describe Tassadar::MPQ::ArchiveHeader do
  let(:archive_header) do
    Tassadar::MPQ::ArchiveHeader.read("MPQ\x1A,\x00\x00\x00P5\x00\x00\x01\x00\x03\x00\xB03\x00\x00\xB04\x00\x00\x10\x00\x00\x00\n\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00")
  end

  describe "require a valid magic string" do
    it "accepts a valid magic string" do
      expect { Tassadar::MPQ::ArchiveHeader.read("MPQ\x1A,\x00\x00\x00P5\x00\x00\x01\x00\x03\x00\xB03\x00\x00\xB04\x00\x00\x10\x00\x00\x00\n\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00") }.to_not raise_error
    end

    it "does not accept an invalid magic string" do
      expect { Tassadar::MPQ.ArchiveHeader.read("MPQ\x1A,\x00\x00\x00P5\x00\x00\x01\x00\x03\x00\xB03\x00\x00\xB04\x00\x00\x10\x00\x00\x00\n\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00") }.to raise_error(/undefined method/)
    end
  end

  it "reads the header size" do
    expect(archive_header.header_size).to eq(44)
  end

  it "reads the archive size" do
    expect(archive_header.archive_size).to eq(13648)
  end

  it "reads the format version" do
    expect(archive_header.format_version).to eq(1)
  end

  it "reads the sector size shift" do
    expect(archive_header.sector_size_shift).to eq(3)
  end

  it "reads the hash table offset" do
    expect(archive_header.hash_table_offset).to eq(13232)
  end

  it "reads the block table offset" do
    expect(archive_header.block_table_offset).to eq(13488)
  end

  it "reads the hash table entries" do
    expect(archive_header.hash_table_entries.value).to be > 0
    expect(archive_header.hash_table_entries.value).to be < 2 ** 20
    expect(Math.log2(archive_header.hash_table_entries.to_i).floor).to eq(Math.log2(archive_header.hash_table_entries.to_i).ceil)
    expect(archive_header.hash_table_entries).to eq(16)
  end

  it "reads the block table entries" do
    expect(archive_header.block_table_entries).to eq(10)
  end

  it "reads the extended_block_table_offset" do
    expect(archive_header.extended_block_table_offset).to eq(0)
  end

  it "reads the hash table offset high" do
    expect(archive_header.hash_table_offset_high).to eq(0)
  end

  it "reads the block table offset high" do
    expect(archive_header.block_table_offset_high).to eq(0)
  end
end
