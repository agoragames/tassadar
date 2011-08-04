module Tassadar
  module MPQ
    class BlockTable < BinData::Record
      endian :little

      array :blocks, :read_until => :eof do
        uint32 :block_offset
        uint32 :block_size
        uint32 :file_size
        uint32 :flags
      end
    end

    class EncryptedBlockTable < BinData::BasePrimitive
      mandatory_parameters :entries

      def read_and_return_value(io)
        value = BlockEncryptor.new("(block table)", 0x300, io, eval_parameter(:entries) * 16).decrypt
        BlockTable.read(value)
      end

      def value_to_binary_string(value)
        BlockEncryptor.new("(block table)", 0x300, value, eval_parameter(:entries) * 16).encrypt
      end

      def sensible_default
        [0,0,0,0].pack("VVVV")
      end
    end
  end
end
