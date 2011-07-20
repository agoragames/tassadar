module Tassadar
  module MPQ
    module CryptBuf
      def self.[](index)
        crypt_buf[index]
      end

      def self.crypt_buf
        @@crypt_buff ||= crypt_buf!
      end

      def self.crypt_buf!
        crypt_buf = []
        seed = 0x00100001

        0.upto(0x100 - 1) do |index1|
          index2 = index1

          0.upto(4) do |i|
            seed = (Tassadar::MPQ.add_big(seed * 125, 3)) % 0x2AAAAB
            temp1 = (seed & 0xFFFF) << 0x10

            seed = (Tassadar::MPQ.add_big(seed * 125, 3)) % 0x2AAAAB
            temp2 = (seed & 0xFFFF)
            crypt_buf[index2] = (temp1 | temp2)

            index2 = index2 + 0x100
          end
        end

        crypt_buf
      end
    end
  end
end
