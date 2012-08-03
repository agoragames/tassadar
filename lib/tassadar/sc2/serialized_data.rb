module Tassadar
  module SC2
    class SerializedData < BinData::BasePrimitive
      def read_and_return_value(io)
        key = io.readbytes(1).unpack("C").first

        case key
        when 0
          read_array(io)
        when 2
          read_byte_string(io)
        when 3
          flag = io.readbytes(1)
          read_and_return_value(io)
        when 4
          read_flag(io)
        when 5
          read_kvo(io)
        when 6
          read_small_int(io)
        when 7
          io.readbytes(4)
        when 9
          read_vlf_int(io)
        else
          puts "No parser for key: #{key}"
        end
      end

      def value_to_binary_string(value)
        value.pack("V")
      end

      private
      def read_byte_string(io)
        num_bytes = io.readbytes(1).unpack("C").first >> 1

        io.readbytes(num_bytes).unpack("A#{num_bytes}").first.force_encoding('UTF-8')
      end

      def read_small_int(io)
        io.readbytes(1).unpack("C").first
      end

      def read_big_int(io)
        io.readbytes(4).unpack("v").first
      end

      def read_vlf_int(io)
        byte = io.readbytes(1).unpack("C").first
        value = (byte & 0x7F)
        shift = 1

        while byte & 0x80 > 0
          byte = io.readbytes(1).unpack("C").first
          value += (byte & 0x7F) << (7 * shift)
          shift += 1
        end

        (value & 1) == 1 ? -(value >> 1) : (value >> 1)
      end

      def read_flag(io)
        switch = io.readbytes(1).unpack("C").first

        if switch == 1
          read_and_return_value(io)
        else
          return 0
        end
      end

      def read_array(io)
        entries = read_vlf_int(io)
        results = []
        
        entries.times do
          results << read_and_return_value(io)
        end

        results
      end

      def read_kvo(io)
        result = {}
        num_pairs = io.readbytes(1).unpack("C").first >> 1

        num_pairs.times do
          key = io.readbytes(1).unpack("C").first >> 1
          value = read_and_return_value(io)

          result[key] = value
        end

        result
      end
    end
  end
end
