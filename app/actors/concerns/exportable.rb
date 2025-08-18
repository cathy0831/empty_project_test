module Exportable
  extend ActiveSupport::Concern

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
    path = Rails.root.join("tmp/excel").to_s

    Dir.mkdir(path) unless File.directory?(path)

    random = "_#{(0...5).map { ('a'..'z').to_a[rand(26)] }.join}"
    time_str = time.present? ? time.strftime("_%Y%m%d") : ""

    file_name = "#{name}#{time_str}#{random}.#{type}"
    file_path = File.join(path, file_name)

    [file_path, file_name]
  end
end
