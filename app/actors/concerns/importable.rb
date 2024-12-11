module Importable
  extend ActiveSupport::Concern

  def find_column_index(list, text)
    list.index(list.detect { |t| t.tr("\n", "").include? text })
  end

  def grep_value(col, data, col_map)
    data[col_map[col.to_sym]]
  end
end
