module Tassadar
  module MPQ
    class BlockTable < BinData::Record
      endian :little

      array :blocks do
        int32 :block_offset
        int32 :block_size
        int32 :file_size
        int32 :flags
      end
    end

    class EncryptedBlockTable < BinData::BasePrimitive
      mandatory_parameters :entries

      def read_and_return_value(io)
        BlockTable.read(Tassadar::MPQ.decrypt_block(io, eval_parameter(:entries) * 16, Tassadar::MPQ.hash_string("(block table)", 0x300)))
      end

      def value_to_binary_string(value)
        MPQ.encrypt_block(value.to_binary_string, eval_parameter(:entries) * 16, Tassadar::MPQ.hash_string("(block table)", 0x300))
      end

      def sensible_default
        [0,0,0,0].pack("VVVV")
      end
    end
  end
end
