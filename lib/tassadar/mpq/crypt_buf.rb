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
              end
    end
  end
end
