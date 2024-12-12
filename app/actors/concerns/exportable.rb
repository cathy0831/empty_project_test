module Exportable
  extend ActiveSupport::Concern

  def grep_sheet_name(sheet_type)
    sheet_type = sheet_type.to_i
    if WORKSHEET_TYPES.key(sheet_type)
      WORKSHEET_TYPES.key(sheet_type).to_s
    elsif RECORD_TYPES.key(sheet_type)
      RECORD_TYPES.key(sheet_type).to_s
    else
      sheet_type.to_s
    end
  end

  def grep_column_data(object, column)
    if object.class.enumerized_attributes[column].present?
      object.send("#{column}_text")
    else
      association, attribute = column.to_s.split(".")
      if attribute.nil?
        object.send(column)
      else
        relate_object = object.send(association)
        relate_object.send(attribute)
      end
    end
  end

  def get_file_name(name, time = "")
    type = "xlsx"
    path = "tmp/excel/"

    random = (0...5).map { ("a".."z").to_a[rand(26)] }.join
    time = time.blank? ? "" : time.strftime("_%Y%m%d_#{random}")

    Dir.mkdir path unless File.directory?(path)
    path = "#{path}/" unless path.match("/$")

    file_path = "#{path}#{name}#{time}.#{type}"
    file_name = "#{name}#{time}.#{type}"
    [file_path, file_name]
  end
end
