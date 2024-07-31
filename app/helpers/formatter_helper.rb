module FormatterHelper
  def format_number(number, precision = 4)
    return "" if number.nil?

    number_with_precision(number, precision:, strip_insignificant_zeros: true, delimiter: ",")
  end

  def format_date(time = nil)
    localize_date_time(time, "%F")
  end

  def format_time(time = nil)
    localize_date_time(time, "%T")
  end

  def format_date_time(time = nil)
    localize_date_time(time, "%F %T")
  end

  def localize_date_time(time = nil, mask = "%Y/%m/%d %H:%M:%S")
    if time
      case time
      when String
        time
      when Date, Time, DateTime
        localize(time, format: mask)
      else
        "- -"
      end
    else
      "- -"
    end
  end
end
