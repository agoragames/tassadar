module Tassadar
  module MPQ
    class FileData < BinData::Record
      endian :little

      array :sector_offset_table, :type => :int32
    end
  end
end
