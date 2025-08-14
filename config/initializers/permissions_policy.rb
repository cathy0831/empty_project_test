# Define an application-wide HTTP permissions policy. For further
# information see https://developers.google.com/web/updates/2018/06/feature-policy
#
# Rails.application.config.permissions_policy do |f|
#   f.camera      :none
#   f.gyroscope   :none
#   f.microphone  :none
#   f.usb         :none
#   f.fullscreen  :self
#   f.payment     :self, "https://secure.example.com"
# end
PERMISSION_ITEMS = [
  { module: "user", actions: %w[search edit] },
  { module: "permission", actions: %w[search edit] },
].freeze

SETTING_MODULES = %w[user permission].freeze
