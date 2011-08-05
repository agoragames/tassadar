# https://github.com/GraylinKim/sc2reader/wiki/replay.attributes.events

module Tassadar
  module SC2
    class Attribute < BinData::Record
      endian :little

      string :header, :read_length => 4, :check_value => "\xE7\x03\x00\x00"
      uint32 :id
      uint8 :player_number
      reverse_string :attribute_value, :read_length => 4
    end

    class Attributes < BinData::Record
      endian :little

      skip :length => 5
      uint32 :num_attributes

      array :attributes, :type => :attribute, :initial_length => :num_attributes
    end
  end
end
