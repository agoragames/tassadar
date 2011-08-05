require 'spec_helper'

describe Tassadar::MPQ::ArchiveHeader do
  before(:each) do
    @archive_header = Tassadar::MPQ::ArchiveHeader.read("MPQ\x1A,\x00\x00\x00P5\x00\x00\x01\x00\x03\x00\xB03\x00\x00\xB04\x00\x00\x10\x00\x00\x00\n\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00")
  end

  describe "require a valid magic string" do
    it "should accept a valid magic string" do
      expect { Tassadar::MPQ::ArchiveHeader.read("MPQ\x1A,\x00\x00\x00P5\x00\x00\x01\x00\x03\x00\xB03\x00\x00\xB04\x00\x00\x10\x00\x00\x00\n\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00") }.to_not raise_error
    end

    it "should not accept an invalid magic string" do
      expect { Tassadar::MPQ.ArchiveHeader.read("MPQ\x1A,\x00\x00\x00P5\x00\x00\x01\x00\x03\x00\xB03\x00\x00\xB04\x00\x00\x10\x00\x00\x00\n\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00") }.to raise_error
    end
  end

  it "should read the magic header" do
    @archive_header.magic.should == "MPQ"
  end

  it "should read magic 4" do
    @archive_header.magic_4.should == 26
  end

  it "should read the header size" do
    @archive_header.header_size.should == 44
  end

  it "should read the archive size" do
    @archive_header.archive_size.should == 13648
  end

  it "should read the format version" do
    @archive_header.format_version.should == 1
  end

  it "should read the sector size shift" do
    @archive_header.sector_size_shift.should == 3
  end

  it "should read the hash table offset" do
    @archive_header.hash_table_offset.should == 13232
  end

  it "should read the block table offset" do
    @archive_header.block_table_offset.should == 13488
  end

  it "should read the hash table entries" do
    @archive_header.hash_table_entries.should > 0
    @archive_header.hash_table_entries.should < 2 ** 20
    Math.log2(@archive_header.hash_table_entries.to_i).floor.should == Math.log2(@archive_header.hash_table_entries.to_i).ceil
    @archive_header.hash_table_entries.should == 16
  end

  it "should read the block table entries" do
    @archive_header.block_table_entries.should == 10
  end

  it "should read the extended_block_table_offset" do
    @archive_header.extended_block_table_offset.should == 0
  end

  it "should read the hash table offset high" do
    @archive_header.hash_table_offset_high.should == 0
  end

  it "should read the block table offset high" do
    @archive_header.block_table_offset_high.should == 0
  end
end
