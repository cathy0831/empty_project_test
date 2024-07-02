# Use this file to easily define all of your cron jobs.
require "rake"

set :output, { error: "log/whenever_error.log",
               standard: "log/whenever.log" }
env :PATH, ENV.fetch("PATH", nil)

every 1.day do
  rake "backup_func:log_rotate"
  rake "backup_func:remove_files"
end
