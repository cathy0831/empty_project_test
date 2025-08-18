class User < ApplicationRecord
  enumerize :state, in: ModelEnum.user_state_enum

  belongs_to :permission

  validates :account, presence: true,
                      uniqueness: { case_sensitive: false }

  has_secure_password

  def active?
    !state.disable?
  end
end
