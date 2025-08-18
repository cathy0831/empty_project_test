class User::Find < Actor
  input :user_id

  output :user

  def call
    user = User.find_by(id: user_id)
    self.user = user
  end
end
