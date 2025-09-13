module Exportable
  extend ActiveSupport::Concern

  # 取得物件某個欄位的輸出值
  # - 若欄位有 enumerize (枚舉)，則回傳對應的文字 (_text)
  # - 若欄位是關聯 (ex: "user.name")，則取出關聯物件的屬性
  # - 否則直接回傳該物件的屬性值
  #
  # @param object [ActiveRecord::Base] 要處理的資料物件
  # @param column [String, Symbol] 欄位名稱 (支援 "association.attribute" 格式)
  # @return [String, Object] 欄位的輸出值
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

  # 建立匯出檔案的路徑與檔名
  # - 預設輸出目錄: Rails.root/tmp/excel
  # - 檔案類型: xlsx
  # - 檔名規則: name + 日期(可選) + 隨機字串 + 副檔名
  #
  # @param name [String] 基本檔名
  # @param time [Time, Date, nil] 時間戳記 (會加在檔名中，格式: _YYYYMMDD)，預設空
  # @return [Array<String>] [檔案完整路徑, 檔名]
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
