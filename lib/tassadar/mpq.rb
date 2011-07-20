require 'bindata'

require 'tassadar/mpq/archive_header'
require 'tassadar/mpq/file_data'
require 'tassadar/mpq/block_table'
require 'tassadar/mpq/hash_table'
require 'tassadar/mpq/crypt_buf'

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
    end

    def self.hash_string(key, offset)
      seed1 = 0x7FED7FED
      seed2 = 0xEEEEEEEE

      key.upcase.each_byte do |char|
        seed1 = Tassadar::MPQ::CryptBuf[offset + char] ^ add_big(seed1, seed2)
        seed2 = add_big(add_big(char, add_big(seed1, add_big(seed2, (seed2 << 5)))), 3)
      end

      seed1
    end

    def self.decrypt_block(buffer, size, seed)
      seed2 = 0xEEEEEEEE
      decrypted_block = []

      while size >= 4
        seed2 = add_big(seed2, Tassadar::MPQ::CryptBuf[0x400 + (seed & 0xFF)])

        current_data = buffer.readbytes(4).unpack("V").first
        ch = current_data ^ add_big(seed, seed2)

        decrypted_block << ch

        seed = ((~seed << 0x15) + 0x11111111) | (seed >> 0x0B)
        seed2 = add_big(add_big(ch, add_big(seed2, (seed2 << 5))), 3)
        size = size - 4
      end

      decrypted_block.pack("V*")
    end

    def self.encrypt_block(buffer, size, seed)
      seed2 = 0xEEEEEEEE
      encrypted_block = []

      while size >= 4
        seed2 += Tassadar::MPQ::CryptBuf[0x400 + (seed & 0xFF)]
        current_data = buffer.readbytes(4).unpack("V").first

        ch = current_data ^ add_big(seed, seed2)
        encrypted_block << ch

        seed = ((~seed << 0x15) + 0x11111111) | (seed >> 0x0B)
        seed2 = current_data + seed2 + (seed2 << 5) + 3;

        size = size - 4
      end

      encrypted_block.pack("V*")
    end

    def self.add_big(a, b)
      ah = (a >> 16) & 0xFFFF
      al = a & 0xFFFF

      bh = (b >> 16) & 0xFFFF
      bl = b & 0xFFFF

      cl = al + bl
      ch = ah + bh
      ch += ((cl >> 16) & 0xFFFF) if (cl > 0xFFFF)

      return (((ch << 16) & (0xFFFF << 16)) | (cl & 0xFFFF))
    end
  end
end
