module Searchable
  extend ActiveSupport::Concern

  # 依照指定欄位的精確值過濾
  #
  # @param objects [ActiveRecord::Relation] 查詢物件 (ex: User.all)
  # @param col [String] 欄位名稱
  # @param value [Object] 欲比對的值
  # @return [ActiveRecord::Relation] 過濾後的結果
  def filter_by_column(objects, col, value)
    if value.present? && objects.column_names.include?(col)
      sql_condition = objects.arel_table[col.to_sym].eq(value)
      objects = objects.where(sql_condition)
    end
    objects
  end

  # 依照指定欄位的多個值 (IN 條件) 過濾
  #
  # @param objects [ActiveRecord::Relation]
  # @param col [String] 欄位名稱
  # @param ids [Array] 欲比對的值陣列
  # @return [ActiveRecord::Relation]
  def filter_by_column_in(objects, col, ids)
    if ids.present? && ids.is_a?(Array) && objects.column_names.include?(col)
      sql_condition = objects.arel_table[col.to_sym].in(ids)
      objects = objects.where(sql_condition)
    end
    objects
  end

  # 依照指定欄位的區間值過濾 (>= start_value 且 <= end_value)
  #
  # @param objects [ActiveRecord::Relation]
  # @param col [String] 欄位名稱
  # @param start_value [Object] 區間起始值
  # @param end_value [Object] 區間結束值
  # @return [ActiveRecord::Relation]
  def filter_by_column_period(objects, col, start_value, end_value)
    sym_col = col.to_sym
    conditions = []

    conditions << objects.arel_table[sym_col].gteq(start_value) if start_value.present?
    conditions << objects.arel_table[sym_col].lteq(end_value) if end_value.present?

    if conditions.any?
      combined_condition = conditions.reduce { |a, b| a.and(b) }
      objects = objects.where(combined_condition)
    end

    objects
  end

  # 依照指定欄位的模糊查詢 (LIKE 條件) 過濾
  #
  # @param objects [ActiveRecord::Relation]
  # @param col [String, Symbol] 欄位名稱
  # @param value [String] 模糊搜尋字串
  # @return [ActiveRecord::Relation]
  def filter_by_column_like(objects, col, value)
    if value.present? && objects.column_names.include?(col)
      sql_condition = objects.arel_table[col.to_sym].matches("%#{value}%")
      objects = objects.where(sql_condition)
    end
    objects
  end
end
