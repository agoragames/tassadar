module Tassadar
  module MPQ
    class ArchiveHeader < BinData::Record
      endian :little

      string :magic, :length => 4
      uint32  :header_size
      uint32 :archive_size

      uint16  :format_version
      uint8   :sector_size_shift
      skip    :length => 1
      uint32  :hash_table_offset
      uint32  :block_table_offset
      uint32  :hash_table_entries
      uint32  :block_table_entries
      uint64  :extended_block_table_offset
      uint16  :hash_table_offset_high
      uint16  :block_table_offset_high

    end
  end
end
