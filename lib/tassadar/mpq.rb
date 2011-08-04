require 'bindata'

require 'tassadar/mpq/archive_header'
require 'tassadar/mpq/file_data'
require 'tassadar/mpq/block_table'
require 'tassadar/mpq/hash_table'
require 'tassadar/mpq/block_encryptor'

module Tassadar
  module MPQ
    class MPQ < BinData::Record
      endian :little

      string :magic, :length => 3, :check_value => "MPQ"
      int8   :magic_4, :check_value => 27
      int32  :user_data_size
      int32  :archive_header_offset
      string :user_data, :read_length => :user_data_size

      archive_header :archive_header, :adjust_offset => lambda { archive_header_offset }
      encrypted_block_table :block_table, :entries => lambda { archive_header.block_table_entries },
                                          :adjust_offset => lambda { archive_header_offset + archive_header.block_table_offset }
      encrypted_hash_table  :hash_table,  :entries => lambda { archive_header.hash_table_entries },
                                          :adjust_offset => lambda { archive_header_offset + archive_header.hash_table_offset },
                                          :compressed => lambda { archive_header.block_table_offset != archive_header.hash_table_offset + archive_header.hash_table_entries * 16 }
      # file_data_array :file_data, :blocks => lambda { block_table.blocks },
      #                             :sector_size_shift => lambda { archive_header.sector_size_shift }
    end

  end
end
