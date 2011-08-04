module Tassadar
  module MPQ
    class ArchiveHeader < BinData::Record
      endian :little

      string :magic, :length => 3, :check_value => "MPQ"
      int8   :magic_4, :check_value => 26

      int32  :header_size, :check_value => 44
      uint32  :archive_size
      int16  :format_version
      int8   :sector_size_shift, :check_value => 3
      skip   :length => 1
      uint32  :hash_table_offset
      int32  :block_table_offset
      int32  :hash_table_entries
      int32  :block_table_entries
      int64  :extended_block_table_offset
      int16  :hash_table_offset_high
      int16  :block_table_offset_high
    end
  end
end
