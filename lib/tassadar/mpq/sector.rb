module Tassadar
  module MPQ
    class Sector < BinData::Record
      endian :little

      uint8 :compression_mask
    end

    class SectorArray < BinData::BasePrimitive
      mandatory_parameters :sector_offsets, :sector_size

      def read_and_return_value(io)
        result = []
        file_data_offset = parent.offset

        eval_parameter(:sector_offsets).each do |offset|
          raise offset.inspect
          result << Sector.new(:adjust_offset => offset + file_data_offset).read(io)
        end

        result
      end
    end
  end
end
