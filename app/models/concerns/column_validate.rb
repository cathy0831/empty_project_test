module ColumnValidate
  extend ActiveSupport::Concern

  included do
    before_validation :validate_columns_limits
  end

  private

  def validate_columns_limits
    self.class.columns_hash.each do |column_name, column| # rubocop:disable Metrics/BlockLength
      case column.type
      when :string
        validates_string(column_name)
      when :text
        validates_text(column_name)
      when :integer
        validates_integer(column_name)
      when :float
        validates_float(column_name)
      when :decimal
        validates_decimal(column_name, column)
      end
    end
  end

  def validates_string(column_name)
    self.class.validates(column_name, length: { maximum: 255 })
  end

  def validates_text(column_name)
    self.class.validates(column_name, length: { maximum: 65_535 })
  end

  def validates_integer(column_name)
    return if auto_generated_column.include?(column_name)

    self.class.validates(column_name, numericality: { less_than_or_equal_to: 2_147_483_647, allow_nil: true })
  end

  def auto_generated_column
    %w[id state die_type] + self.class.reflect_on_all_associations.map(&:foreign_key)
  end

  def validates_float(column_name)
    self.class.validates(column_name, numericality: { less_than_or_equal_to: Float::MAX, allow_nil: true })
  end

  def validates_decimal(column_name, column)
    precision, scale = get_precision_and_scale(column)
    max_value = calculate_decimal_max_value(precision, scale)
    self.class.validates(column_name, numericality: { less_than_or_equal_to: max_value, allow_nil: true })
  end

  def get_precision_and_scale(sql_column)
    if sql_column.precision.nil? || sql_column.scale.nil?
      precision = sql_column.sql_type[8].to_i
      scale = sql_column.sql_type[10].to_i
    else
      precision = sql_column.precision || 10
      scale = sql_column.scale || 2
    end
    [precision, scale]
  end

  def calculate_decimal_max_value(precision, scale)
    integer = 10**(precision - scale)
    decimal = 10**-scale
    (integer - decimal).to_f
  end
end
