class User::List < Actor
  output :users
  output :setting_users

  play :grep_users,
       :grep_setting_users

  def grep_users
    users = User.where(state: %w[enable])
    self.users = users
  end

  def grep_setting_users
    users = User.where(state: %w[enable disable])
    self.setting_users = users.order(state: :desc)
  end
end
