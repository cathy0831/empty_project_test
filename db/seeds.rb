Seed_Logger = Logger.new($stdout)

load Rails.root.join("db/seeds/permissions.rb")
load Rails.root.join("db/seeds/users.rb")

# 開發測試seed
if Rails.env.development?
  # TODO
end
