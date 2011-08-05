module Tassadar
  module SC2
    class ReverseString < BinData::String
      mandatory_parameters :read_length

      def read_and_return_value(io)
        super.reverse
      end

      def value_to_binary_string(value)
        clamp_to_length(val.reverse)
      end
    end
  end
end
