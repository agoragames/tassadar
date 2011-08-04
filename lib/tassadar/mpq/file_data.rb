module Tassadar
  module MPQ
    class FileData < BinData::Record
      endian :little

      array :sector_offset_table, :type => :int32,
                                  :initial_length => lambda { eval_parameter(:sectors) }
    end

    class FileDataArray < BinData::BasePrimitive
      mandatory_parameters :blocks, :sector_size_shift

      def read_and_return_value(io)
        result = []
        sector_size = 512 * (2 ** eval_parameter(:sector_size_shift))

        eval_parameter(:blocks).each do |block|
          result << FileData.new(:adjust_offset => block["block_offset"],
                                 :sectors => (block["block_size"] / sector_size))
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
