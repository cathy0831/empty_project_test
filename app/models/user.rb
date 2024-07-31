class User < ApplicationRecord
  enumerize :state, in: ModelEnum.data_states_enum

  validates :account, presence: true,
                      uniqueness: { case_sensitive: false }

  has_secure_password

  def enable?
    state != "disable"
  end
end
