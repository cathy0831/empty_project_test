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
    if start_value.present? && end_value.present? && objects.column_names.include?(col)
      sym_col = col.to_sym
      sql_condition = objects.arel_table[sym_col].gteq(start_value)
      sql_condition = sql_condition.and(objects.arel_table[sym_col].lteq(end_value))
      objects = objects.where(sql_condition)
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

  def filter_by_date(objects, col, date)
    if date.present?
      if date["start"].present?
        start_time = date["start"].to_date
        objects = objects.where("#{col} >= ?", start_time)
      end

      if date["end"].present?
        end_time = date["end"].to_date
        objects = objects.where("#{col} <= ?", end_time)
      end
    end
    objects
  end

  def filter_by_datetime(objects, col, date)
    if date.present?
      if date["start"].present?
        start_time = date["start"].to_datetime.beginning_of_day
        objects = objects.where("#{col} >= ?", start_time)
      end

      if date["end"].present?
        end_time = date["end"].to_datetime.end_of_day
        objects = objects.where("#{col} <= ?", end_time)
      end
    end
    objects
  end
end
