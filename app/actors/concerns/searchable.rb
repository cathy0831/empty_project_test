module Searchable
  extend ActiveSupport::Concern

  def filter_by_column(objects, col, value)
    if value.present? && objects.column_names.include?(col)
      sql_condition = objects.arel_table[col.to_sym].eq(value)
      objects = objects.where(sql_condition)
    end
    objects
  end

  def filter_by_column_in(objects, col, ids)
    if ids.present? && ids.is_a?(Array) && objects.column_names.include?(col)
      sql_condition = objects.arel_table[col.to_sym].in(ids)
      objects = objects.where(sql_condition)
    end
    objects
  end

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

  def filter_by_column_like(objects, col, value)
    if value.present? && objects.column_names.include?(col)
      sql_condition = objects.arel_table[col.to_sym].matches("%#{value}%")
      objects = objects.where(sql_condition)
    end
    objects
  end
end
