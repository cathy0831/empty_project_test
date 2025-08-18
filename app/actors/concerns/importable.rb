module Importable
  extend ActiveSupport::Concern

  def find_column_index(list, text)
    list.index(list.detect { |t| t.tr("\n", "").include? text })
  end

  def grep_value(col, data, col_map)
    data[col_map[col.to_sym]]
  end

  def fnv32a_hash(str, as_string: true, seed: 0x811c9dc5)
    hval = seed

    str.each_byte do |char|
      hval ^= char
      hval += (hval << 1) + (hval << 4) + (hval << 7) + (hval << 8) + (hval << 24)
      hval &= 0xffffffff # 保持在 32-bit 範圍
    end

    as_string ? format("%08x", hval) : hval
  end
end
