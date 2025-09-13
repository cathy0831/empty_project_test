module Importable
  extend ActiveSupport::Concern

  # 找出指定文字所在的欄位索引位置
  # list: 欄位名稱陣列 (如 Excel 第一列)
  # text: 要查找的文字
  # 回傳: 該文字所在的 index (整數)，找不到則為 nil
  def find_column_index(list, text)
    list.index(list.detect { |t| t.tr("\n", "").include? text })
  end

  # 從資料列中，依據欄位對應表抓取值
  # col: 欄位名稱 (Symbol 或 String)
  # data: 資料列陣列 (如 CSV row)
  # col_map: 欄位名稱與 index 的對照表 (Hash，例如 { name: 0, age: 1 })
  # 回傳: 指定欄位的值
  def grep_value(col, data, col_map)
    data[col_map[col.to_sym]]
  end

  # 根據欄位映射表，抽取資料列並整理成 Hash
  # row: 一筆資料 (Array)
  # column_map: 欄位對應表 (Hash，例如 { name: 0, age: 1 })
  # 回傳: 整理後的 Hash (例如 { name: "Tom", age: "20" })
  def extract_data(row, column_map)
    column_map.each_with_object({}) do |(field, index), hash|
      hash[field] = row[index]&.to_s&.strip if index
    end
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
