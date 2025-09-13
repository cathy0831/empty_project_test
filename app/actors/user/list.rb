class User::List < Actor
  include Searchable

  input :type, default: -> { "general" }
  input :account, default: nil
  input :name, default: nil

  output :users

  play :grep_users, if: ->(actor) { actor.type.eql? "general" }

  play :grep_setting_users, if: ->(actor) { actor.type.eql? "setting" }

  def grep_users
    users = User.where(state: %w[enable])
    self.users = users
  end

  def grep_setting_users
    users = User.where(state: %w[enable disable])
    users = filter_by_column_like(users, "account", account)
    users = filter_by_column_like(users, "name", name)

    self.users = users.order(state: :desc)
  end
end
