require 'zlib'
require 'rbzip2'
require 'stringio'

module Tassadar
  module MPQ
    class FileData < BinData::Record
      MPQ_FILE_ENCRYPTED = 0x00010000
      MPQ_FILE_EXISTS = 0x80000000
      MPQ_SINGLE_UNIT = 0x01000000
      MPQ_COMPRESSED = 0x00000200

      attr_accessor :block_offset

      endian :little

      string :data, :read_length => lambda { block.block_size }

      def decompressed_data
        result = nil
        block = eval_parameter(:block)

        if (block.flags & MPQ_FILE_EXISTS) > 0
          result = self.data
        end

        if (block.flags & MPQ_FILE_ENCRYPTED) > 0
          raise NotImplementedError
        end

        if (block.flags & MPQ_SINGLE_UNIT) > 0
          if block.flags & MPQ_COMPRESSED && block.file_size > block.block_size
            result = decompress(self.data)
          end
        else
        end

        result
      end

      private
      def decompress(data)
        compression_type = data.bytes.first
        case compression_type
        when 0
          data
        when 2
          Zlib::Deflate.deflate(data[1,data.size - 1])
        when 16
          RBzip2::Decompressor.new(StringIO.new(data[1,data.size - 1])).read
        else
          raise NotImplementedError
        end
      end
    end

    class FileDataArray < BinData::BasePrimitive
      mandatory_parameters :blocks, :sector_size_shift

      def read_and_return_value(io)
        result = []
        sector_size = 512 * (2 ** eval_parameter(:sector_size_shift))

        eval_parameter(:blocks).each do |block|
          num_sectors = block.flags & 0x01000000 ? 1 : (block["block_size"] / sector_size)
          file = FileData.new(:adjust_offset => block.block_offset + eval_parameter(:archive_header_offset),
                              :block => block).read(io)
          file.block_offset = block.block_offset

          result << file
        end

        result
      end

      def value_to_binary_string(value)
        value.pack("V*")
      end

      def sensible_default
        ''
      end
    end
  end
end
