class User < ApplicationRecord
  belongs_to :permission

  enumerize :state, in: ModelEnum.user_state_enum

  validates :account, presence: true,
                      uniqueness: { case_sensitive: false }

  has_secure_password

  def active?
    !state.disable?
  end
end
