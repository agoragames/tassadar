module Tassadar
  module MPQ
    class BlockEncryptor
      attr_accessor :key, :offset, :buffer, :size

      def initialize(key, offset, buffer, size)
        @key = key
        @offset = offset
        @buffer = buffer
        @size = size
      end

      def decrypt
        seed = hash_string(key, offset)
        seed2 = 0xEEEEEEEE
        decrypted_block = []

        while @size >= 4
          seed2 = add_big(seed2, encryption_table[0x400 + (seed & 0xFF)])

          current_data = buffer.readbytes(4).unpack("V").first
          ch = current_data ^ add_big(seed, seed2)

          decrypted_block << ch

          seed = ((~seed << 0x15) + 0x11111111) | (seed >> 0x0B)
          seed2 = add_big(add_big(ch, add_big(seed2, (seed2 << 5))), 3)
          @size = @size - 4
        end

        decrypted_block.pack("V*")
      end

      def encrypt
        seed = hash_string(key, offset)
        seed2 = 0xEEEEEEEE
        encrypted_block = []

        while size >= 4
          seed2 += encryption_table[0x400 + (seed & 0xFF)]
          current_data = buffer.readbytes(4).unpack("V").first

          ch = current_data ^ add_big(seed, seed2)
          encrypted_block << ch

          seed = ((~seed << 0x15) + 0x11111111) | (seed >> 0x0B)
          seed2 = current_data + seed2 + (seed2 << 5) + 3;

          size = size - 4
        end

        encrypted_block.pack("V*")
      end

      private
      def encryption_table
        @encryption_table ||= begin
          crypt_buf = []
          seed = 0x00100001

          0.upto(0x100 - 1) do |index1|
            index2 = index1

            0.upto(4) do |i|
              seed = (add_big(seed * 125, 3)) % 0x2AAAAB
              temp1 = (seed & 0xFFFF) << 0x10

              seed = (add_big(seed * 125, 3)) % 0x2AAAAB
              temp2 = (seed & 0xFFFF)
              crypt_buf[index2] = (temp1 | temp2)

              index2 = index2 + 0x100
            end
          end

          crypt_buf
        end
      end

      def hash_string(key, offset)
        seed1 = 0x7FED7FED
        seed2 = 0xEEEEEEEE

        key.upcase.each_byte do |char|
          seed1 = encryption_table[offset + char] ^ add_big(seed1, seed2)
          seed2 = add_big(add_big(char, add_big(seed1, add_big(seed2, (seed2 << 5)))), 3)
        end

        seed1
      end

      def add_big(a, b)
        ah = (a >> 16) & 0xFFFF
        al = a & 0xFFFF

        bh = (b >> 16) & 0xFFFF
        bl = b & 0xFFFF

        cl = al + bl
        ch = ah + bh
        ch += ((cl >> 16) & 0xFFFF) if (cl > 0xFFFF)

        return (((ch << 16) & (0xFFFF << 16)) | (cl & 0xFFFF))
      end

    end
  end
end
