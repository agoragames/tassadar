module Tassadar
  module MPQ
    class FileTime < BinData::Record
      endian :little

      uint32 :low_date_time
      uint32 :high_date_time
    end

    class Md5 < BinData::Record
      endian :little

      string :md5_hash, :length => 16
    end

    class HashTable < BinData::Record
      endian :little

      array :hashes, :read_until => :eof do
        uint32 :file_path_hash_a
        uint32 :file_path_hash_b
        uint16 :language
        uint8  :platform
        skip  :length => 1
        uint32 :file_block_index
      end
    end

    class EncryptedHashTable < BinData::BasePrimitive
      mandatory_parameters :entries

      def read_and_return_value(io)
        value = BlockEncryptor.new("(hash table)", 0x300, io, eval_parameter(:entries) * 16).decrypt
        HashTable.read(value)
      end

      def value_to_binary_string(value)
        BlockEncryptor.new("(hash table)", 0x300, value, eval_parameter(:entries) * 16).encrypt
      end

      def sensible_default
        [0,0,0,0,0,0,0,0,0].pack("VVvCVVVVVV")
      end
    end

  end
end
