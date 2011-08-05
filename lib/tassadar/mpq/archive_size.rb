module Tassadar
  module MPQ
    class ArchiveSize < BinData::Primitive
      endian :little

      def get
        [eval_parameter(:hash_table_offset) + (eval_parameter(:hash_table_entries) * 16),
         eval_parameter(:block_table_offset) + (eval_parameter(:block_table_entries) * 16)].max
      end

      def set(v)
        [eval_parameter(:hash_table_offset) + (eval_parameter(:hash_table_entries) * 16),
         eval_parameter(:block_table_offset) + (eval_parameter(:block_table_entries) * 16)].max
      end
    end
  end
end
