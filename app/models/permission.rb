class Permission < ApplicationRecord
  serialize :content, coder: JSON
  enumerize :state, in: ModelEnum.data_state_enum

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def allowed?(module_key, action_key = "search")
    return false if content.nil? || state == "disable"

    content.dig(module_key, action_key) == "1"
  end
end
