Error_Logger = Logger.new(Rails.root.join("log/error.log"), "weekly")

Error_Logger.datetime_format = "%Y-%m-%d %H:%M:%S"
