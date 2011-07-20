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

      array :hashes do
        int32 :file_path_hash_a
        int32 :file_path_hash_b
        int16 :language
        int8  :platform
        skip  :length => 1
        int32 :file_block_index
      end
    end

    class EncryptedHashTable < BinData::BasePrimitive
      mandatory_parameters :entries

      def read_and_return_value(io)
        HashTable.read(Tassadar::MPQ.decrypt_block(io, eval_parameter(:entries) * 16, Tassadar::MPQ.hash_string("(hash table)", 0x300)))
      end

      def value_to_binary_string(value)
        MPQ.encrypt_block(value.to_binary_string, eval_parameter(:entries) * 16, Tassadar::MPQ.hash_string("(hash table)", 0x300))
      end

      def sensible_default
        [0,0,0,0,0,0,0,0,0].pack("VVvCVVVVVV")
      end
    end

  end
end
