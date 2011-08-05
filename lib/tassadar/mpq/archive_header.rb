module Tassadar
  module MPQ
    class ArchiveHeader < BinData::Record
      endian :little

      string :magic, :length => 3, :check_value => "MPQ"
      uint8   :magic_4, :check_value => 26

      uint32  :header_size, :check_value => 44

      # archive_size actually here, but not used and is computed from later data
      skip    :length => 4

      uint16  :format_version
      uint8   :sector_size_shift, :check_value => 3
      skip    :length => 1
      uint32  :hash_table_offset
      uint32  :block_table_offset
      uint32  :hash_table_entries
      uint32  :block_table_entries
      uint64  :extended_block_table_offset
      uint16  :hash_table_offset_high
      uint16  :block_table_offset_high

      archive_size :archive_size, :hash_table_offset => :hash_table_offset,
                                  :hash_table_entries => :hash_table_entries,
                                  :block_table_offset => :block_table_offset,
                                  :block_table_entries => :block_table_entries
    end
  end
end
